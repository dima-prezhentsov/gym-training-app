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
import '../schedule/training_day_dto.dart' as _i2;
import 'package:backend_client/src/protocol/protocol.dart' as _i3;

/// API representation of a user's training schedule.
abstract class TrainingScheduleDto implements _i1.SerializableModel {
  TrainingScheduleDto._({
    required this.id,
    required this.name,
    required this.days,
  });

  factory TrainingScheduleDto({
    required String id,
    required String name,
    required List<_i2.TrainingDayDto> days,
  }) = _TrainingScheduleDtoImpl;

  factory TrainingScheduleDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingScheduleDto(
      id: jsonSerialization['id'] as String,
      name: jsonSerialization['name'] as String,
      days: _i3.Protocol().deserialize<List<_i2.TrainingDayDto>>(
        jsonSerialization['days'],
      ),
    );
  }

  String id;

  String name;

  List<_i2.TrainingDayDto> days;

  /// Returns a shallow copy of this [TrainingScheduleDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingScheduleDto copyWith({
    String? id,
    String? name,
    List<_i2.TrainingDayDto>? days,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingScheduleDto',
      'id': id,
      'name': name,
      'days': days.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TrainingScheduleDtoImpl extends TrainingScheduleDto {
  _TrainingScheduleDtoImpl({
    required String id,
    required String name,
    required List<_i2.TrainingDayDto> days,
  }) : super._(
         id: id,
         name: name,
         days: days,
       );

  /// Returns a shallow copy of this [TrainingScheduleDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingScheduleDto copyWith({
    String? id,
    String? name,
    List<_i2.TrainingDayDto>? days,
  }) {
    return TrainingScheduleDto(
      id: id ?? this.id,
      name: name ?? this.name,
      days: days ?? this.days.map((e0) => e0.copyWith()).toList(),
    );
  }
}
