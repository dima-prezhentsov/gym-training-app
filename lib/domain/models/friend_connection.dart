class FriendConnection {
  const FriendConnection({
    required this.userId,
    required this.displayName,
    this.username,
    required this.status,
    required this.isIncoming,
    required this.sharesStats,
    required this.sharesHistory,
    this.sharesActivity = false,
    required this.canViewStats,
    required this.canViewHistory,
    this.canViewActivity = false,
    this.isTraining = false,
  });

  final String userId;
  final String displayName;
  final String? username;
  final String status;
  final bool isIncoming;
  final bool sharesStats;
  final bool sharesHistory;
  final bool sharesActivity;
  final bool canViewStats;
  final bool canViewHistory;
  final bool canViewActivity;
  final bool isTraining;

  bool get isAccepted => status == 'accepted';

  FriendConnection copyWith({
    String? status,
    bool? isIncoming,
    bool? sharesStats,
    bool? sharesHistory,
    bool? sharesActivity,
    bool? canViewStats,
    bool? canViewHistory,
    bool? canViewActivity,
    bool? isTraining,
  }) => FriendConnection(
    userId: userId,
    displayName: displayName,
    username: username,
    status: status ?? this.status,
    isIncoming: isIncoming ?? this.isIncoming,
    sharesStats: sharesStats ?? this.sharesStats,
    sharesHistory: sharesHistory ?? this.sharesHistory,
    sharesActivity: sharesActivity ?? this.sharesActivity,
    canViewStats: canViewStats ?? this.canViewStats,
    canViewHistory: canViewHistory ?? this.canViewHistory,
    canViewActivity: canViewActivity ?? this.canViewActivity,
    isTraining: isTraining ?? this.isTraining,
  );
}

class FriendInvite {
  const FriendInvite({required this.code, required this.expiresAt});

  final String code;
  final DateTime expiresAt;
}
