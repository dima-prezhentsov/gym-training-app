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
import '../schedule/exercise_dto.dart' as _i2;
import 'package:backend_client/src/protocol/protocol.dart' as _i3;

/// API representation of a training day.
abstract class TrainingDayDto implements _i1.SerializableModel {
  TrainingDayDto._({
    required this.id,
    required this.name,
    required this.weekday,
    required this.estimatedDurationMinutes,
    required this.exercises,
  });

  factory TrainingDayDto({
    required String id,
    required String name,
    required int weekday,
    required int estimatedDurationMinutes,
    required List<_i2.ExerciseDto> exercises,
  }) = _TrainingDayDtoImpl;

  factory TrainingDayDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingDayDto(
      id: jsonSerialization['id'] as String,
      name: jsonSerialization['name'] as String,
      weekday: jsonSerialization['weekday'] as int,
      estimatedDurationMinutes:
          jsonSerialization['estimatedDurationMinutes'] as int,
      exercises: _i3.Protocol().deserialize<List<_i2.ExerciseDto>>(
        jsonSerialization['exercises'],
      ),
    );
  }

  String id;

  String name;

  int weekday;

  int estimatedDurationMinutes;

  List<_i2.ExerciseDto> exercises;

  /// Returns a shallow copy of this [TrainingDayDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingDayDto copyWith({
    String? id,
    String? name,
    int? weekday,
    int? estimatedDurationMinutes,
    List<_i2.ExerciseDto>? exercises,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingDayDto',
      'id': id,
      'name': name,
      'weekday': weekday,
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'exercises': exercises.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TrainingDayDtoImpl extends TrainingDayDto {
  _TrainingDayDtoImpl({
    required String id,
    required String name,
    required int weekday,
    required int estimatedDurationMinutes,
    required List<_i2.ExerciseDto> exercises,
  }) : super._(
         id: id,
         name: name,
         weekday: weekday,
         estimatedDurationMinutes: estimatedDurationMinutes,
         exercises: exercises,
       );

  /// Returns a shallow copy of this [TrainingDayDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingDayDto copyWith({
    String? id,
    String? name,
    int? weekday,
    int? estimatedDurationMinutes,
    List<_i2.ExerciseDto>? exercises,
  }) {
    return TrainingDayDto(
      id: id ?? this.id,
      name: name ?? this.name,
      weekday: weekday ?? this.weekday,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      exercises:
          exercises ?? this.exercises.map((e0) => e0.copyWith()).toList(),
    );
  }
}
