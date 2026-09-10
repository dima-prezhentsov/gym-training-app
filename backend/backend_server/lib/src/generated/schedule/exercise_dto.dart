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

/// API representation of an exercise.
abstract class ExerciseDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ExerciseDto._({
    required this.id,
    required this.name,
    required this.description,
    required this.muscleGroup,
  });

  factory ExerciseDto({
    required String id,
    required String name,
    required String description,
    required String muscleGroup,
  }) = _ExerciseDtoImpl;

  factory ExerciseDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseDto(
      id: jsonSerialization['id'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      muscleGroup: jsonSerialization['muscleGroup'] as String,
    );
  }

  String id;

  String name;

  String description;

  String muscleGroup;

  /// Returns a shallow copy of this [ExerciseDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseDto copyWith({
    String? id,
    String? name,
    String? description,
    String? muscleGroup,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseDto',
      'id': id,
      'name': name,
      'description': description,
      'muscleGroup': muscleGroup,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseDto',
      'id': id,
      'name': name,
      'description': description,
      'muscleGroup': muscleGroup,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ExerciseDtoImpl extends ExerciseDto {
  _ExerciseDtoImpl({
    required String id,
    required String name,
    required String description,
    required String muscleGroup,
  }) : super._(
         id: id,
         name: name,
         description: description,
         muscleGroup: muscleGroup,
       );

  /// Returns a shallow copy of this [ExerciseDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseDto copyWith({
    String? id,
    String? name,
    String? description,
    String? muscleGroup,
  }) {
    return ExerciseDto(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      muscleGroup: muscleGroup ?? this.muscleGroup,
    );
  }
}
