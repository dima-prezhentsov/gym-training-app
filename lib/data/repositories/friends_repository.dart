import '../../domain/models/friend_connection.dart';
import '../../domain/models/progress_overview.dart';
import '../../domain/models/workout_record.dart';

abstract interface class FriendsRepository {
  Future<List<FriendConnection>> list();
  Future<FriendInvite> createInvite();
  Future<FriendConnection> redeemInvite(String code);
  Future<FriendConnection> accept(String userId);
  Future<void> decline(String userId);
  Future<void> remove(String userId);
  Future<FriendConnection> setSharing(
    String userId, {
    required bool stats,
    required bool history,
  });
  Future<ProgressOverview> loadProgress(String userId, ProgressPeriod period);
  Future<List<WorkoutRecord>> loadHistory(String userId);
}
