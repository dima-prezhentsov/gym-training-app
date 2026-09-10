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
import '../history/set_record_dto.dart' as _i2;
import 'package:backend_client/src/protocol/protocol.dart' as _i3;

abstract class ExerciseRecordDto implements _i1.SerializableModel {
  ExerciseRecordDto._({
    required this.exerciseId,
    required this.name,
    required this.muscleGroup,
    required this.sets,
  });

  factory ExerciseRecordDto({
    required String exerciseId,
    required String name,
    required String muscleGroup,
    required List<_i2.SetRecordDto> sets,
  }) = _ExerciseRecordDtoImpl;

  factory ExerciseRecordDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseRecordDto(
      exerciseId: jsonSerialization['exerciseId'] as String,
      name: jsonSerialization['name'] as String,
      muscleGroup: jsonSerialization['muscleGroup'] as String,
      sets: _i3.Protocol().deserialize<List<_i2.SetRecordDto>>(
        jsonSerialization['sets'],
      ),
    );
  }

  String exerciseId;

  String name;

  String muscleGroup;

  List<_i2.SetRecordDto> sets;

  /// Returns a shallow copy of this [ExerciseRecordDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseRecordDto copyWith({
    String? exerciseId,
    String? name,
    String? muscleGroup,
    List<_i2.SetRecordDto>? sets,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseRecordDto',
      'exerciseId': exerciseId,
      'name': name,
      'muscleGroup': muscleGroup,
      'sets': sets.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ExerciseRecordDtoImpl extends ExerciseRecordDto {
  _ExerciseRecordDtoImpl({
    required String exerciseId,
    required String name,
    required String muscleGroup,
    required List<_i2.SetRecordDto> sets,
  }) : super._(
         exerciseId: exerciseId,
         name: name,
         muscleGroup: muscleGroup,
         sets: sets,
       );

  /// Returns a shallow copy of this [ExerciseRecordDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseRecordDto copyWith({
    String? exerciseId,
    String? name,
    String? muscleGroup,
    List<_i2.SetRecordDto>? sets,
  }) {
    return ExerciseRecordDto(
      exerciseId: exerciseId ?? this.exerciseId,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      sets: sets ?? this.sets.map((e0) => e0.copyWith()).toList(),
    );
  }
}
