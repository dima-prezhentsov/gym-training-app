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
import 'friends/friend_access_exception.dart' as _i7;
import 'friends/friend_connection_dto.dart' as _i8;
import 'friends/friend_invite_dto.dart' as _i9;
import 'friends/friend_invite_entity.dart' as _i10;
import 'friends/friendship_entity.dart' as _i11;
import 'greetings/greeting.dart' as _i12;
import 'history/exercise_record_dto.dart' as _i13;
import 'history/exercise_record_entity.dart' as _i14;
import 'history/set_record_dto.dart' as _i15;
import 'history/set_record_entity.dart' as _i16;
import 'history/workout_history_validation_exception.dart' as _i17;
import 'history/workout_record_dto.dart' as _i18;
import 'history/workout_record_entity.dart' as _i19;
import 'progress/exercise_progress_dto.dart' as _i20;
import 'progress/exercise_progress_point_dto.dart' as _i21;
import 'progress/muscle_group_progress_dto.dart' as _i22;
import 'progress/personal_record_dto.dart' as _i23;
import 'progress/progress_overview_dto.dart' as _i24;
import 'schedule/exercise_dto.dart' as _i25;
import 'schedule/exercise_entity.dart' as _i26;
import 'schedule/schedule_validation_exception.dart' as _i27;
import 'schedule/training_day_dto.dart' as _i28;
import 'schedule/training_day_entity.dart' as _i29;
import 'schedule/training_schedule_dto.dart' as _i30;
import 'schedule/training_schedule_entity.dart' as _i31;
import 'package:backend_server/src/generated/friends/friend_connection_dto.dart'
    as _i32;
import 'package:backend_server/src/generated/history/workout_record_dto.dart'
    as _i33;
export 'auth/telegram_account.dart';
export 'auth/telegram_authentication_exception.dart';
export 'friends/friend_access_exception.dart';
export 'friends/friend_connection_dto.dart';
export 'friends/friend_invite_dto.dart';
export 'friends/friend_invite_entity.dart';
export 'friends/friendship_entity.dart';
export 'greetings/greeting.dart';
export 'history/exercise_record_dto.dart';
export 'history/exercise_record_entity.dart';
export 'history/set_record_dto.dart';
export 'history/set_record_entity.dart';
export 'history/workout_history_validation_exception.dart';
export 'history/workout_record_dto.dart';
export 'history/workout_record_entity.dart';
export 'progress/exercise_progress_dto.dart';
export 'progress/exercise_progress_point_dto.dart';
export 'progress/muscle_group_progress_dto.dart';
export 'progress/personal_record_dto.dart';
export 'progress/progress_overview_dto.dart';
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
      name: 'friend_invite',
      dartName: 'FriendInviteEntity',
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
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'creatorId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'friend_invite_fk_0',
          columns: ['creatorId'],
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
          indexName: 'friend_invite_pkey',
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
          indexName: 'friend_invite_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'friend_invite_creator_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'creatorId',
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
      name: 'friendship',
      dartName: 'FriendshipEntity',
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
          name: 'userAId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'userBId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'requestedById',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'aSharesStats',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'aSharesHistory',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'bSharesStats',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'bSharesHistory',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
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
          constraintName: 'friendship_fk_0',
          columns: ['userAId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'friendship_fk_1',
          columns: ['userBId'],
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
          indexName: 'friendship_pkey',
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
          indexName: 'friendship_pair_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userAId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userBId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'friendship_user_b_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userBId',
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
          name: 'utcOffsetMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
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
    if (t == _i7.FriendAccessException) {
      return _i7.FriendAccessException.fromJson(data) as T;
    }
    if (t == _i8.FriendConnectionDto) {
      return _i8.FriendConnectionDto.fromJson(data) as T;
    }
    if (t == _i9.FriendInviteDto) {
      return _i9.FriendInviteDto.fromJson(data) as T;
    }
    if (t == _i10.FriendInviteEntity) {
      return _i10.FriendInviteEntity.fromJson(data) as T;
    }
    if (t == _i11.FriendshipEntity) {
      return _i11.FriendshipEntity.fromJson(data) as T;
    }
    if (t == _i12.Greeting) {
      return _i12.Greeting.fromJson(data) as T;
    }
    if (t == _i13.ExerciseRecordDto) {
      return _i13.ExerciseRecordDto.fromJson(data) as T;
    }
    if (t == _i14.ExerciseRecordEntity) {
      return _i14.ExerciseRecordEntity.fromJson(data) as T;
    }
    if (t == _i15.SetRecordDto) {
      return _i15.SetRecordDto.fromJson(data) as T;
    }
    if (t == _i16.SetRecordEntity) {
      return _i16.SetRecordEntity.fromJson(data) as T;
    }
    if (t == _i17.WorkoutHistoryValidationException) {
      return _i17.WorkoutHistoryValidationException.fromJson(data) as T;
    }
    if (t == _i18.WorkoutRecordDto) {
      return _i18.WorkoutRecordDto.fromJson(data) as T;
    }
    if (t == _i19.WorkoutRecordEntity) {
      return _i19.WorkoutRecordEntity.fromJson(data) as T;
    }
    if (t == _i20.ExerciseProgressDto) {
      return _i20.ExerciseProgressDto.fromJson(data) as T;
    }
    if (t == _i21.ExerciseProgressPointDto) {
      return _i21.ExerciseProgressPointDto.fromJson(data) as T;
    }
    if (t == _i22.MuscleGroupProgressDto) {
      return _i22.MuscleGroupProgressDto.fromJson(data) as T;
    }
    if (t == _i23.PersonalRecordDto) {
      return _i23.PersonalRecordDto.fromJson(data) as T;
    }
    if (t == _i24.ProgressOverviewDto) {
      return _i24.ProgressOverviewDto.fromJson(data) as T;
    }
    if (t == _i25.ExerciseDto) {
      return _i25.ExerciseDto.fromJson(data) as T;
    }
    if (t == _i26.ExerciseEntity) {
      return _i26.ExerciseEntity.fromJson(data) as T;
    }
    if (t == _i27.ScheduleValidationException) {
      return _i27.ScheduleValidationException.fromJson(data) as T;
    }
    if (t == _i28.TrainingDayDto) {
      return _i28.TrainingDayDto.fromJson(data) as T;
    }
    if (t == _i29.TrainingDayEntity) {
      return _i29.TrainingDayEntity.fromJson(data) as T;
    }
    if (t == _i30.TrainingScheduleDto) {
      return _i30.TrainingScheduleDto.fromJson(data) as T;
    }
    if (t == _i31.TrainingScheduleEntity) {
      return _i31.TrainingScheduleEntity.fromJson(data) as T;
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
    if (t == _i1.getType<_i7.FriendAccessException?>()) {
      return (data != null ? _i7.FriendAccessException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.FriendConnectionDto?>()) {
      return (data != null ? _i8.FriendConnectionDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.FriendInviteDto?>()) {
      return (data != null ? _i9.FriendInviteDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.FriendInviteEntity?>()) {
      return (data != null ? _i10.FriendInviteEntity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.FriendshipEntity?>()) {
      return (data != null ? _i11.FriendshipEntity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Greeting?>()) {
      return (data != null ? _i12.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.ExerciseRecordDto?>()) {
      return (data != null ? _i13.ExerciseRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.ExerciseRecordEntity?>()) {
      return (data != null ? _i14.ExerciseRecordEntity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.SetRecordDto?>()) {
      return (data != null ? _i15.SetRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.SetRecordEntity?>()) {
      return (data != null ? _i16.SetRecordEntity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.WorkoutHistoryValidationException?>()) {
      return (data != null
              ? _i17.WorkoutHistoryValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.WorkoutRecordDto?>()) {
      return (data != null ? _i18.WorkoutRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.WorkoutRecordEntity?>()) {
      return (data != null ? _i19.WorkoutRecordEntity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.ExerciseProgressDto?>()) {
      return (data != null ? _i20.ExerciseProgressDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.ExerciseProgressPointDto?>()) {
      return (data != null
              ? _i21.ExerciseProgressPointDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i22.MuscleGroupProgressDto?>()) {
      return (data != null ? _i22.MuscleGroupProgressDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.PersonalRecordDto?>()) {
      return (data != null ? _i23.PersonalRecordDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.ProgressOverviewDto?>()) {
      return (data != null ? _i24.ProgressOverviewDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.ExerciseDto?>()) {
      return (data != null ? _i25.ExerciseDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.ExerciseEntity?>()) {
      return (data != null ? _i26.ExerciseEntity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.ScheduleValidationException?>()) {
      return (data != null
              ? _i27.ScheduleValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i28.TrainingDayDto?>()) {
      return (data != null ? _i28.TrainingDayDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.TrainingDayEntity?>()) {
      return (data != null ? _i29.TrainingDayEntity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.TrainingScheduleDto?>()) {
      return (data != null ? _i30.TrainingScheduleDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.TrainingScheduleEntity?>()) {
      return (data != null ? _i31.TrainingScheduleEntity.fromJson(data) : null)
          as T;
    }
    if (t == List<_i15.SetRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i15.SetRecordDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.ExerciseRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i13.ExerciseRecordDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.ExerciseProgressPointDto>) {
      return (data as List)
              .map((e) => deserialize<_i21.ExerciseProgressPointDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.ExerciseProgressDto>) {
      return (data as List)
              .map((e) => deserialize<_i20.ExerciseProgressDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.MuscleGroupProgressDto>) {
      return (data as List)
              .map((e) => deserialize<_i22.MuscleGroupProgressDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.PersonalRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i23.PersonalRecordDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.ExerciseDto>) {
      return (data as List)
              .map((e) => deserialize<_i25.ExerciseDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.TrainingDayDto>) {
      return (data as List)
              .map((e) => deserialize<_i28.TrainingDayDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.FriendConnectionDto>) {
      return (data as List)
              .map((e) => deserialize<_i32.FriendConnectionDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.WorkoutRecordDto>) {
      return (data as List)
              .map((e) => deserialize<_i33.WorkoutRecordDto>(e))
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
      _i7.FriendAccessException => 'FriendAccessException',
      _i8.FriendConnectionDto => 'FriendConnectionDto',
      _i9.FriendInviteDto => 'FriendInviteDto',
      _i10.FriendInviteEntity => 'FriendInviteEntity',
      _i11.FriendshipEntity => 'FriendshipEntity',
      _i12.Greeting => 'Greeting',
      _i13.ExerciseRecordDto => 'ExerciseRecordDto',
      _i14.ExerciseRecordEntity => 'ExerciseRecordEntity',
      _i15.SetRecordDto => 'SetRecordDto',
      _i16.SetRecordEntity => 'SetRecordEntity',
      _i17.WorkoutHistoryValidationException =>
        'WorkoutHistoryValidationException',
      _i18.WorkoutRecordDto => 'WorkoutRecordDto',
      _i19.WorkoutRecordEntity => 'WorkoutRecordEntity',
      _i20.ExerciseProgressDto => 'ExerciseProgressDto',
      _i21.ExerciseProgressPointDto => 'ExerciseProgressPointDto',
      _i22.MuscleGroupProgressDto => 'MuscleGroupProgressDto',
      _i23.PersonalRecordDto => 'PersonalRecordDto',
      _i24.ProgressOverviewDto => 'ProgressOverviewDto',
      _i25.ExerciseDto => 'ExerciseDto',
      _i26.ExerciseEntity => 'ExerciseEntity',
      _i27.ScheduleValidationException => 'ScheduleValidationException',
      _i28.TrainingDayDto => 'TrainingDayDto',
      _i29.TrainingDayEntity => 'TrainingDayEntity',
      _i30.TrainingScheduleDto => 'TrainingScheduleDto',
      _i31.TrainingScheduleEntity => 'TrainingScheduleEntity',
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
      case _i7.FriendAccessException():
        return 'FriendAccessException';
      case _i8.FriendConnectionDto():
        return 'FriendConnectionDto';
      case _i9.FriendInviteDto():
        return 'FriendInviteDto';
      case _i10.FriendInviteEntity():
        return 'FriendInviteEntity';
      case _i11.FriendshipEntity():
        return 'FriendshipEntity';
      case _i12.Greeting():
        return 'Greeting';
      case _i13.ExerciseRecordDto():
        return 'ExerciseRecordDto';
      case _i14.ExerciseRecordEntity():
        return 'ExerciseRecordEntity';
      case _i15.SetRecordDto():
        return 'SetRecordDto';
      case _i16.SetRecordEntity():
        return 'SetRecordEntity';
      case _i17.WorkoutHistoryValidationException():
        return 'WorkoutHistoryValidationException';
      case _i18.WorkoutRecordDto():
        return 'WorkoutRecordDto';
      case _i19.WorkoutRecordEntity():
        return 'WorkoutRecordEntity';
      case _i20.ExerciseProgressDto():
        return 'ExerciseProgressDto';
      case _i21.ExerciseProgressPointDto():
        return 'ExerciseProgressPointDto';
      case _i22.MuscleGroupProgressDto():
        return 'MuscleGroupProgressDto';
      case _i23.PersonalRecordDto():
        return 'PersonalRecordDto';
      case _i24.ProgressOverviewDto():
        return 'ProgressOverviewDto';
      case _i25.ExerciseDto():
        return 'ExerciseDto';
      case _i26.ExerciseEntity():
        return 'ExerciseEntity';
      case _i27.ScheduleValidationException():
        return 'ScheduleValidationException';
      case _i28.TrainingDayDto():
        return 'TrainingDayDto';
      case _i29.TrainingDayEntity():
        return 'TrainingDayEntity';
      case _i30.TrainingScheduleDto():
        return 'TrainingScheduleDto';
      case _i31.TrainingScheduleEntity():
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
    if (dataClassName == 'FriendAccessException') {
      return deserialize<_i7.FriendAccessException>(data['data']);
    }
    if (dataClassName == 'FriendConnectionDto') {
      return deserialize<_i8.FriendConnectionDto>(data['data']);
    }
    if (dataClassName == 'FriendInviteDto') {
      return deserialize<_i9.FriendInviteDto>(data['data']);
    }
    if (dataClassName == 'FriendInviteEntity') {
      return deserialize<_i10.FriendInviteEntity>(data['data']);
    }
    if (dataClassName == 'FriendshipEntity') {
      return deserialize<_i11.FriendshipEntity>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i12.Greeting>(data['data']);
    }
    if (dataClassName == 'ExerciseRecordDto') {
      return deserialize<_i13.ExerciseRecordDto>(data['data']);
    }
    if (dataClassName == 'ExerciseRecordEntity') {
      return deserialize<_i14.ExerciseRecordEntity>(data['data']);
    }
    if (dataClassName == 'SetRecordDto') {
      return deserialize<_i15.SetRecordDto>(data['data']);
    }
    if (dataClassName == 'SetRecordEntity') {
      return deserialize<_i16.SetRecordEntity>(data['data']);
    }
    if (dataClassName == 'WorkoutHistoryValidationException') {
      return deserialize<_i17.WorkoutHistoryValidationException>(data['data']);
    }
    if (dataClassName == 'WorkoutRecordDto') {
      return deserialize<_i18.WorkoutRecordDto>(data['data']);
    }
    if (dataClassName == 'WorkoutRecordEntity') {
      return deserialize<_i19.WorkoutRecordEntity>(data['data']);
    }
    if (dataClassName == 'ExerciseProgressDto') {
      return deserialize<_i20.ExerciseProgressDto>(data['data']);
    }
    if (dataClassName == 'ExerciseProgressPointDto') {
      return deserialize<_i21.ExerciseProgressPointDto>(data['data']);
    }
    if (dataClassName == 'MuscleGroupProgressDto') {
      return deserialize<_i22.MuscleGroupProgressDto>(data['data']);
    }
    if (dataClassName == 'PersonalRecordDto') {
      return deserialize<_i23.PersonalRecordDto>(data['data']);
    }
    if (dataClassName == 'ProgressOverviewDto') {
      return deserialize<_i24.ProgressOverviewDto>(data['data']);
    }
    if (dataClassName == 'ExerciseDto') {
      return deserialize<_i25.ExerciseDto>(data['data']);
    }
    if (dataClassName == 'ExerciseEntity') {
      return deserialize<_i26.ExerciseEntity>(data['data']);
    }
    if (dataClassName == 'ScheduleValidationException') {
      return deserialize<_i27.ScheduleValidationException>(data['data']);
    }
    if (dataClassName == 'TrainingDayDto') {
      return deserialize<_i28.TrainingDayDto>(data['data']);
    }
    if (dataClassName == 'TrainingDayEntity') {
      return deserialize<_i29.TrainingDayEntity>(data['data']);
    }
    if (dataClassName == 'TrainingScheduleDto') {
      return deserialize<_i30.TrainingScheduleDto>(data['data']);
    }
    if (dataClassName == 'TrainingScheduleEntity') {
      return deserialize<_i31.TrainingScheduleEntity>(data['data']);
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
      case _i10.FriendInviteEntity:
        return _i10.FriendInviteEntity.t;
      case _i11.FriendshipEntity:
        return _i11.FriendshipEntity.t;
      case _i14.ExerciseRecordEntity:
        return _i14.ExerciseRecordEntity.t;
      case _i16.SetRecordEntity:
        return _i16.SetRecordEntity.t;
      case _i19.WorkoutRecordEntity:
        return _i19.WorkoutRecordEntity.t;
      case _i26.ExerciseEntity:
        return _i26.ExerciseEntity.t;
      case _i29.TrainingDayEntity:
        return _i29.TrainingDayEntity.t;
      case _i31.TrainingScheduleEntity:
        return _i31.TrainingScheduleEntity.t;
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
