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
import 'auth/telegram_authentication_exception.dart' as _i2;
import 'greetings/greeting.dart' as _i3;
import 'history/exercise_record_dto.dart' as _i4;
import 'history/set_record_dto.dart' as _i5;
import 'history/workout_history_validation_exception.dart' as _i6;
import 'history/workout_record_dto.dart' as _i7;
import 'progress/exercise_progress_dto.dart' as _i8;
import 'progress/exercise_progress_point_dto.dart' as _i9;
import 'progress/muscle_group_progress_dto.dart' as _i10;
import 'progress/personal_record_dto.dart' as _i11;
import 'progress/progress_overview_dto.dart' as _i12;
import 'schedule/exercise_dto.dart' as _i13;
import 'schedule/schedule_validation_exception.dart' as _i14;
import 'schedule/training_day_dto.dart' as _i15;
import 'schedule/training_schedule_dto.dart' as _i16;
import 'package:backend_client/src/protocol/history/workout_record_dto.dart'
    as _i17;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i18;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i19;
export 'auth/telegram_authentication_exception.dart';
export 'greetings/greeting.dart';
export 'history/exercise_record_dto.dart';
export 'history/set_record_dto.dart';
export 'history/workout_history_validation_exception.dart';
export 'history/workout_record_dto.dart';
export 'progress/exercise_progress_dto.dart';
export 'progress/exercise_progress_point_dto.dart';
export 'progress/muscle_group_progress_dto.dart';
export 'progress/personal_record_dto.dart';
export 'progress/progress_overview_dto.dart';
export 'schedule/exercise_dto.dart';
export 'schedule/schedule_validation_exception.dart';
export 'schedule/training_day_dto.dart';
export 'schedule/training_schedule_dto.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.TelegramAuthenticationException) {
      return _i2.TelegramAuthenticationException.fromJson(data) as T;
    }
    if (t == _i3.Greeting) {
      return _i3.Greeting.fromJson(data) as T;
    }
    if (t == _i4.ExerciseRecordDto) {
      return _i4.ExerciseRecordDto.fromJson(data) as T;
    }
    if (t == _i5.SetRecordDto) {
      return _i5.SetRecordDto.fromJson(data) as T;
    }
    if (t == _i6.WorkoutHistoryValidationException) {
      return _i6.WorkoutHistoryValidationException.fromJson(data) as T;
    }
    if (t == _i7.WorkoutRecordDto) {
      return _i7.WorkoutRecordDto.fromJson(data) as T;
    }
    if (t == _i8.ExerciseProgressDto) {
      return _i8.ExerciseProgressDto.fromJson(data) as T;
    }
    if (t == _i9.ExerciseProgressPointDto) {
      return _i9.ExerciseProgressPointDto.fromJson(data) as T;
    }
    if (t == _i10.MuscleGroupProgressDto) {
      return _i10.MuscleGroupProgressDto.fromJson(data) as T;
    }
    if (t == _i11.PersonalRecordDto) {
      return _i11.PersonalRecordDto.fromJson(data) as T;
    }
    if (t == _i12.ProgressOverviewDto) {
      return _i12.ProgressOverviewDto.fromJson(data) as T;
    }
    if (t == _i13.ExerciseDto) {
      return _i13.ExerciseDto.fromJson(data) as T;
    }
    if (t == _i14.ScheduleValidationException) {
      return _i14.ScheduleValidationException.fromJson(data) as T;
    }
    if (t == _i15.TrainingDayDto) {
      return _i15.TrainingDayDto.fromJson(data) as T;
    }
    if (t == _i16.TrainingScheduleDto) {
      return _i16.TrainingScheduleDto.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.TelegramAuthenticationException?>()) {
      return (data != null
              ? _i2.TelegramAuthenticationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i3.Greeting?>()) {
      return (data != null ? _i3.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ExerciseRecordDto?>()) {
      return (data != null ? _i4.ExerciseRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.SetRecordDto?>()) {
      return (data != null ? _i5.SetRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.WorkoutHistoryValidationException?>()) {
      return (data != null
              ? _i6.WorkoutHistoryValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i7.WorkoutRecordDto?>()) {
      return (data != null ? _i7.WorkoutRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ExerciseProgressDto?>()) {
      return (data != null ? _i8.ExerciseProgressDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.ExerciseProgressPointDto?>()) {
      return (data != null ? _i9.ExerciseProgressPointDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.MuscleGroupProgressDto?>()) {
      return (data != null ? _i10.MuscleGroupProgressDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.PersonalRecordDto?>()) {
      return (data != null ? _i11.PersonalRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ProgressOverviewDto?>()) {
      return (data != null ? _i12.ProgressOverviewDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.ExerciseDto?>()) {
      return (data != null ? _i13.ExerciseDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.ScheduleValidationException?>()) {
      return (data != null
              ? _i14.ScheduleValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i15.TrainingDayDto?>()) {
      return (data != null ? _i15.TrainingDayDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.TrainingScheduleDto?>()) {
      return (data != null ? _i16.TrainingScheduleDto.fromJson(data) : null)
          as T;
    }
    if (t == List<_i5.SetRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i5.SetRecordDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i4.ExerciseRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i4.ExerciseRecordDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i9.ExerciseProgressPointDto>) {
      return (data as List)
              .map((e) => deserialize<_i9.ExerciseProgressPointDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i8.ExerciseProgressDto>) {
      return (data as List)
              .map((e) => deserialize<_i8.ExerciseProgressDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i10.MuscleGroupProgressDto>) {
      return (data as List)
              .map((e) => deserialize<_i10.MuscleGroupProgressDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.PersonalRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i11.PersonalRecordDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.ExerciseDto>) {
      return (data as List)
              .map((e) => deserialize<_i13.ExerciseDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.TrainingDayDto>) {
      return (data as List)
              .map((e) => deserialize<_i15.TrainingDayDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.WorkoutRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i17.WorkoutRecordDto>(e))
              .toList()
          as T;
    }
    try {
      return _i18.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i19.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.TelegramAuthenticationException => 'TelegramAuthenticationException',
      _i3.Greeting => 'Greeting',
      _i4.ExerciseRecordDto => 'ExerciseRecordDto',
      _i5.SetRecordDto => 'SetRecordDto',
      _i6.WorkoutHistoryValidationException =>
        'WorkoutHistoryValidationException',
      _i7.WorkoutRecordDto => 'WorkoutRecordDto',
      _i8.ExerciseProgressDto => 'ExerciseProgressDto',
      _i9.ExerciseProgressPointDto => 'ExerciseProgressPointDto',
      _i10.MuscleGroupProgressDto => 'MuscleGroupProgressDto',
      _i11.PersonalRecordDto => 'PersonalRecordDto',
      _i12.ProgressOverviewDto => 'ProgressOverviewDto',
      _i13.ExerciseDto => 'ExerciseDto',
      _i14.ScheduleValidationException => 'ScheduleValidationException',
      _i15.TrainingDayDto => 'TrainingDayDto',
      _i16.TrainingScheduleDto => 'TrainingScheduleDto',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('backend.', '');
    }

    switch (data) {
      case _i2.TelegramAuthenticationException():
        return 'TelegramAuthenticationException';
      case _i3.Greeting():
        return 'Greeting';
      case _i4.ExerciseRecordDto():
        return 'ExerciseRecordDto';
      case _i5.SetRecordDto():
        return 'SetRecordDto';
      case _i6.WorkoutHistoryValidationException():
        return 'WorkoutHistoryValidationException';
      case _i7.WorkoutRecordDto():
        return 'WorkoutRecordDto';
      case _i8.ExerciseProgressDto():
        return 'ExerciseProgressDto';
      case _i9.ExerciseProgressPointDto():
        return 'ExerciseProgressPointDto';
      case _i10.MuscleGroupProgressDto():
        return 'MuscleGroupProgressDto';
      case _i11.PersonalRecordDto():
        return 'PersonalRecordDto';
      case _i12.ProgressOverviewDto():
        return 'ProgressOverviewDto';
      case _i13.ExerciseDto():
        return 'ExerciseDto';
      case _i14.ScheduleValidationException():
        return 'ScheduleValidationException';
      case _i15.TrainingDayDto():
        return 'TrainingDayDto';
      case _i16.TrainingScheduleDto():
        return 'TrainingScheduleDto';
    }
    className = _i18.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i19.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'TelegramAuthenticationException') {
      return deserialize<_i2.TelegramAuthenticationException>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i3.Greeting>(data['data']);
    }
    if (dataClassName == 'ExerciseRecordDto') {
      return deserialize<_i4.ExerciseRecordDto>(data['data']);
    }
    if (dataClassName == 'SetRecordDto') {
      return deserialize<_i5.SetRecordDto>(data['data']);
    }
    if (dataClassName == 'WorkoutHistoryValidationException') {
      return deserialize<_i6.WorkoutHistoryValidationException>(data['data']);
    }
    if (dataClassName == 'WorkoutRecordDto') {
      return deserialize<_i7.WorkoutRecordDto>(data['data']);
    }
    if (dataClassName == 'ExerciseProgressDto') {
      return deserialize<_i8.ExerciseProgressDto>(data['data']);
    }
    if (dataClassName == 'ExerciseProgressPointDto') {
      return deserialize<_i9.ExerciseProgressPointDto>(data['data']);
    }
    if (dataClassName == 'MuscleGroupProgressDto') {
      return deserialize<_i10.MuscleGroupProgressDto>(data['data']);
    }
    if (dataClassName == 'PersonalRecordDto') {
      return deserialize<_i11.PersonalRecordDto>(data['data']);
    }
    if (dataClassName == 'ProgressOverviewDto') {
      return deserialize<_i12.ProgressOverviewDto>(data['data']);
    }
    if (dataClassName == 'ExerciseDto') {
      return deserialize<_i13.ExerciseDto>(data['data']);
    }
    if (dataClassName == 'ScheduleValidationException') {
      return deserialize<_i14.ScheduleValidationException>(data['data']);
    }
    if (dataClassName == 'TrainingDayDto') {
      return deserialize<_i15.TrainingDayDto>(data['data']);
    }
    if (dataClassName == 'TrainingScheduleDto') {
      return deserialize<_i16.TrainingScheduleDto>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i18.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i19.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i18.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i19.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
