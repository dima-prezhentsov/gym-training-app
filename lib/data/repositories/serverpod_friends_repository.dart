import 'package:backend_client/backend_client.dart' as api;

import '../../domain/models/friend_connection.dart';
import '../../domain/models/progress_overview.dart';
import '../../domain/models/workout_record.dart';
import '../services/backend_session.dart';
import 'friends_repository.dart';
import 'serverpod_progress_repository.dart';
import 'serverpod_workout_repository.dart';

class ServerpodFriendsRepository implements FriendsRepository {
  ServerpodFriendsRepository(this._session);

  final BackendSession _session;

  Future<api.Client> get _client async {
    await _session.ready;
    final client = _session.client;
    if (client == null || !_session.isAuthenticated) {
      throw StateError('Backend session is not authenticated');
    }
    return client;
  }

  @override
  Future<List<FriendConnection>> list() async =>
      (await (await _client).friends.list()).map(_fromDto).toList();

  @override
  Future<FriendInvite> createInvite() async {
    final dto = await (await _client).friends.createInvite();
    return FriendInvite(code: dto.code, expiresAt: dto.expiresAt.toLocal());
  }

  @override
  Future<FriendConnection> redeemInvite(String code) async =>
      _fromDto(await (await _client).friends.redeemInvite(code));

  @override
  Future<FriendConnection> accept(String userId) async =>
      _fromDto(await (await _client).friends.accept(userId));

  @override
  Future<void> decline(String userId) async =>
      (await _client).friends.decline(userId);

  @override
  Future<void> remove(String userId) async =>
      (await _client).friends.remove(userId);

  @override
  Future<FriendConnection> setSharing(
    String userId, {
    required bool stats,
    required bool history,
    required bool activity,
  }) async => _fromDto(
    await (await _client).friends.setSharing(
      userId,
      stats: stats,
      history: history,
      activity: activity,
    ),
  );

  @override
  Future<ProgressOverview> loadProgress(
    String userId,
    ProgressPeriod period,
  ) async => progressOverviewFromDto(
    await (await _client).friends.getProgress(userId, period: period.name),
  );

  @override
  Future<List<WorkoutRecord>> loadHistory(String userId) async =>
      (await (await _client).friends.getHistory(
        userId,
      )).map(workoutRecordFromDto).toList();

  FriendConnection _fromDto(api.FriendConnectionDto dto) => FriendConnection(
    userId: dto.userId,
    displayName: dto.displayName,
    username: dto.username,
    status: dto.status,
    isIncoming: dto.isIncoming,
    sharesStats: dto.sharesStats,
    sharesHistory: dto.sharesHistory,
    sharesActivity: dto.sharesActivity,
    canViewStats: dto.canViewStats,
    canViewHistory: dto.canViewHistory,
    canViewActivity: dto.canViewActivity,
    isTraining: dto.isTraining,
  );
}
