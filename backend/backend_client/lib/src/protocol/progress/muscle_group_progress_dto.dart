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

abstract class MuscleGroupProgressDto implements _i1.SerializableModel {
  MuscleGroupProgressDto._({
    required this.group,
    required this.setCount,
  });

  factory MuscleGroupProgressDto({
    required String group,
    required int setCount,
  }) = _MuscleGroupProgressDtoImpl;

  factory MuscleGroupProgressDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MuscleGroupProgressDto(
      group: jsonSerialization['group'] as String,
      setCount: jsonSerialization['setCount'] as int,
    );
  }

  String group;

  int setCount;

  /// Returns a shallow copy of this [MuscleGroupProgressDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MuscleGroupProgressDto copyWith({
    String? group,
    int? setCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MuscleGroupProgressDto',
      'group': group,
      'setCount': setCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MuscleGroupProgressDtoImpl extends MuscleGroupProgressDto {
  _MuscleGroupProgressDtoImpl({
    required String group,
    required int setCount,
  }) : super._(
         group: group,
         setCount: setCount,
       );

  /// Returns a shallow copy of this [MuscleGroupProgressDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MuscleGroupProgressDto copyWith({
    String? group,
    int? setCount,
  }) {
    return MuscleGroupProgressDto(
      group: group ?? this.group,
      setCount: setCount ?? this.setCount,
    );
  }
}
