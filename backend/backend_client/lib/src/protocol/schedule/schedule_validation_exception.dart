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

/// The submitted schedule aggregate contains invalid or duplicate data.
abstract class ScheduleValidationException
    implements _i1.SerializableException, _i1.SerializableModel {
  ScheduleValidationException._({required this.reason});

  factory ScheduleValidationException({required String reason}) =
      _ScheduleValidationExceptionImpl;

  factory ScheduleValidationException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScheduleValidationException(
      reason: jsonSerialization['reason'] as String,
    );
  }

  String reason;

  /// Returns a shallow copy of this [ScheduleValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduleValidationException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScheduleValidationException',
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'ScheduleValidationException(reason: $reason)';
  }
}

class _ScheduleValidationExceptionImpl extends ScheduleValidationException {
  _ScheduleValidationExceptionImpl({required String reason})
    : super._(reason: reason);

  /// Returns a shallow copy of this [ScheduleValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduleValidationException copyWith({String? reason}) {
    return ScheduleValidationException(reason: reason ?? this.reason);
  }
}
