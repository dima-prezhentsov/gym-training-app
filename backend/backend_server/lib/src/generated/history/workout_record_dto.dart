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
import '../history/exercise_record_dto.dart' as _i2;
import 'package:backend_server/src/generated/protocol.dart' as _i3;

abstract class WorkoutRecordDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  WorkoutRecordDto._({
    required this.id,
    required this.trainingDayId,
    required this.title,
    required this.startedAt,
    required this.completedAt,
    required this.exercises,
  });

  factory WorkoutRecordDto({
    required String id,
    required String trainingDayId,
    required String title,
    required DateTime startedAt,
    required DateTime completedAt,
    required List<_i2.ExerciseRecordDto> exercises,
  }) = _WorkoutRecordDtoImpl;

  factory WorkoutRecordDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutRecordDto(
      id: jsonSerialization['id'] as String,
      trainingDayId: jsonSerialization['trainingDayId'] as String,
      title: jsonSerialization['title'] as String,
      startedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      completedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
      exercises: _i3.Protocol().deserialize<List<_i2.ExerciseRecordDto>>(
        jsonSerialization['exercises'],
      ),
    );
  }

  String id;

  String trainingDayId;

  String title;

  DateTime startedAt;

  DateTime completedAt;

  List<_i2.ExerciseRecordDto> exercises;

  /// Returns a shallow copy of this [WorkoutRecordDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutRecordDto copyWith({
    String? id,
    String? trainingDayId,
    String? title,
    DateTime? startedAt,
    DateTime? completedAt,
    List<_i2.ExerciseRecordDto>? exercises,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutRecordDto',
      'id': id,
      'trainingDayId': trainingDayId,
      'title': title,
      'startedAt': startedAt.toJson(),
      'completedAt': completedAt.toJson(),
      'exercises': exercises.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutRecordDto',
      'id': id,
      'trainingDayId': trainingDayId,
      'title': title,
      'startedAt': startedAt.toJson(),
      'completedAt': completedAt.toJson(),
      'exercises': exercises.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _WorkoutRecordDtoImpl extends WorkoutRecordDto {
  _WorkoutRecordDtoImpl({
    required String id,
    required String trainingDayId,
    required String title,
    required DateTime startedAt,
    required DateTime completedAt,
    required List<_i2.ExerciseRecordDto> exercises,
  }) : super._(
         id: id,
         trainingDayId: trainingDayId,
         title: title,
         startedAt: startedAt,
         completedAt: completedAt,
         exercises: exercises,
       );

  /// Returns a shallow copy of this [WorkoutRecordDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutRecordDto copyWith({
    String? id,
    String? trainingDayId,
    String? title,
    DateTime? startedAt,
    DateTime? completedAt,
    List<_i2.ExerciseRecordDto>? exercises,
  }) {
    return WorkoutRecordDto(
      id: id ?? this.id,
      trainingDayId: trainingDayId ?? this.trainingDayId,
      title: title ?? this.title,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      exercises:
          exercises ?? this.exercises.map((e0) => e0.copyWith()).toList(),
    );
  }
}
