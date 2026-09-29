class FriendConnection {
  const FriendConnection({
    required this.userId,
    required this.displayName,
    this.username,
    required this.status,
    required this.isIncoming,
    required this.sharesStats,
    required this.sharesHistory,
    required this.canViewStats,
    required this.canViewHistory,
  });

  final String userId;
  final String displayName;
  final String? username;
  final String status;
  final bool isIncoming;
  final bool sharesStats;
  final bool sharesHistory;
  final bool canViewStats;
  final bool canViewHistory;

  bool get isAccepted => status == 'accepted';

  FriendConnection copyWith({
    String? status,
    bool? isIncoming,
    bool? sharesStats,
    bool? sharesHistory,
    bool? canViewStats,
    bool? canViewHistory,
  }) => FriendConnection(
    userId: userId,
    displayName: displayName,
    username: username,
    status: status ?? this.status,
    isIncoming: isIncoming ?? this.isIncoming,
    sharesStats: sharesStats ?? this.sharesStats,
    sharesHistory: sharesHistory ?? this.sharesHistory,
    canViewStats: canViewStats ?? this.canViewStats,
    canViewHistory: canViewHistory ?? this.canViewHistory,
  );
}

class FriendInvite {
  const FriendInvite({required this.code, required this.expiresAt});

  final String code;
  final DateTime expiresAt;
}
