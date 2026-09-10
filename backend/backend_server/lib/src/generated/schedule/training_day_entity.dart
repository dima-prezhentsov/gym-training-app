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
// ignore_for_file: unnecessary_null_comparison

import 'package:serverpod/serverpod.dart' as _i1;
import '../schedule/training_schedule_entity.dart' as _i2;
import 'package:backend_server/src/generated/protocol.dart' as _i3;

/// A day within a persisted training schedule.
abstract class TrainingDayEntity
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  TrainingDayEntity._({
    this.id,
    required this.publicId,
    required this.name,
    required this.weekday,
    required this.estimatedDurationMinutes,
    required this.position,
    required this.scheduleId,
    this.schedule,
  });

  factory TrainingDayEntity({
    _i1.UuidValue? id,
    required String publicId,
    required String name,
    required int weekday,
    required int estimatedDurationMinutes,
    required int position,
    required _i1.UuidValue scheduleId,
    _i2.TrainingScheduleEntity? schedule,
  }) = _TrainingDayEntityImpl;

  factory TrainingDayEntity.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingDayEntity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      publicId: jsonSerialization['publicId'] as String,
      name: jsonSerialization['name'] as String,
      weekday: jsonSerialization['weekday'] as int,
      estimatedDurationMinutes:
          jsonSerialization['estimatedDurationMinutes'] as int,
      position: jsonSerialization['position'] as int,
      scheduleId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['scheduleId'],
      ),
      schedule: jsonSerialization['schedule'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.TrainingScheduleEntity>(
              jsonSerialization['schedule'],
            ),
    );
  }

  static final t = TrainingDayEntityTable();

  static const db = TrainingDayEntityRepository._();

  @override
  _i1.UuidValue? id;

  String publicId;

  String name;

  int weekday;

  int estimatedDurationMinutes;

  int position;

  _i1.UuidValue scheduleId;

  _i2.TrainingScheduleEntity? schedule;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [TrainingDayEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingDayEntity copyWith({
    _i1.UuidValue? id,
    String? publicId,
    String? name,
    int? weekday,
    int? estimatedDurationMinutes,
    int? position,
    _i1.UuidValue? scheduleId,
    _i2.TrainingScheduleEntity? schedule,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingDayEntity',
      if (id != null) 'id': id?.toJson(),
      'publicId': publicId,
      'name': name,
      'weekday': weekday,
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'position': position,
      'scheduleId': scheduleId.toJson(),
      if (schedule != null) 'schedule': schedule?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static TrainingDayEntityInclude include({
    _i2.TrainingScheduleEntityInclude? schedule,
  }) {
    return TrainingDayEntityInclude._(schedule: schedule);
  }

  static TrainingDayEntityIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingDayEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingDayEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingDayEntityTable>? orderByList,
    TrainingDayEntityInclude? include,
  }) {
    return TrainingDayEntityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingDayEntity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingDayEntity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingDayEntityImpl extends TrainingDayEntity {
  _TrainingDayEntityImpl({
    _i1.UuidValue? id,
    required String publicId,
    required String name,
    required int weekday,
    required int estimatedDurationMinutes,
    required int position,
    required _i1.UuidValue scheduleId,
    _i2.TrainingScheduleEntity? schedule,
  }) : super._(
         id: id,
         publicId: publicId,
         name: name,
         weekday: weekday,
         estimatedDurationMinutes: estimatedDurationMinutes,
         position: position,
         scheduleId: scheduleId,
         schedule: schedule,
       );

  /// Returns a shallow copy of this [TrainingDayEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingDayEntity copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? name,
    int? weekday,
    int? estimatedDurationMinutes,
    int? position,
    _i1.UuidValue? scheduleId,
    Object? schedule = _Undefined,
  }) {
    return TrainingDayEntity(
      id: id is _i1.UuidValue? ? id : this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      weekday: weekday ?? this.weekday,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      position: position ?? this.position,
      scheduleId: scheduleId ?? this.scheduleId,
      schedule: schedule is _i2.TrainingScheduleEntity?
          ? schedule
          : this.schedule?.copyWith(),
    );
  }
}

class TrainingDayEntityUpdateTable
    extends _i1.UpdateTable<TrainingDayEntityTable> {
  TrainingDayEntityUpdateTable(super.table);

  _i1.ColumnValue<String, String> publicId(String value) => _i1.ColumnValue(
    table.publicId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<int, int> weekday(int value) => _i1.ColumnValue(
    table.weekday,
    value,
  );

  _i1.ColumnValue<int, int> estimatedDurationMinutes(int value) =>
      _i1.ColumnValue(
        table.estimatedDurationMinutes,
        value,
      );

  _i1.ColumnValue<int, int> position(int value) => _i1.ColumnValue(
    table.position,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> scheduleId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.scheduleId,
    value,
  );
}

class TrainingDayEntityTable extends _i1.Table<_i1.UuidValue?> {
  TrainingDayEntityTable({super.tableRelation})
    : super(tableName: 'training_day') {
    updateTable = TrainingDayEntityUpdateTable(this);
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    weekday = _i1.ColumnInt(
      'weekday',
      this,
    );
    estimatedDurationMinutes = _i1.ColumnInt(
      'estimatedDurationMinutes',
      this,
    );
    position = _i1.ColumnInt(
      'position',
      this,
    );
    scheduleId = _i1.ColumnUuid(
      'scheduleId',
      this,
    );
  }

  late final TrainingDayEntityUpdateTable updateTable;

  late final _i1.ColumnString publicId;

  late final _i1.ColumnString name;

  late final _i1.ColumnInt weekday;

  late final _i1.ColumnInt estimatedDurationMinutes;

  late final _i1.ColumnInt position;

  late final _i1.ColumnUuid scheduleId;

  _i2.TrainingScheduleEntityTable? _schedule;

  _i2.TrainingScheduleEntityTable get schedule {
    if (_schedule != null) return _schedule!;
    _schedule = _i1.createRelationTable(
      relationFieldName: 'schedule',
      field: TrainingDayEntity.t.scheduleId,
      foreignField: _i2.TrainingScheduleEntity.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TrainingScheduleEntityTable(tableRelation: foreignTableRelation),
    );
    return _schedule!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    publicId,
    name,
    weekday,
    estimatedDurationMinutes,
    position,
    scheduleId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'schedule') {
      return schedule;
    }
    return null;
  }
}

class TrainingDayEntityInclude extends _i1.IncludeObject {
  TrainingDayEntityInclude._({_i2.TrainingScheduleEntityInclude? schedule}) {
    _schedule = schedule;
  }

  _i2.TrainingScheduleEntityInclude? _schedule;

  @override
  Map<String, _i1.Include?> get includes => {'schedule': _schedule};

  @override
  _i1.Table<_i1.UuidValue?> get table => TrainingDayEntity.t;
}

class TrainingDayEntityIncludeList extends _i1.IncludeList {
  TrainingDayEntityIncludeList._({
    _i1.WhereExpressionBuilder<TrainingDayEntityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingDayEntity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => TrainingDayEntity.t;
}

class TrainingDayEntityRepository {
  const TrainingDayEntityRepository._();

  final attachRow = const TrainingDayEntityAttachRowRepository._();

  /// Returns a list of [TrainingDayEntity]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<TrainingDayEntity>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingDayEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingDayEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingDayEntityTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingDayEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingDayEntity>(
      where: where?.call(TrainingDayEntity.t),
      orderBy: orderBy?.call(TrainingDayEntity.t),
      orderByList: orderByList?.call(TrainingDayEntity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingDayEntity] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<TrainingDayEntity?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingDayEntityTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingDayEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingDayEntityTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingDayEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingDayEntity>(
      where: where?.call(TrainingDayEntity.t),
      orderBy: orderBy?.call(TrainingDayEntity.t),
      orderByList: orderByList?.call(TrainingDayEntity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingDayEntity] by its [id] or null if no such row exists.
  Future<TrainingDayEntity?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TrainingDayEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingDayEntity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingDayEntity]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingDayEntity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingDayEntity>> insert(
    _i1.DatabaseSession session,
    List<TrainingDayEntity> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingDayEntity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingDayEntity] and returns the inserted row.
  ///
  /// The returned [TrainingDayEntity] will have its `id` field set.
  Future<TrainingDayEntity> insertRow(
    _i1.DatabaseSession session,
    TrainingDayEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingDayEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingDayEntity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingDayEntity>> update(
    _i1.DatabaseSession session,
    List<TrainingDayEntity> rows, {
    _i1.ColumnSelections<TrainingDayEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingDayEntity>(
      rows,
      columns: columns?.call(TrainingDayEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingDayEntity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingDayEntity> updateRow(
    _i1.DatabaseSession session,
    TrainingDayEntity row, {
    _i1.ColumnSelections<TrainingDayEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingDayEntity>(
      row,
      columns: columns?.call(TrainingDayEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingDayEntity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingDayEntity?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TrainingDayEntityUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingDayEntity>(
      id,
      columnValues: columnValues(TrainingDayEntity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingDayEntity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingDayEntity>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrainingDayEntityUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TrainingDayEntityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingDayEntityTable>? orderBy,
    _i1.OrderByListBuilder<TrainingDayEntityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingDayEntity>(
      columnValues: columnValues(TrainingDayEntity.t.updateTable),
      where: where(TrainingDayEntity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingDayEntity.t),
      orderByList: orderByList?.call(TrainingDayEntity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingDayEntity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingDayEntity>> delete(
    _i1.DatabaseSession session,
    List<TrainingDayEntity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingDayEntity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingDayEntity].
  Future<TrainingDayEntity> deleteRow(
    _i1.DatabaseSession session,
    TrainingDayEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingDayEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingDayEntity>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingDayEntityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingDayEntity>(
      where: where(TrainingDayEntity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingDayEntityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingDayEntity>(
      where: where?.call(TrainingDayEntity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingDayEntity] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingDayEntityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingDayEntity>(
      where: where(TrainingDayEntity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingDayEntityAttachRowRepository {
  const TrainingDayEntityAttachRowRepository._();

  /// Creates a relation between the given [TrainingDayEntity] and [TrainingScheduleEntity]
  /// by setting the [TrainingDayEntity]'s foreign key `scheduleId` to refer to the [TrainingScheduleEntity].
  Future<void> schedule(
    _i1.DatabaseSession session,
    TrainingDayEntity trainingDayEntity,
    _i2.TrainingScheduleEntity schedule, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingDayEntity.id == null) {
      throw ArgumentError.notNull('trainingDayEntity.id');
    }
    if (schedule.id == null) {
      throw ArgumentError.notNull('schedule.id');
    }

    var $trainingDayEntity = trainingDayEntity.copyWith(
      scheduleId: schedule.id,
    );
    await session.db.updateRow<TrainingDayEntity>(
      $trainingDayEntity,
      columns: [TrainingDayEntity.t.scheduleId],
      transaction: transaction,
    );
  }
}
