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
import '../schedule/training_day_entity.dart' as _i2;
import 'package:backend_server/src/generated/protocol.dart' as _i3;

/// An exercise within a persisted training day.
abstract class ExerciseEntity
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  ExerciseEntity._({
    this.id,
    required this.publicId,
    required this.name,
    required this.description,
    required this.muscleGroup,
    required this.position,
    required this.trainingDayId,
    this.trainingDay,
  });

  factory ExerciseEntity({
    _i1.UuidValue? id,
    required String publicId,
    required String name,
    required String description,
    required String muscleGroup,
    required int position,
    required _i1.UuidValue trainingDayId,
    _i2.TrainingDayEntity? trainingDay,
  }) = _ExerciseEntityImpl;

  factory ExerciseEntity.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseEntity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      publicId: jsonSerialization['publicId'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      muscleGroup: jsonSerialization['muscleGroup'] as String,
      position: jsonSerialization['position'] as int,
      trainingDayId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['trainingDayId'],
      ),
      trainingDay: jsonSerialization['trainingDay'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.TrainingDayEntity>(
              jsonSerialization['trainingDay'],
            ),
    );
  }

  static final t = ExerciseEntityTable();

  static const db = ExerciseEntityRepository._();

  @override
  _i1.UuidValue? id;

  String publicId;

  String name;

  String description;

  String muscleGroup;

  int position;

  _i1.UuidValue trainingDayId;

  _i2.TrainingDayEntity? trainingDay;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ExerciseEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseEntity copyWith({
    _i1.UuidValue? id,
    String? publicId,
    String? name,
    String? description,
    String? muscleGroup,
    int? position,
    _i1.UuidValue? trainingDayId,
    _i2.TrainingDayEntity? trainingDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseEntity',
      if (id != null) 'id': id?.toJson(),
      'publicId': publicId,
      'name': name,
      'description': description,
      'muscleGroup': muscleGroup,
      'position': position,
      'trainingDayId': trainingDayId.toJson(),
      if (trainingDay != null) 'trainingDay': trainingDay?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ExerciseEntityInclude include({
    _i2.TrainingDayEntityInclude? trainingDay,
  }) {
    return ExerciseEntityInclude._(trainingDay: trainingDay);
  }

  static ExerciseEntityIncludeList includeList({
    _i1.WhereExpressionBuilder<ExerciseEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseEntityTable>? orderByList,
    ExerciseEntityInclude? include,
  }) {
    return ExerciseEntityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseEntity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ExerciseEntity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseEntityImpl extends ExerciseEntity {
  _ExerciseEntityImpl({
    _i1.UuidValue? id,
    required String publicId,
    required String name,
    required String description,
    required String muscleGroup,
    required int position,
    required _i1.UuidValue trainingDayId,
    _i2.TrainingDayEntity? trainingDay,
  }) : super._(
         id: id,
         publicId: publicId,
         name: name,
         description: description,
         muscleGroup: muscleGroup,
         position: position,
         trainingDayId: trainingDayId,
         trainingDay: trainingDay,
       );

  /// Returns a shallow copy of this [ExerciseEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseEntity copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? name,
    String? description,
    String? muscleGroup,
    int? position,
    _i1.UuidValue? trainingDayId,
    Object? trainingDay = _Undefined,
  }) {
    return ExerciseEntity(
      id: id is _i1.UuidValue? ? id : this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      description: description ?? this.description,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      position: position ?? this.position,
      trainingDayId: trainingDayId ?? this.trainingDayId,
      trainingDay: trainingDay is _i2.TrainingDayEntity?
          ? trainingDay
          : this.trainingDay?.copyWith(),
    );
  }
}

class ExerciseEntityUpdateTable extends _i1.UpdateTable<ExerciseEntityTable> {
  ExerciseEntityUpdateTable(super.table);

  _i1.ColumnValue<String, String> publicId(String value) => _i1.ColumnValue(
    table.publicId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> muscleGroup(String value) => _i1.ColumnValue(
    table.muscleGroup,
    value,
  );

  _i1.ColumnValue<int, int> position(int value) => _i1.ColumnValue(
    table.position,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> trainingDayId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.trainingDayId,
    value,
  );
}

class ExerciseEntityTable extends _i1.Table<_i1.UuidValue?> {
  ExerciseEntityTable({super.tableRelation}) : super(tableName: 'exercise') {
    updateTable = ExerciseEntityUpdateTable(this);
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    muscleGroup = _i1.ColumnString(
      'muscleGroup',
      this,
    );
    position = _i1.ColumnInt(
      'position',
      this,
    );
    trainingDayId = _i1.ColumnUuid(
      'trainingDayId',
      this,
    );
  }

  late final ExerciseEntityUpdateTable updateTable;

  late final _i1.ColumnString publicId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString muscleGroup;

  late final _i1.ColumnInt position;

  late final _i1.ColumnUuid trainingDayId;

  _i2.TrainingDayEntityTable? _trainingDay;

  _i2.TrainingDayEntityTable get trainingDay {
    if (_trainingDay != null) return _trainingDay!;
    _trainingDay = _i1.createRelationTable(
      relationFieldName: 'trainingDay',
      field: ExerciseEntity.t.trainingDayId,
      foreignField: _i2.TrainingDayEntity.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TrainingDayEntityTable(tableRelation: foreignTableRelation),
    );
    return _trainingDay!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    publicId,
    name,
    description,
    muscleGroup,
    position,
    trainingDayId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'trainingDay') {
      return trainingDay;
    }
    return null;
  }
}

class ExerciseEntityInclude extends _i1.IncludeObject {
  ExerciseEntityInclude._({_i2.TrainingDayEntityInclude? trainingDay}) {
    _trainingDay = trainingDay;
  }

  _i2.TrainingDayEntityInclude? _trainingDay;

  @override
  Map<String, _i1.Include?> get includes => {'trainingDay': _trainingDay};

  @override
  _i1.Table<_i1.UuidValue?> get table => ExerciseEntity.t;
}

class ExerciseEntityIncludeList extends _i1.IncludeList {
  ExerciseEntityIncludeList._({
    _i1.WhereExpressionBuilder<ExerciseEntityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExerciseEntity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ExerciseEntity.t;
}

class ExerciseEntityRepository {
  const ExerciseEntityRepository._();

  final attachRow = const ExerciseEntityAttachRowRepository._();

  /// Returns a list of [ExerciseEntity]s matching the given query parameters.
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
  Future<List<ExerciseEntity>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExerciseEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseEntityTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ExerciseEntity>(
      where: where?.call(ExerciseEntity.t),
      orderBy: orderBy?.call(ExerciseEntity.t),
      orderByList: orderByList?.call(ExerciseEntity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ExerciseEntity] matching the given query parameters.
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
  Future<ExerciseEntity?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExerciseEntityTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExerciseEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseEntityTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ExerciseEntity>(
      where: where?.call(ExerciseEntity.t),
      orderBy: orderBy?.call(ExerciseEntity.t),
      orderByList: orderByList?.call(ExerciseEntity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ExerciseEntity] by its [id] or null if no such row exists.
  Future<ExerciseEntity?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    ExerciseEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ExerciseEntity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ExerciseEntity]s in the list and returns the inserted rows.
  ///
  /// The returned [ExerciseEntity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ExerciseEntity>> insert(
    _i1.DatabaseSession session,
    List<ExerciseEntity> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ExerciseEntity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ExerciseEntity] and returns the inserted row.
  ///
  /// The returned [ExerciseEntity] will have its `id` field set.
  Future<ExerciseEntity> insertRow(
    _i1.DatabaseSession session,
    ExerciseEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExerciseEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseEntity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ExerciseEntity>> update(
    _i1.DatabaseSession session,
    List<ExerciseEntity> rows, {
    _i1.ColumnSelections<ExerciseEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ExerciseEntity>(
      rows,
      columns: columns?.call(ExerciseEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseEntity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExerciseEntity> updateRow(
    _i1.DatabaseSession session,
    ExerciseEntity row, {
    _i1.ColumnSelections<ExerciseEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExerciseEntity>(
      row,
      columns: columns?.call(ExerciseEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseEntity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ExerciseEntity?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<ExerciseEntityUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ExerciseEntity>(
      id,
      columnValues: columnValues(ExerciseEntity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseEntity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ExerciseEntity>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ExerciseEntityUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ExerciseEntityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseEntityTable>? orderBy,
    _i1.OrderByListBuilder<ExerciseEntityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ExerciseEntity>(
      columnValues: columnValues(ExerciseEntity.t.updateTable),
      where: where(ExerciseEntity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseEntity.t),
      orderByList: orderByList?.call(ExerciseEntity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ExerciseEntity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ExerciseEntity>> delete(
    _i1.DatabaseSession session,
    List<ExerciseEntity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ExerciseEntity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ExerciseEntity].
  Future<ExerciseEntity> deleteRow(
    _i1.DatabaseSession session,
    ExerciseEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExerciseEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ExerciseEntity>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ExerciseEntityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ExerciseEntity>(
      where: where(ExerciseEntity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExerciseEntityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ExerciseEntity>(
      where: where?.call(ExerciseEntity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ExerciseEntity] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ExerciseEntityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ExerciseEntity>(
      where: where(ExerciseEntity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ExerciseEntityAttachRowRepository {
  const ExerciseEntityAttachRowRepository._();

  /// Creates a relation between the given [ExerciseEntity] and [TrainingDayEntity]
  /// by setting the [ExerciseEntity]'s foreign key `trainingDayId` to refer to the [TrainingDayEntity].
  Future<void> trainingDay(
    _i1.DatabaseSession session,
    ExerciseEntity exerciseEntity,
    _i2.TrainingDayEntity trainingDay, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseEntity.id == null) {
      throw ArgumentError.notNull('exerciseEntity.id');
    }
    if (trainingDay.id == null) {
      throw ArgumentError.notNull('trainingDay.id');
    }

    var $exerciseEntity = exerciseEntity.copyWith(
      trainingDayId: trainingDay.id,
    );
    await session.db.updateRow<ExerciseEntity>(
      $exerciseEntity,
      columns: [ExerciseEntity.t.trainingDayId],
      transaction: transaction,
    );
  }
}
