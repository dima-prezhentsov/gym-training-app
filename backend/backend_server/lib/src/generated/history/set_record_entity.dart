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
import '../history/exercise_record_entity.dart' as _i2;
import 'package:backend_server/src/generated/protocol.dart' as _i3;

abstract class SetRecordEntity
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  SetRecordEntity._({
    this.id,
    required this.publicId,
    required this.repetitions,
    required this.weightKg,
    required this.position,
    required this.exerciseRecordId,
    this.exerciseRecord,
  });

  factory SetRecordEntity({
    _i1.UuidValue? id,
    required String publicId,
    required int repetitions,
    required double weightKg,
    required int position,
    required _i1.UuidValue exerciseRecordId,
    _i2.ExerciseRecordEntity? exerciseRecord,
  }) = _SetRecordEntityImpl;

  factory SetRecordEntity.fromJson(Map<String, dynamic> jsonSerialization) {
    return SetRecordEntity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      publicId: jsonSerialization['publicId'] as String,
      repetitions: jsonSerialization['repetitions'] as int,
      weightKg: (jsonSerialization['weightKg'] as num).toDouble(),
      position: jsonSerialization['position'] as int,
      exerciseRecordId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['exerciseRecordId'],
      ),
      exerciseRecord: jsonSerialization['exerciseRecord'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.ExerciseRecordEntity>(
              jsonSerialization['exerciseRecord'],
            ),
    );
  }

  static final t = SetRecordEntityTable();

  static const db = SetRecordEntityRepository._();

  @override
  _i1.UuidValue? id;

  String publicId;

  int repetitions;

  double weightKg;

  int position;

  _i1.UuidValue exerciseRecordId;

  _i2.ExerciseRecordEntity? exerciseRecord;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SetRecordEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SetRecordEntity copyWith({
    _i1.UuidValue? id,
    String? publicId,
    int? repetitions,
    double? weightKg,
    int? position,
    _i1.UuidValue? exerciseRecordId,
    _i2.ExerciseRecordEntity? exerciseRecord,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SetRecordEntity',
      if (id != null) 'id': id?.toJson(),
      'publicId': publicId,
      'repetitions': repetitions,
      'weightKg': weightKg,
      'position': position,
      'exerciseRecordId': exerciseRecordId.toJson(),
      if (exerciseRecord != null) 'exerciseRecord': exerciseRecord?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static SetRecordEntityInclude include({
    _i2.ExerciseRecordEntityInclude? exerciseRecord,
  }) {
    return SetRecordEntityInclude._(exerciseRecord: exerciseRecord);
  }

  static SetRecordEntityIncludeList includeList({
    _i1.WhereExpressionBuilder<SetRecordEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SetRecordEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SetRecordEntityTable>? orderByList,
    SetRecordEntityInclude? include,
  }) {
    return SetRecordEntityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SetRecordEntity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SetRecordEntity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SetRecordEntityImpl extends SetRecordEntity {
  _SetRecordEntityImpl({
    _i1.UuidValue? id,
    required String publicId,
    required int repetitions,
    required double weightKg,
    required int position,
    required _i1.UuidValue exerciseRecordId,
    _i2.ExerciseRecordEntity? exerciseRecord,
  }) : super._(
         id: id,
         publicId: publicId,
         repetitions: repetitions,
         weightKg: weightKg,
         position: position,
         exerciseRecordId: exerciseRecordId,
         exerciseRecord: exerciseRecord,
       );

  /// Returns a shallow copy of this [SetRecordEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SetRecordEntity copyWith({
    Object? id = _Undefined,
    String? publicId,
    int? repetitions,
    double? weightKg,
    int? position,
    _i1.UuidValue? exerciseRecordId,
    Object? exerciseRecord = _Undefined,
  }) {
    return SetRecordEntity(
      id: id is _i1.UuidValue? ? id : this.id,
      publicId: publicId ?? this.publicId,
      repetitions: repetitions ?? this.repetitions,
      weightKg: weightKg ?? this.weightKg,
      position: position ?? this.position,
      exerciseRecordId: exerciseRecordId ?? this.exerciseRecordId,
      exerciseRecord: exerciseRecord is _i2.ExerciseRecordEntity?
          ? exerciseRecord
          : this.exerciseRecord?.copyWith(),
    );
  }
}

class SetRecordEntityUpdateTable extends _i1.UpdateTable<SetRecordEntityTable> {
  SetRecordEntityUpdateTable(super.table);

  _i1.ColumnValue<String, String> publicId(String value) => _i1.ColumnValue(
    table.publicId,
    value,
  );

  _i1.ColumnValue<int, int> repetitions(int value) => _i1.ColumnValue(
    table.repetitions,
    value,
  );

  _i1.ColumnValue<double, double> weightKg(double value) => _i1.ColumnValue(
    table.weightKg,
    value,
  );

  _i1.ColumnValue<int, int> position(int value) => _i1.ColumnValue(
    table.position,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> exerciseRecordId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.exerciseRecordId,
    value,
  );
}

class SetRecordEntityTable extends _i1.Table<_i1.UuidValue?> {
  SetRecordEntityTable({super.tableRelation}) : super(tableName: 'set_record') {
    updateTable = SetRecordEntityUpdateTable(this);
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    repetitions = _i1.ColumnInt(
      'repetitions',
      this,
    );
    weightKg = _i1.ColumnDouble(
      'weightKg',
      this,
    );
    position = _i1.ColumnInt(
      'position',
      this,
    );
    exerciseRecordId = _i1.ColumnUuid(
      'exerciseRecordId',
      this,
    );
  }

  late final SetRecordEntityUpdateTable updateTable;

  late final _i1.ColumnString publicId;

  late final _i1.ColumnInt repetitions;

  late final _i1.ColumnDouble weightKg;

  late final _i1.ColumnInt position;

  late final _i1.ColumnUuid exerciseRecordId;

  _i2.ExerciseRecordEntityTable? _exerciseRecord;

  _i2.ExerciseRecordEntityTable get exerciseRecord {
    if (_exerciseRecord != null) return _exerciseRecord!;
    _exerciseRecord = _i1.createRelationTable(
      relationFieldName: 'exerciseRecord',
      field: SetRecordEntity.t.exerciseRecordId,
      foreignField: _i2.ExerciseRecordEntity.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ExerciseRecordEntityTable(tableRelation: foreignTableRelation),
    );
    return _exerciseRecord!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    publicId,
    repetitions,
    weightKg,
    position,
    exerciseRecordId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'exerciseRecord') {
      return exerciseRecord;
    }
    return null;
  }
}

class SetRecordEntityInclude extends _i1.IncludeObject {
  SetRecordEntityInclude._({_i2.ExerciseRecordEntityInclude? exerciseRecord}) {
    _exerciseRecord = exerciseRecord;
  }

  _i2.ExerciseRecordEntityInclude? _exerciseRecord;

  @override
  Map<String, _i1.Include?> get includes => {'exerciseRecord': _exerciseRecord};

  @override
  _i1.Table<_i1.UuidValue?> get table => SetRecordEntity.t;
}

class SetRecordEntityIncludeList extends _i1.IncludeList {
  SetRecordEntityIncludeList._({
    _i1.WhereExpressionBuilder<SetRecordEntityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SetRecordEntity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => SetRecordEntity.t;
}

class SetRecordEntityRepository {
  const SetRecordEntityRepository._();

  final attachRow = const SetRecordEntityAttachRowRepository._();

  /// Returns a list of [SetRecordEntity]s matching the given query parameters.
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
  Future<List<SetRecordEntity>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SetRecordEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SetRecordEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SetRecordEntityTable>? orderByList,
    _i1.Transaction? transaction,
    SetRecordEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SetRecordEntity>(
      where: where?.call(SetRecordEntity.t),
      orderBy: orderBy?.call(SetRecordEntity.t),
      orderByList: orderByList?.call(SetRecordEntity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SetRecordEntity] matching the given query parameters.
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
  Future<SetRecordEntity?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SetRecordEntityTable>? where,
    int? offset,
    _i1.OrderByBuilder<SetRecordEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SetRecordEntityTable>? orderByList,
    _i1.Transaction? transaction,
    SetRecordEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SetRecordEntity>(
      where: where?.call(SetRecordEntity.t),
      orderBy: orderBy?.call(SetRecordEntity.t),
      orderByList: orderByList?.call(SetRecordEntity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SetRecordEntity] by its [id] or null if no such row exists.
  Future<SetRecordEntity?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    SetRecordEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SetRecordEntity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SetRecordEntity]s in the list and returns the inserted rows.
  ///
  /// The returned [SetRecordEntity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SetRecordEntity>> insert(
    _i1.DatabaseSession session,
    List<SetRecordEntity> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SetRecordEntity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SetRecordEntity] and returns the inserted row.
  ///
  /// The returned [SetRecordEntity] will have its `id` field set.
  Future<SetRecordEntity> insertRow(
    _i1.DatabaseSession session,
    SetRecordEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SetRecordEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SetRecordEntity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SetRecordEntity>> update(
    _i1.DatabaseSession session,
    List<SetRecordEntity> rows, {
    _i1.ColumnSelections<SetRecordEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SetRecordEntity>(
      rows,
      columns: columns?.call(SetRecordEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SetRecordEntity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SetRecordEntity> updateRow(
    _i1.DatabaseSession session,
    SetRecordEntity row, {
    _i1.ColumnSelections<SetRecordEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SetRecordEntity>(
      row,
      columns: columns?.call(SetRecordEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SetRecordEntity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SetRecordEntity?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<SetRecordEntityUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SetRecordEntity>(
      id,
      columnValues: columnValues(SetRecordEntity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SetRecordEntity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SetRecordEntity>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SetRecordEntityUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SetRecordEntityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SetRecordEntityTable>? orderBy,
    _i1.OrderByListBuilder<SetRecordEntityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SetRecordEntity>(
      columnValues: columnValues(SetRecordEntity.t.updateTable),
      where: where(SetRecordEntity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SetRecordEntity.t),
      orderByList: orderByList?.call(SetRecordEntity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SetRecordEntity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SetRecordEntity>> delete(
    _i1.DatabaseSession session,
    List<SetRecordEntity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SetRecordEntity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SetRecordEntity].
  Future<SetRecordEntity> deleteRow(
    _i1.DatabaseSession session,
    SetRecordEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SetRecordEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SetRecordEntity>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SetRecordEntityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SetRecordEntity>(
      where: where(SetRecordEntity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SetRecordEntityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SetRecordEntity>(
      where: where?.call(SetRecordEntity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SetRecordEntity] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SetRecordEntityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SetRecordEntity>(
      where: where(SetRecordEntity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SetRecordEntityAttachRowRepository {
  const SetRecordEntityAttachRowRepository._();

  /// Creates a relation between the given [SetRecordEntity] and [ExerciseRecordEntity]
  /// by setting the [SetRecordEntity]'s foreign key `exerciseRecordId` to refer to the [ExerciseRecordEntity].
  Future<void> exerciseRecord(
    _i1.DatabaseSession session,
    SetRecordEntity setRecordEntity,
    _i2.ExerciseRecordEntity exerciseRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (setRecordEntity.id == null) {
      throw ArgumentError.notNull('setRecordEntity.id');
    }
    if (exerciseRecord.id == null) {
      throw ArgumentError.notNull('exerciseRecord.id');
    }

    var $setRecordEntity = setRecordEntity.copyWith(
      exerciseRecordId: exerciseRecord.id,
    );
    await session.db.updateRow<SetRecordEntity>(
      $setRecordEntity,
      columns: [SetRecordEntity.t.exerciseRecordId],
      transaction: transaction,
    );
  }
}
