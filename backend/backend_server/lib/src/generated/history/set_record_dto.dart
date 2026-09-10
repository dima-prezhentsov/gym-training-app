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

abstract class SetRecordDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SetRecordDto._({
    required this.id,
    required this.repetitions,
    required this.weightKg,
  });

  factory SetRecordDto({
    required String id,
    required int repetitions,
    required double weightKg,
  }) = _SetRecordDtoImpl;

  factory SetRecordDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return SetRecordDto(
      id: jsonSerialization['id'] as String,
      repetitions: jsonSerialization['repetitions'] as int,
      weightKg: (jsonSerialization['weightKg'] as num).toDouble(),
    );
  }

  String id;

  int repetitions;

  double weightKg;

  /// Returns a shallow copy of this [SetRecordDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SetRecordDto copyWith({
    String? id,
    int? repetitions,
    double? weightKg,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SetRecordDto',
      'id': id,
      'repetitions': repetitions,
      'weightKg': weightKg,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SetRecordDto',
      'id': id,
      'repetitions': repetitions,
      'weightKg': weightKg,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SetRecordDtoImpl extends SetRecordDto {
  _SetRecordDtoImpl({
    required String id,
    required int repetitions,
    required double weightKg,
  }) : super._(
         id: id,
         repetitions: repetitions,
         weightKg: weightKg,
       );

  /// Returns a shallow copy of this [SetRecordDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SetRecordDto copyWith({
    String? id,
    int? repetitions,
    double? weightKg,
  }) {
    return SetRecordDto(
      id: id ?? this.id,
      repetitions: repetitions ?? this.repetitions,
      weightKg: weightKg ?? this.weightKg,
    );
  }
}
