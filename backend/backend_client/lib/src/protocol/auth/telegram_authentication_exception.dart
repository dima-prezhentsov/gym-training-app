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

import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// Authentication failed because Telegram launch data could not be trusted.
abstract class TelegramAuthenticationException
    implements _i1.SerializableException, _i1.SerializableModel {
  TelegramAuthenticationException._({required this.reason});

  factory TelegramAuthenticationException({required String reason}) =
      _TelegramAuthenticationExceptionImpl;

  factory TelegramAuthenticationException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TelegramAuthenticationException(
      reason: jsonSerialization['reason'] as String,
    );
  }

  String reason;

  /// Returns a shallow copy of this [TelegramAuthenticationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TelegramAuthenticationException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TelegramAuthenticationException',
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'TelegramAuthenticationException(reason: $reason)';
  }
}

class _TelegramAuthenticationExceptionImpl
    extends TelegramAuthenticationException {
  _TelegramAuthenticationExceptionImpl({required String reason})
    : super._(reason: reason);

  /// Returns a shallow copy of this [TelegramAuthenticationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TelegramAuthenticationException copyWith({String? reason}) {
    return TelegramAuthenticationException(reason: reason ?? this.reason);
  }
}
