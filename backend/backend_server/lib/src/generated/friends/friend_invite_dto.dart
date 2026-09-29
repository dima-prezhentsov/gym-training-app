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

abstract class FriendInviteDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FriendInviteDto._({
    required this.code,
    required this.expiresAt,
  });

  factory FriendInviteDto({
    required String code,
    required DateTime expiresAt,
  }) = _FriendInviteDtoImpl;

  factory FriendInviteDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return FriendInviteDto(
      code: jsonSerialization['code'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  String code;

  DateTime expiresAt;

  /// Returns a shallow copy of this [FriendInviteDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FriendInviteDto copyWith({
    String? code,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FriendInviteDto',
      'code': code,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FriendInviteDto',
      'code': code,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FriendInviteDtoImpl extends FriendInviteDto {
  _FriendInviteDtoImpl({
    required String code,
    required DateTime expiresAt,
  }) : super._(
         code: code,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [FriendInviteDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FriendInviteDto copyWith({
    String? code,
    DateTime? expiresAt,
  }) {
    return FriendInviteDto(
      code: code ?? this.code,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
