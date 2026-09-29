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
import '../progress/exercise_progress_point_dto.dart' as _i2;
import 'package:backend_client/src/protocol/protocol.dart' as _i3;

abstract class ExerciseProgressDto implements _i1.SerializableModel {
  ExerciseProgressDto._({
    required this.exerciseId,
    required this.name,
    required this.points,
  });

  factory ExerciseProgressDto({
    required String exerciseId,
    required String name,
    required List<_i2.ExerciseProgressPointDto> points,
  }) = _ExerciseProgressDtoImpl;

  factory ExerciseProgressDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseProgressDto(
      exerciseId: jsonSerialization['exerciseId'] as String,
      name: jsonSerialization['name'] as String,
      points: _i3.Protocol().deserialize<List<_i2.ExerciseProgressPointDto>>(
        jsonSerialization['points'],
      ),
    );
  }

  String exerciseId;

  String name;

  List<_i2.ExerciseProgressPointDto> points;

  /// Returns a shallow copy of this [ExerciseProgressDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseProgressDto copyWith({
    String? exerciseId,
    String? name,
    List<_i2.ExerciseProgressPointDto>? points,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseProgressDto',
      'exerciseId': exerciseId,
      'name': name,
      'points': points.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ExerciseProgressDtoImpl extends ExerciseProgressDto {
  _ExerciseProgressDtoImpl({
    required String exerciseId,
    required String name,
    required List<_i2.ExerciseProgressPointDto> points,
  }) : super._(
         exerciseId: exerciseId,
         name: name,
         points: points,
       );

  /// Returns a shallow copy of this [ExerciseProgressDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseProgressDto copyWith({
    String? exerciseId,
    String? name,
    List<_i2.ExerciseProgressPointDto>? points,
  }) {
    return ExerciseProgressDto(
      exerciseId: exerciseId ?? this.exerciseId,
      name: name ?? this.name,
      points: points ?? this.points.map((e0) => e0.copyWith()).toList(),
    );
  }
}
