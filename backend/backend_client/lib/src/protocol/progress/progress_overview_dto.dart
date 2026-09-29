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
import '../progress/exercise_progress_dto.dart' as _i2;
import '../progress/muscle_group_progress_dto.dart' as _i3;
import '../progress/personal_record_dto.dart' as _i4;
import 'package:backend_client/src/protocol/protocol.dart' as _i5;

abstract class ProgressOverviewDto implements _i1.SerializableModel {
  ProgressOverviewDto._({
    required this.currentStreakDays,
    required this.bestStreakDays,
    required this.workoutCount,
    required this.totalMinutes,
    required this.totalSets,
    required this.exercises,
    required this.muscleGroups,
    required this.personalRecords,
  });

  factory ProgressOverviewDto({
    required int currentStreakDays,
    required int bestStreakDays,
    required int workoutCount,
    required int totalMinutes,
    required int totalSets,
    required List<_i2.ExerciseProgressDto> exercises,
    required List<_i3.MuscleGroupProgressDto> muscleGroups,
    required List<_i4.PersonalRecordDto> personalRecords,
  }) = _ProgressOverviewDtoImpl;

  factory ProgressOverviewDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProgressOverviewDto(
      currentStreakDays: jsonSerialization['currentStreakDays'] as int,
      bestStreakDays: jsonSerialization['bestStreakDays'] as int,
      workoutCount: jsonSerialization['workoutCount'] as int,
      totalMinutes: jsonSerialization['totalMinutes'] as int,
      totalSets: jsonSerialization['totalSets'] as int,
      exercises: _i5.Protocol().deserialize<List<_i2.ExerciseProgressDto>>(
        jsonSerialization['exercises'],
      ),
      muscleGroups: _i5.Protocol()
          .deserialize<List<_i3.MuscleGroupProgressDto>>(
            jsonSerialization['muscleGroups'],
          ),
      personalRecords: _i5.Protocol().deserialize<List<_i4.PersonalRecordDto>>(
        jsonSerialization['personalRecords'],
      ),
    );
  }

  int currentStreakDays;

  int bestStreakDays;

  int workoutCount;

  int totalMinutes;

  int totalSets;

  List<_i2.ExerciseProgressDto> exercises;

  List<_i3.MuscleGroupProgressDto> muscleGroups;

  List<_i4.PersonalRecordDto> personalRecords;

  /// Returns a shallow copy of this [ProgressOverviewDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProgressOverviewDto copyWith({
    int? currentStreakDays,
    int? bestStreakDays,
    int? workoutCount,
    int? totalMinutes,
    int? totalSets,
    List<_i2.ExerciseProgressDto>? exercises,
    List<_i3.MuscleGroupProgressDto>? muscleGroups,
    List<_i4.PersonalRecordDto>? personalRecords,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProgressOverviewDto',
      'currentStreakDays': currentStreakDays,
      'bestStreakDays': bestStreakDays,
      'workoutCount': workoutCount,
      'totalMinutes': totalMinutes,
      'totalSets': totalSets,
      'exercises': exercises.toJson(valueToJson: (v) => v.toJson()),
      'muscleGroups': muscleGroups.toJson(valueToJson: (v) => v.toJson()),
      'personalRecords': personalRecords.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ProgressOverviewDtoImpl extends ProgressOverviewDto {
  _ProgressOverviewDtoImpl({
    required int currentStreakDays,
    required int bestStreakDays,
    required int workoutCount,
    required int totalMinutes,
    required int totalSets,
    required List<_i2.ExerciseProgressDto> exercises,
    required List<_i3.MuscleGroupProgressDto> muscleGroups,
    required List<_i4.PersonalRecordDto> personalRecords,
  }) : super._(
         currentStreakDays: currentStreakDays,
         bestStreakDays: bestStreakDays,
         workoutCount: workoutCount,
         totalMinutes: totalMinutes,
         totalSets: totalSets,
         exercises: exercises,
         muscleGroups: muscleGroups,
         personalRecords: personalRecords,
       );

  /// Returns a shallow copy of this [ProgressOverviewDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProgressOverviewDto copyWith({
    int? currentStreakDays,
    int? bestStreakDays,
    int? workoutCount,
    int? totalMinutes,
    int? totalSets,
    List<_i2.ExerciseProgressDto>? exercises,
    List<_i3.MuscleGroupProgressDto>? muscleGroups,
    List<_i4.PersonalRecordDto>? personalRecords,
  }) {
    return ProgressOverviewDto(
      currentStreakDays: currentStreakDays ?? this.currentStreakDays,
      bestStreakDays: bestStreakDays ?? this.bestStreakDays,
      workoutCount: workoutCount ?? this.workoutCount,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      totalSets: totalSets ?? this.totalSets,
      exercises:
          exercises ?? this.exercises.map((e0) => e0.copyWith()).toList(),
      muscleGroups:
          muscleGroups ?? this.muscleGroups.map((e0) => e0.copyWith()).toList(),
      personalRecords:
          personalRecords ??
          this.personalRecords.map((e0) => e0.copyWith()).toList(),
    );
  }
}
