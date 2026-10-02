import 'package:backend_server/src/friends/friend_permissions.dart';
import 'package:backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  final a = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final b = UuidValue.fromString('00000000-0000-4000-8000-000000000002');

  FriendshipEntity friendship({required String status}) => FriendshipEntity(
    userAId: a,
    userBId: b,
    requestedById: a,
    status: status,
    aSharesStats: false,
    aSharesHistory: false,
    aSharesActivity: false,
    bSharesStats: true,
    bSharesHistory: false,
    bSharesActivity: true,
  );

  test('pending request grants neither statistics nor history', () {
    final pending = friendship(status: 'pending');
    expect(canViewFriendStats(pending, true), isFalse);
    expect(canViewFriendHistory(pending, true), isFalse);
    expect(canViewFriendActivity(pending, true), isFalse);
  });

  test('permissions are directional and independent', () {
    final accepted = friendship(status: 'accepted');
    expect(canViewFriendStats(accepted, true), isTrue);
    expect(canViewFriendHistory(accepted, true), isFalse);
    expect(canViewFriendActivity(accepted, true), isTrue);
    expect(canViewFriendStats(accepted, false), isFalse);
    expect(canViewFriendHistory(accepted, false), isFalse);
    expect(canViewFriendActivity(accepted, false), isFalse);
  });
}
