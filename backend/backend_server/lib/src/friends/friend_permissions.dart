import '../generated/protocol.dart';

bool isAcceptedFriend(FriendshipEntity friendship) =>
    friendship.status == 'accepted';

bool canViewFriendStats(FriendshipEntity friendship, bool viewerIsA) =>
    isAcceptedFriend(friendship) &&
    (viewerIsA ? friendship.bSharesStats : friendship.aSharesStats);

bool canViewFriendHistory(FriendshipEntity friendship, bool viewerIsA) =>
    isAcceptedFriend(friendship) &&
    (viewerIsA ? friendship.bSharesHistory : friendship.aSharesHistory);

bool canViewFriendActivity(FriendshipEntity friendship, bool viewerIsA) =>
    isAcceptedFriend(friendship) &&
    (viewerIsA ? friendship.bSharesActivity : friendship.aSharesActivity);
