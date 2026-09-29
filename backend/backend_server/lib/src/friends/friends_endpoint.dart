import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../history/workout_history_reader.dart';
import '../progress/progress_service.dart';
import 'friend_permissions.dart';

class FriendsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<FriendInviteDto> createInvite(Session session) async {
    final me = session.authenticated!.authUserId;
    final now = DateTime.now().toUtc();
    final existing = await FriendInviteEntity.db.findFirstRow(
      session,
      where: (table) =>
          table.creatorId.equals(me) &
          table.expiresAt.between(now, now.add(const Duration(days: 8))),
      orderBy: (table) => table.createdAt,
      orderDescending: true,
    );
    if (existing != null) {
      return FriendInviteDto(
        code: existing.code,
        expiresAt: existing.expiresAt,
      );
    }
    final random = Random.secure();
    final bytes = List<int>.generate(24, (_) => random.nextInt(256));
    final code = base64Url.encode(bytes).replaceAll('=', '');
    final invite = await FriendInviteEntity.db.insertRow(
      session,
      FriendInviteEntity(
        code: code,
        creatorId: me,
        expiresAt: now.add(const Duration(days: 7)),
      ),
    );
    return FriendInviteDto(code: invite.code, expiresAt: invite.expiresAt);
  }

  Future<FriendConnectionDto> redeemInvite(Session session, String code) async {
    if (!RegExp(r'^[A-Za-z0-9_-]{32}$').hasMatch(code)) {
      throw FriendAccessException(reason: 'invalidInvite');
    }
    final invite = await FriendInviteEntity.db.findFirstRow(
      session,
      where: (table) => table.code.equals(code),
    );
    if (invite == null || !invite.expiresAt.isAfter(DateTime.now().toUtc())) {
      throw FriendAccessException(reason: 'expiredInvite');
    }
    final me = session.authenticated!.authUserId;
    final other = invite.creatorId;
    if (me == other) throw FriendAccessException(reason: 'selfInvite');
    final pair = _orderedPair(me, other);
    var relation = await _findPair(session, me, other);
    relation ??= await FriendshipEntity.db.insertRow(
      session,
      FriendshipEntity(
        userAId: pair.$1,
        userBId: pair.$2,
        requestedById: me,
        status: 'pending',
        aSharesStats: false,
        aSharesHistory: false,
        bSharesStats: false,
        bSharesHistory: false,
      ),
    );
    return _toDto(session, relation, me);
  }

  Future<List<FriendConnectionDto>> list(Session session) async {
    final me = session.authenticated!.authUserId;
    final rows = await FriendshipEntity.db.find(
      session,
      where: (table) => table.userAId.equals(me) | table.userBId.equals(me),
      orderBy: (table) => table.createdAt,
      orderDescending: true,
    );
    final result = <FriendConnectionDto>[];
    for (final row in rows) {
      result.add(await _toDto(session, row, me));
    }
    return result;
  }

  Future<FriendConnectionDto> accept(Session session, String userId) async {
    final me = session.authenticated!.authUserId;
    final relation = await _requirePair(session, me, userId);
    if (relation.status != 'pending' || relation.requestedById == me) {
      throw FriendAccessException(reason: 'notIncomingRequest');
    }
    final accepted = await FriendshipEntity.db.updateRow(
      session,
      relation.copyWith(status: 'accepted', updatedAt: DateTime.now().toUtc()),
    );
    return _toDto(session, accepted, me);
  }

  Future<void> decline(Session session, String userId) async {
    final me = session.authenticated!.authUserId;
    final relation = await _requirePair(session, me, userId);
    if (relation.status != 'pending' || relation.requestedById == me) {
      throw FriendAccessException(reason: 'notIncomingRequest');
    }
    await FriendshipEntity.db.deleteRow(session, relation);
  }

  Future<void> remove(Session session, String userId) async {
    final me = session.authenticated!.authUserId;
    final relation = await _requirePair(session, me, userId);
    await FriendshipEntity.db.deleteRow(session, relation);
  }

  Future<FriendConnectionDto> setSharing(
    Session session,
    String userId, {
    required bool stats,
    required bool history,
  }) async {
    final me = session.authenticated!.authUserId;
    final relation = await _requirePair(session, me, userId);
    if (!isAcceptedFriend(relation)) {
      throw FriendAccessException(reason: 'notFriends');
    }
    final updated = await FriendshipEntity.db.updateRow(
      session,
      (relation.userAId == me
              ? relation.copyWith(aSharesStats: stats, aSharesHistory: history)
              : relation.copyWith(bSharesStats: stats, bSharesHistory: history))
          .copyWith(updatedAt: DateTime.now().toUtc()),
    );
    return _toDto(session, updated, me);
  }

  Future<ProgressOverviewDto> getProgress(
    Session session,
    String userId, {
    required String period,
  }) async {
    final me = session.authenticated!.authUserId;
    final relation = await _requirePair(session, me, userId);
    if (!canViewFriendStats(relation, relation.userAId == me)) {
      throw FriendAccessException(reason: 'statsPrivate');
    }
    final owner = _otherId(relation, me);
    final account = await TelegramAccount.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(owner),
    );
    return ProgressService.forUser(
      session,
      owner,
      period: period,
      utcOffsetMinutes: account?.utcOffsetMinutes ?? 0,
    );
  }

  Future<List<WorkoutRecordDto>> getHistory(
    Session session,
    String userId,
  ) async {
    final me = session.authenticated!.authUserId;
    final relation = await _requirePair(session, me, userId);
    if (!canViewFriendHistory(relation, relation.userAId == me)) {
      throw FriendAccessException(reason: 'historyPrivate');
    }
    return WorkoutHistoryReader.listForUser(session, _otherId(relation, me));
  }

  Future<FriendshipEntity> _requirePair(
    Session session,
    UuidValue me,
    String userId,
  ) async {
    final other = _parseUserId(userId);
    if (me == other) throw FriendAccessException(reason: 'self');
    final relation = await _findPair(session, me, other);
    if (relation == null) throw FriendAccessException(reason: 'notFriends');
    return relation;
  }

  UuidValue _parseUserId(String userId) {
    try {
      return UuidValue.withValidation(userId);
    } on FormatException {
      throw FriendAccessException(reason: 'invalidUser');
    }
  }

  (UuidValue, UuidValue) _orderedPair(UuidValue a, UuidValue b) =>
      a.toString().compareTo(b.toString()) < 0 ? (a, b) : (b, a);

  Future<FriendshipEntity?> _findPair(
    Session session,
    UuidValue a,
    UuidValue b,
  ) {
    final pair = _orderedPair(a, b);
    return FriendshipEntity.db.findFirstRow(
      session,
      where: (table) =>
          table.userAId.equals(pair.$1) & table.userBId.equals(pair.$2),
    );
  }

  UuidValue _otherId(FriendshipEntity relation, UuidValue me) =>
      relation.userAId == me ? relation.userBId : relation.userAId;

  Future<FriendConnectionDto> _toDto(
    Session session,
    FriendshipEntity relation,
    UuidValue me,
  ) async {
    final meIsA = relation.userAId == me;
    final other = await TelegramAccount.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(_otherId(relation, me)),
    );
    if (other == null) throw FriendAccessException(reason: 'accountMissing');
    final displayName = [
      other.firstName,
      other.lastName,
    ].whereType<String>().where((part) => part.isNotEmpty).join(' ');
    return FriendConnectionDto(
      userId: _otherId(relation, me).toString(),
      displayName: displayName,
      username: other.username,
      status: relation.status,
      isIncoming: relation.status == 'pending' && relation.requestedById != me,
      sharesStats: meIsA ? relation.aSharesStats : relation.bSharesStats,
      sharesHistory: meIsA ? relation.aSharesHistory : relation.bSharesHistory,
      canViewStats: canViewFriendStats(relation, meIsA),
      canViewHistory: canViewFriendHistory(relation, meIsA),
    );
  }
}
