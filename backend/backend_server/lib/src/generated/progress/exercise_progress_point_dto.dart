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

abstract class ExerciseProgressPointDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ExerciseProgressPointDto._({
    required this.date,
    required this.estimatedMaxKg,
    required this.maxWeightKg,
    required this.volumeKg,
  });

  factory ExerciseProgressPointDto({
    required DateTime date,
    required double estimatedMaxKg,
    required double maxWeightKg,
    required double volumeKg,
  }) = _ExerciseProgressPointDtoImpl;

  factory ExerciseProgressPointDto.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ExerciseProgressPointDto(
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      estimatedMaxKg: (jsonSerialization['estimatedMaxKg'] as num).toDouble(),
      maxWeightKg: (jsonSerialization['maxWeightKg'] as num).toDouble(),
      volumeKg: (jsonSerialization['volumeKg'] as num).toDouble(),
    );
  }

  DateTime date;

  double estimatedMaxKg;

  double maxWeightKg;

  double volumeKg;

  /// Returns a shallow copy of this [ExerciseProgressPointDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseProgressPointDto copyWith({
    DateTime? date,
    double? estimatedMaxKg,
    double? maxWeightKg,
    double? volumeKg,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseProgressPointDto',
      'date': date.toJson(),
      'estimatedMaxKg': estimatedMaxKg,
      'maxWeightKg': maxWeightKg,
      'volumeKg': volumeKg,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseProgressPointDto',
      'date': date.toJson(),
      'estimatedMaxKg': estimatedMaxKg,
      'maxWeightKg': maxWeightKg,
      'volumeKg': volumeKg,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ExerciseProgressPointDtoImpl extends ExerciseProgressPointDto {
  _ExerciseProgressPointDtoImpl({
    required DateTime date,
    required double estimatedMaxKg,
    required double maxWeightKg,
    required double volumeKg,
  }) : super._(
         date: date,
         estimatedMaxKg: estimatedMaxKg,
         maxWeightKg: maxWeightKg,
         volumeKg: volumeKg,
       );

  /// Returns a shallow copy of this [ExerciseProgressPointDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseProgressPointDto copyWith({
    DateTime? date,
    double? estimatedMaxKg,
    double? maxWeightKg,
    double? volumeKg,
  }) {
    return ExerciseProgressPointDto(
      date: date ?? this.date,
      estimatedMaxKg: estimatedMaxKg ?? this.estimatedMaxKg,
      maxWeightKg: maxWeightKg ?? this.maxWeightKg,
      volumeKg: volumeKg ?? this.volumeKg,
    );
  }
}
