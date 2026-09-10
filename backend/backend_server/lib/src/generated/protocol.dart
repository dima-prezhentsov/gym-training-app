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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i3;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i4;
import 'auth/telegram_account.dart' as _i5;
import 'auth/telegram_authentication_exception.dart' as _i6;
import 'greetings/greeting.dart' as _i7;
import 'history/exercise_record_dto.dart' as _i8;
import 'history/exercise_record_entity.dart' as _i9;
import 'history/set_record_dto.dart' as _i10;
import 'history/set_record_entity.dart' as _i11;
import 'history/workout_history_validation_exception.dart' as _i12;
import 'history/workout_record_dto.dart' as _i13;
import 'history/workout_record_entity.dart' as _i14;
import 'schedule/exercise_dto.dart' as _i15;
import 'schedule/exercise_entity.dart' as _i16;
import 'schedule/schedule_validation_exception.dart' as _i17;
import 'schedule/training_day_dto.dart' as _i18;
import 'schedule/training_day_entity.dart' as _i19;
import 'schedule/training_schedule_dto.dart' as _i20;
import 'schedule/training_schedule_entity.dart' as _i21;
import 'package:backend_server/src/generated/history/workout_record_dto.dart'
    as _i22;
export 'auth/telegram_account.dart';
export 'auth/telegram_authentication_exception.dart';
export 'greetings/greeting.dart';
export 'history/exercise_record_dto.dart';
export 'history/exercise_record_entity.dart';
export 'history/set_record_dto.dart';
export 'history/set_record_entity.dart';
export 'history/workout_history_validation_exception.dart';
export 'history/workout_record_dto.dart';
export 'history/workout_record_entity.dart';
export 'schedule/exercise_dto.dart';
export 'schedule/exercise_entity.dart';
export 'schedule/schedule_validation_exception.dart';
export 'schedule/training_day_dto.dart';
export 'schedule/training_day_entity.dart';
export 'schedule/training_schedule_dto.dart';
export 'schedule/training_schedule_entity.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'exercise',
      dartName: 'ExerciseEntity',
      schema: 'public',
      module: 'backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'muscleGroup',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'trainingDayId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'exercise_fk_0',
          columns: ['trainingDayId'],
          referenceTable: 'training_day',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'exercise_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'exercise_training_day_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'trainingDayId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'exercise_record',
      dartName: 'ExerciseRecordEntity',
      schema: 'public',
      module: 'backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'exercisePublicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'muscleGroup',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'workoutId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'exercise_record_fk_0',
          columns: ['workoutId'],
          referenceTable: 'workout_record',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'exercise_record_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'exercise_record_workout_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'workoutId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'set_record',
      dartName: 'SetRecordEntity',
      schema: 'public',
      module: 'backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'repetitions',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'weightKg',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'exerciseRecordId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'set_record_fk_0',
          columns: ['exerciseRecordId'],
          referenceTable: 'exercise_record',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'set_record_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'set_record_exercise_record_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'exerciseRecordId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'telegram_account',
      dartName: 'TelegramAccount',
      schema: 'public',
      module: 'backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'telegramUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'firstName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lastName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'username',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'telegram_account_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'telegram_account_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'telegram_account_telegram_user_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'telegramUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'telegram_account_auth_user_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_day',
      dartName: 'TrainingDayEntity',
      schema: 'public',
      module: 'backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'weekday',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'estimatedDurationMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scheduleId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_day_fk_0',
          columns: ['scheduleId'],
          referenceTable: 'training_schedule',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_day_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'training_day_schedule_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'scheduleId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_schedule',
      dartName: 'TrainingScheduleEntity',
      schema: 'public',
      module: 'backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_schedule_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_schedule_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'training_schedule_auth_user_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'workout_record',
      dartName: 'WorkoutRecordEntity',
      schema: 'public',
      module: 'backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'publicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'trainingDayPublicId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'workout_record_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'workout_record_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'workout_record_auth_user_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

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

    if (t == _i5.TelegramAccount) {
      return _i5.TelegramAccount.fromJson(data) as T;
    }
    if (t == _i6.TelegramAuthenticationException) {
      return _i6.TelegramAuthenticationException.fromJson(data) as T;
    }
    if (t == _i7.Greeting) {
      return _i7.Greeting.fromJson(data) as T;
    }
    if (t == _i8.ExerciseRecordDto) {
      return _i8.ExerciseRecordDto.fromJson(data) as T;
    }
    if (t == _i9.ExerciseRecordEntity) {
      return _i9.ExerciseRecordEntity.fromJson(data) as T;
    }
    if (t == _i10.SetRecordDto) {
      return _i10.SetRecordDto.fromJson(data) as T;
    }
    if (t == _i11.SetRecordEntity) {
      return _i11.SetRecordEntity.fromJson(data) as T;
    }
    if (t == _i12.WorkoutHistoryValidationException) {
      return _i12.WorkoutHistoryValidationException.fromJson(data) as T;
    }
    if (t == _i13.WorkoutRecordDto) {
      return _i13.WorkoutRecordDto.fromJson(data) as T;
    }
    if (t == _i14.WorkoutRecordEntity) {
      return _i14.WorkoutRecordEntity.fromJson(data) as T;
    }
    if (t == _i15.ExerciseDto) {
      return _i15.ExerciseDto.fromJson(data) as T;
    }
    if (t == _i16.ExerciseEntity) {
      return _i16.ExerciseEntity.fromJson(data) as T;
    }
    if (t == _i17.ScheduleValidationException) {
      return _i17.ScheduleValidationException.fromJson(data) as T;
    }
    if (t == _i18.TrainingDayDto) {
      return _i18.TrainingDayDto.fromJson(data) as T;
    }
    if (t == _i19.TrainingDayEntity) {
      return _i19.TrainingDayEntity.fromJson(data) as T;
    }
    if (t == _i20.TrainingScheduleDto) {
      return _i20.TrainingScheduleDto.fromJson(data) as T;
    }
    if (t == _i21.TrainingScheduleEntity) {
      return _i21.TrainingScheduleEntity.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.TelegramAccount?>()) {
      return (data != null ? _i5.TelegramAccount.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.TelegramAuthenticationException?>()) {
      return (data != null
              ? _i6.TelegramAuthenticationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i7.Greeting?>()) {
      return (data != null ? _i7.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ExerciseRecordDto?>()) {
      return (data != null ? _i8.ExerciseRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ExerciseRecordEntity?>()) {
      return (data != null ? _i9.ExerciseRecordEntity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.SetRecordDto?>()) {
      return (data != null ? _i10.SetRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.SetRecordEntity?>()) {
      return (data != null ? _i11.SetRecordEntity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.WorkoutHistoryValidationException?>()) {
      return (data != null
              ? _i12.WorkoutHistoryValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i13.WorkoutRecordDto?>()) {
      return (data != null ? _i13.WorkoutRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.WorkoutRecordEntity?>()) {
      return (data != null ? _i14.WorkoutRecordEntity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.ExerciseDto?>()) {
      return (data != null ? _i15.ExerciseDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.ExerciseEntity?>()) {
      return (data != null ? _i16.ExerciseEntity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.ScheduleValidationException?>()) {
      return (data != null
              ? _i17.ScheduleValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.TrainingDayDto?>()) {
      return (data != null ? _i18.TrainingDayDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.TrainingDayEntity?>()) {
      return (data != null ? _i19.TrainingDayEntity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.TrainingScheduleDto?>()) {
      return (data != null ? _i20.TrainingScheduleDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.TrainingScheduleEntity?>()) {
      return (data != null ? _i21.TrainingScheduleEntity.fromJson(data) : null)
          as T;
    }
    if (t == List<_i10.SetRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i10.SetRecordDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i8.ExerciseRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i8.ExerciseRecordDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.ExerciseDto>) {
      return (data as List)
              .map((e) => deserialize<_i15.ExerciseDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.TrainingDayDto>) {
      return (data as List)
              .map((e) => deserialize<_i18.TrainingDayDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.WorkoutRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i22.WorkoutRecordDto>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.TelegramAccount => 'TelegramAccount',
      _i6.TelegramAuthenticationException => 'TelegramAuthenticationException',
      _i7.Greeting => 'Greeting',
      _i8.ExerciseRecordDto => 'ExerciseRecordDto',
      _i9.ExerciseRecordEntity => 'ExerciseRecordEntity',
      _i10.SetRecordDto => 'SetRecordDto',
      _i11.SetRecordEntity => 'SetRecordEntity',
      _i12.WorkoutHistoryValidationException =>
        'WorkoutHistoryValidationException',
      _i13.WorkoutRecordDto => 'WorkoutRecordDto',
      _i14.WorkoutRecordEntity => 'WorkoutRecordEntity',
      _i15.ExerciseDto => 'ExerciseDto',
      _i16.ExerciseEntity => 'ExerciseEntity',
      _i17.ScheduleValidationException => 'ScheduleValidationException',
      _i18.TrainingDayDto => 'TrainingDayDto',
      _i19.TrainingDayEntity => 'TrainingDayEntity',
      _i20.TrainingScheduleDto => 'TrainingScheduleDto',
      _i21.TrainingScheduleEntity => 'TrainingScheduleEntity',
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
      case _i5.TelegramAccount():
        return 'TelegramAccount';
      case _i6.TelegramAuthenticationException():
        return 'TelegramAuthenticationException';
      case _i7.Greeting():
        return 'Greeting';
      case _i8.ExerciseRecordDto():
        return 'ExerciseRecordDto';
      case _i9.ExerciseRecordEntity():
        return 'ExerciseRecordEntity';
      case _i10.SetRecordDto():
        return 'SetRecordDto';
      case _i11.SetRecordEntity():
        return 'SetRecordEntity';
      case _i12.WorkoutHistoryValidationException():
        return 'WorkoutHistoryValidationException';
      case _i13.WorkoutRecordDto():
        return 'WorkoutRecordDto';
      case _i14.WorkoutRecordEntity():
        return 'WorkoutRecordEntity';
      case _i15.ExerciseDto():
        return 'ExerciseDto';
      case _i16.ExerciseEntity():
        return 'ExerciseEntity';
      case _i17.ScheduleValidationException():
        return 'ScheduleValidationException';
      case _i18.TrainingDayDto():
        return 'TrainingDayDto';
      case _i19.TrainingDayEntity():
        return 'TrainingDayEntity';
      case _i20.TrainingScheduleDto():
        return 'TrainingScheduleDto';
      case _i21.TrainingScheduleEntity():
        return 'TrainingScheduleEntity';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'TelegramAccount') {
      return deserialize<_i5.TelegramAccount>(data['data']);
    }
    if (dataClassName == 'TelegramAuthenticationException') {
      return deserialize<_i6.TelegramAuthenticationException>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i7.Greeting>(data['data']);
    }
    if (dataClassName == 'ExerciseRecordDto') {
      return deserialize<_i8.ExerciseRecordDto>(data['data']);
    }
    if (dataClassName == 'ExerciseRecordEntity') {
      return deserialize<_i9.ExerciseRecordEntity>(data['data']);
    }
    if (dataClassName == 'SetRecordDto') {
      return deserialize<_i10.SetRecordDto>(data['data']);
    }
    if (dataClassName == 'SetRecordEntity') {
      return deserialize<_i11.SetRecordEntity>(data['data']);
    }
    if (dataClassName == 'WorkoutHistoryValidationException') {
      return deserialize<_i12.WorkoutHistoryValidationException>(data['data']);
    }
    if (dataClassName == 'WorkoutRecordDto') {
      return deserialize<_i13.WorkoutRecordDto>(data['data']);
    }
    if (dataClassName == 'WorkoutRecordEntity') {
      return deserialize<_i14.WorkoutRecordEntity>(data['data']);
    }
    if (dataClassName == 'ExerciseDto') {
      return deserialize<_i15.ExerciseDto>(data['data']);
    }
    if (dataClassName == 'ExerciseEntity') {
      return deserialize<_i16.ExerciseEntity>(data['data']);
    }
    if (dataClassName == 'ScheduleValidationException') {
      return deserialize<_i17.ScheduleValidationException>(data['data']);
    }
    if (dataClassName == 'TrainingDayDto') {
      return deserialize<_i18.TrainingDayDto>(data['data']);
    }
    if (dataClassName == 'TrainingDayEntity') {
      return deserialize<_i19.TrainingDayEntity>(data['data']);
    }
    if (dataClassName == 'TrainingScheduleDto') {
      return deserialize<_i20.TrainingScheduleDto>(data['data']);
    }
    if (dataClassName == 'TrainingScheduleEntity') {
      return deserialize<_i21.TrainingScheduleEntity>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.TelegramAccount:
        return _i5.TelegramAccount.t;
      case _i9.ExerciseRecordEntity:
        return _i9.ExerciseRecordEntity.t;
      case _i11.SetRecordEntity:
        return _i11.SetRecordEntity.t;
      case _i14.WorkoutRecordEntity:
        return _i14.WorkoutRecordEntity.t;
      case _i16.ExerciseEntity:
        return _i16.ExerciseEntity.t;
      case _i19.TrainingDayEntity:
        return _i19.TrainingDayEntity.t;
      case _i21.TrainingScheduleEntity:
        return _i21.TrainingScheduleEntity.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'backend';

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
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
