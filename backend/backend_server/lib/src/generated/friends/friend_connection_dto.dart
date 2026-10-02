/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;

abstract class FriendConnectionDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FriendConnectionDto._({
    required this.userId,
    required this.displayName,
    this.username,
    required this.status,
    required this.isIncoming,
    required this.sharesStats,
    required this.sharesHistory,
    required this.sharesActivity,
    required this.canViewStats,
    required this.canViewHistory,
    required this.canViewActivity,
    required this.isTraining,
  });

  factory FriendConnectionDto({
    required String userId,
    required String displayName,
    String? username,
    required String status,
    required bool isIncoming,
    required bool sharesStats,
    required bool sharesHistory,
    required bool sharesActivity,
    required bool canViewStats,
    required bool canViewHistory,
    required bool canViewActivity,
    required bool isTraining,
  }) = _FriendConnectionDtoImpl;

  factory FriendConnectionDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return FriendConnectionDto(
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      username: jsonSerialization['username'] as String?,
      status: jsonSerialization['status'] as String,
      isIncoming: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isIncoming'],
      ),
      sharesStats: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['sharesStats'],
      ),
      sharesHistory: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['sharesHistory'],
      ),
      sharesActivity: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['sharesActivity'],
      ),
      canViewStats: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['canViewStats'],
      ),
      canViewHistory: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['canViewHistory'],
      ),
      canViewActivity: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['canViewActivity'],
      ),
      isTraining: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isTraining'],
      ),
    );
  }

  String userId;

  String displayName;

  String? username;

  String status;

  bool isIncoming;

  bool sharesStats;

  bool sharesHistory;

  bool sharesActivity;

  bool canViewStats;

  bool canViewHistory;

  bool canViewActivity;

  bool isTraining;

  /// Returns a shallow copy of this [FriendConnectionDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FriendConnectionDto copyWith({
    String? userId,
    String? displayName,
    String? username,
    String? status,
    bool? isIncoming,
    bool? sharesStats,
    bool? sharesHistory,
    bool? sharesActivity,
    bool? canViewStats,
    bool? canViewHistory,
    bool? canViewActivity,
    bool? isTraining,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FriendConnectionDto',
      'userId': userId,
      'displayName': displayName,
      if (username != null) 'username': username,
      'status': status,
      'isIncoming': isIncoming,
      'sharesStats': sharesStats,
      'sharesHistory': sharesHistory,
      'sharesActivity': sharesActivity,
      'canViewStats': canViewStats,
      'canViewHistory': canViewHistory,
      'canViewActivity': canViewActivity,
      'isTraining': isTraining,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FriendConnectionDto',
      'userId': userId,
      'displayName': displayName,
      if (username != null) 'username': username,
      'status': status,
      'isIncoming': isIncoming,
      'sharesStats': sharesStats,
      'sharesHistory': sharesHistory,
      'sharesActivity': sharesActivity,
      'canViewStats': canViewStats,
      'canViewHistory': canViewHistory,
      'canViewActivity': canViewActivity,
      'isTraining': isTraining,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FriendConnectionDtoImpl extends FriendConnectionDto {
  _FriendConnectionDtoImpl({
    required String userId,
    required String displayName,
    String? username,
    required String status,
    required bool isIncoming,
    required bool sharesStats,
    required bool sharesHistory,
    required bool sharesActivity,
    required bool canViewStats,
    required bool canViewHistory,
    required bool canViewActivity,
    required bool isTraining,
  }) : super._(
         userId: userId,
         displayName: displayName,
         username: username,
         status: status,
         isIncoming: isIncoming,
         sharesStats: sharesStats,
         sharesHistory: sharesHistory,
         sharesActivity: sharesActivity,
         canViewStats: canViewStats,
         canViewHistory: canViewHistory,
         canViewActivity: canViewActivity,
         isTraining: isTraining,
       );

  /// Returns a shallow copy of this [FriendConnectionDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FriendConnectionDto copyWith({
    String? userId,
    String? displayName,
    Object? username = _Undefined,
    String? status,
    bool? isIncoming,
    bool? sharesStats,
    bool? sharesHistory,
    bool? sharesActivity,
    bool? canViewStats,
    bool? canViewHistory,
    bool? canViewActivity,
    bool? isTraining,
  }) {
    return FriendConnectionDto(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      username: username is String? ? username : this.username,
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
}
