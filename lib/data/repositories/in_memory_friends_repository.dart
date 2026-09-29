import '../../domain/models/friend_connection.dart';
import '../../domain/models/progress_overview.dart';
import '../../domain/models/workout_record.dart';
import '../fixtures/demo_friend_history.dart';
import '../fixtures/demo_training_schedule.dart';
import 'friends_repository.dart';
import 'progress_calculator.dart';

class InMemoryFriendsRepository implements FriendsRepository {
  InMemoryFriendsRepository({DateTime Function()? now})
    : _now = now ?? DateTime.now,
      _history = buildDemoFriendHistory(now: (now ?? DateTime.now)());

  final DateTime Function() _now;
  final List<WorkoutRecord> _history;
  final _connections = <String, FriendConnection>{
    'demo-anna': const FriendConnection(
      userId: 'demo-anna',
      displayName: 'Анна',
      username: 'anna_demo',
      status: 'accepted',
      isIncoming: false,
      sharesStats: false,
      sharesHistory: false,
      canViewStats: true,
      canViewHistory: true,
    ),
    'demo-max': const FriendConnection(
      userId: 'demo-max',
      displayName: 'Максим',
      username: 'max_demo',
      status: 'pending',
      isIncoming: true,
      sharesStats: false,
      sharesHistory: false,
      canViewStats: false,
      canViewHistory: false,
    ),
  };

  @override
  Future<List<FriendConnection>> list() async =>
      List.unmodifiable(_connections.values);

  @override
  Future<FriendInvite> createInvite() async => FriendInvite(
    code: 'demo-invite',
    expiresAt: _now().add(const Duration(days: 7)),
  );

  @override
  Future<FriendConnection> redeemInvite(String code) async {
    if (code.isEmpty) throw StateError('invalidInvite');
    const friend = FriendConnection(
      userId: 'demo-new-friend',
      displayName: 'Новый друг',
      status: 'pending',
      isIncoming: false,
      sharesStats: false,
      sharesHistory: false,
      canViewStats: false,
      canViewHistory: false,
    );
    _connections[friend.userId] = friend;
    return friend;
  }

  @override
  Future<FriendConnection> accept(String userId) async {
    final current = _require(userId);
    if (!current.isIncoming || current.isAccepted) {
      throw StateError('notIncomingRequest');
    }
    return _connections[userId] = current.copyWith(
      status: 'accepted',
      isIncoming: false,
    );
  }

  @override
  Future<void> decline(String userId) async {
    final current = _require(userId);
    if (!current.isIncoming || current.isAccepted) {
      throw StateError('notIncomingRequest');
    }
    _connections.remove(userId);
  }

  @override
  Future<void> remove(String userId) async {
    _require(userId);
    _connections.remove(userId);
  }

  @override
  Future<FriendConnection> setSharing(
    String userId, {
    required bool stats,
    required bool history,
  }) async {
    final current = _require(userId);
    if (!current.isAccepted) throw StateError('notFriends');
    return _connections[userId] = current.copyWith(
      sharesStats: stats,
      sharesHistory: history,
    );
  }

  @override
  Future<ProgressOverview> loadProgress(
    String userId,
    ProgressPeriod period,
  ) async {
    final friend = _require(userId);
    if (!friend.isAccepted || !friend.canViewStats) {
      throw StateError('statsPrivate');
    }
    return calculateProgressOverview(
      schedule: demoTrainingSchedule,
      history: _history,
      period: period,
      now: _now(),
    );
  }

  @override
  Future<List<WorkoutRecord>> loadHistory(String userId) async {
    final friend = _require(userId);
    if (!friend.isAccepted || !friend.canViewHistory) {
      throw StateError('historyPrivate');
    }
    return List.unmodifiable(_history);
  }

  FriendConnection _require(String userId) {
    final friend = _connections[userId];
    if (friend == null) throw StateError('notFriends');
    return friend;
  }
}
