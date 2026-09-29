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

abstract class PersonalRecordDto implements _i1.SerializableModel {
  PersonalRecordDto._({
    required this.exerciseId,
    required this.exerciseName,
    required this.weightKg,
    required this.repetitions,
    required this.estimatedMaxKg,
    required this.achievedAt,
  });

  factory PersonalRecordDto({
    required String exerciseId,
    required String exerciseName,
    required double weightKg,
    required int repetitions,
    required double estimatedMaxKg,
    required DateTime achievedAt,
  }) = _PersonalRecordDtoImpl;

  factory PersonalRecordDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return PersonalRecordDto(
      exerciseId: jsonSerialization['exerciseId'] as String,
      exerciseName: jsonSerialization['exerciseName'] as String,
      weightKg: (jsonSerialization['weightKg'] as num).toDouble(),
      repetitions: jsonSerialization['repetitions'] as int,
      estimatedMaxKg: (jsonSerialization['estimatedMaxKg'] as num).toDouble(),
      achievedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['achievedAt'],
      ),
    );
  }

  String exerciseId;

  String exerciseName;

  double weightKg;

  int repetitions;

  double estimatedMaxKg;

  DateTime achievedAt;

  /// Returns a shallow copy of this [PersonalRecordDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PersonalRecordDto copyWith({
    String? exerciseId,
    String? exerciseName,
    double? weightKg,
    int? repetitions,
    double? estimatedMaxKg,
    DateTime? achievedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PersonalRecordDto',
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'weightKg': weightKg,
      'repetitions': repetitions,
      'estimatedMaxKg': estimatedMaxKg,
      'achievedAt': achievedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PersonalRecordDtoImpl extends PersonalRecordDto {
  _PersonalRecordDtoImpl({
    required String exerciseId,
    required String exerciseName,
    required double weightKg,
    required int repetitions,
    required double estimatedMaxKg,
    required DateTime achievedAt,
  }) : super._(
         exerciseId: exerciseId,
         exerciseName: exerciseName,
         weightKg: weightKg,
         repetitions: repetitions,
         estimatedMaxKg: estimatedMaxKg,
         achievedAt: achievedAt,
       );

  /// Returns a shallow copy of this [PersonalRecordDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PersonalRecordDto copyWith({
    String? exerciseId,
    String? exerciseName,
    double? weightKg,
    int? repetitions,
    double? estimatedMaxKg,
    DateTime? achievedAt,
  }) {
    return PersonalRecordDto(
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      weightKg: weightKg ?? this.weightKg,
      repetitions: repetitions ?? this.repetitions,
      estimatedMaxKg: estimatedMaxKg ?? this.estimatedMaxKg,
      achievedAt: achievedAt ?? this.achievedAt,
    );
  }
}
