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
import '../history/workout_record_entity.dart' as _i2;
import 'package:backend_server/src/generated/protocol.dart' as _i3;

abstract class ExerciseRecordEntity
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  ExerciseRecordEntity._({
    this.id,
    required this.exercisePublicId,
    required this.name,
    required this.muscleGroup,
    required this.position,
    required this.workoutId,
    this.workout,
  });

  factory ExerciseRecordEntity({
    _i1.UuidValue? id,
    required String exercisePublicId,
    required String name,
    required String muscleGroup,
    required int position,
    required _i1.UuidValue workoutId,
    _i2.WorkoutRecordEntity? workout,
  }) = _ExerciseRecordEntityImpl;

  factory ExerciseRecordEntity.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ExerciseRecordEntity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      exercisePublicId: jsonSerialization['exercisePublicId'] as String,
      name: jsonSerialization['name'] as String,
      muscleGroup: jsonSerialization['muscleGroup'] as String,
      position: jsonSerialization['position'] as int,
      workoutId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['workoutId'],
      ),
      workout: jsonSerialization['workout'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.WorkoutRecordEntity>(
              jsonSerialization['workout'],
            ),
    );
  }

  static final t = ExerciseRecordEntityTable();

  static const db = ExerciseRecordEntityRepository._();

  @override
  _i1.UuidValue? id;

  String exercisePublicId;

  String name;

  String muscleGroup;

  int position;

  _i1.UuidValue workoutId;

  _i2.WorkoutRecordEntity? workout;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ExerciseRecordEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExerciseRecordEntity copyWith({
    _i1.UuidValue? id,
    String? exercisePublicId,
    String? name,
    String? muscleGroup,
    int? position,
    _i1.UuidValue? workoutId,
    _i2.WorkoutRecordEntity? workout,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseRecordEntity',
      if (id != null) 'id': id?.toJson(),
      'exercisePublicId': exercisePublicId,
      'name': name,
      'muscleGroup': muscleGroup,
      'position': position,
      'workoutId': workoutId.toJson(),
      if (workout != null) 'workout': workout?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ExerciseRecordEntityInclude include({
    _i2.WorkoutRecordEntityInclude? workout,
  }) {
    return ExerciseRecordEntityInclude._(workout: workout);
  }

  static ExerciseRecordEntityIncludeList includeList({
    _i1.WhereExpressionBuilder<ExerciseRecordEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseRecordEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseRecordEntityTable>? orderByList,
    ExerciseRecordEntityInclude? include,
  }) {
    return ExerciseRecordEntityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseRecordEntity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ExerciseRecordEntity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseRecordEntityImpl extends ExerciseRecordEntity {
  _ExerciseRecordEntityImpl({
    _i1.UuidValue? id,
    required String exercisePublicId,
    required String name,
    required String muscleGroup,
    required int position,
    required _i1.UuidValue workoutId,
    _i2.WorkoutRecordEntity? workout,
  }) : super._(
         id: id,
         exercisePublicId: exercisePublicId,
         name: name,
         muscleGroup: muscleGroup,
         position: position,
         workoutId: workoutId,
         workout: workout,
       );

  /// Returns a shallow copy of this [ExerciseRecordEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExerciseRecordEntity copyWith({
    Object? id = _Undefined,
    String? exercisePublicId,
    String? name,
    String? muscleGroup,
    int? position,
    _i1.UuidValue? workoutId,
    Object? workout = _Undefined,
  }) {
    return ExerciseRecordEntity(
      id: id is _i1.UuidValue? ? id : this.id,
      exercisePublicId: exercisePublicId ?? this.exercisePublicId,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      position: position ?? this.position,
      workoutId: workoutId ?? this.workoutId,
      workout: workout is _i2.WorkoutRecordEntity?
          ? workout
          : this.workout?.copyWith(),
    );
  }
}

class ExerciseRecordEntityUpdateTable
    extends _i1.UpdateTable<ExerciseRecordEntityTable> {
  ExerciseRecordEntityUpdateTable(super.table);

  _i1.ColumnValue<String, String> exercisePublicId(String value) =>
      _i1.ColumnValue(
        table.exercisePublicId,
        value,
      );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
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

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> workoutId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.workoutId,
    value,
  );
}

class ExerciseRecordEntityTable extends _i1.Table<_i1.UuidValue?> {
  ExerciseRecordEntityTable({super.tableRelation})
    : super(tableName: 'exercise_record') {
    updateTable = ExerciseRecordEntityUpdateTable(this);
    exercisePublicId = _i1.ColumnString(
      'exercisePublicId',
      this,
    );
    name = _i1.ColumnString(
      'name',
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
    workoutId = _i1.ColumnUuid(
      'workoutId',
      this,
    );
  }

  late final ExerciseRecordEntityUpdateTable updateTable;

  late final _i1.ColumnString exercisePublicId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString muscleGroup;

  late final _i1.ColumnInt position;

  late final _i1.ColumnUuid workoutId;

  _i2.WorkoutRecordEntityTable? _workout;

  _i2.WorkoutRecordEntityTable get workout {
    if (_workout != null) return _workout!;
    _workout = _i1.createRelationTable(
      relationFieldName: 'workout',
      field: ExerciseRecordEntity.t.workoutId,
      foreignField: _i2.WorkoutRecordEntity.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.WorkoutRecordEntityTable(tableRelation: foreignTableRelation),
    );
    return _workout!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    exercisePublicId,
    name,
    muscleGroup,
    position,
    workoutId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'workout') {
      return workout;
    }
    return null;
  }
}

class ExerciseRecordEntityInclude extends _i1.IncludeObject {
  ExerciseRecordEntityInclude._({_i2.WorkoutRecordEntityInclude? workout}) {
    _workout = workout;
  }

  _i2.WorkoutRecordEntityInclude? _workout;

  @override
  Map<String, _i1.Include?> get includes => {'workout': _workout};

  @override
  _i1.Table<_i1.UuidValue?> get table => ExerciseRecordEntity.t;
}

class ExerciseRecordEntityIncludeList extends _i1.IncludeList {
  ExerciseRecordEntityIncludeList._({
    _i1.WhereExpressionBuilder<ExerciseRecordEntityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExerciseRecordEntity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ExerciseRecordEntity.t;
}

class ExerciseRecordEntityRepository {
  const ExerciseRecordEntityRepository._();

  final attachRow = const ExerciseRecordEntityAttachRowRepository._();

  /// Returns a list of [ExerciseRecordEntity]s matching the given query parameters.
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
  Future<List<ExerciseRecordEntity>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExerciseRecordEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseRecordEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseRecordEntityTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseRecordEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ExerciseRecordEntity>(
      where: where?.call(ExerciseRecordEntity.t),
      orderBy: orderBy?.call(ExerciseRecordEntity.t),
      orderByList: orderByList?.call(ExerciseRecordEntity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ExerciseRecordEntity] matching the given query parameters.
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
  Future<ExerciseRecordEntity?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExerciseRecordEntityTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExerciseRecordEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExerciseRecordEntityTable>? orderByList,
    _i1.Transaction? transaction,
    ExerciseRecordEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ExerciseRecordEntity>(
      where: where?.call(ExerciseRecordEntity.t),
      orderBy: orderBy?.call(ExerciseRecordEntity.t),
      orderByList: orderByList?.call(ExerciseRecordEntity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ExerciseRecordEntity] by its [id] or null if no such row exists.
  Future<ExerciseRecordEntity?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    ExerciseRecordEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ExerciseRecordEntity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ExerciseRecordEntity]s in the list and returns the inserted rows.
  ///
  /// The returned [ExerciseRecordEntity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ExerciseRecordEntity>> insert(
    _i1.DatabaseSession session,
    List<ExerciseRecordEntity> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ExerciseRecordEntity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ExerciseRecordEntity] and returns the inserted row.
  ///
  /// The returned [ExerciseRecordEntity] will have its `id` field set.
  Future<ExerciseRecordEntity> insertRow(
    _i1.DatabaseSession session,
    ExerciseRecordEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExerciseRecordEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseRecordEntity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ExerciseRecordEntity>> update(
    _i1.DatabaseSession session,
    List<ExerciseRecordEntity> rows, {
    _i1.ColumnSelections<ExerciseRecordEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ExerciseRecordEntity>(
      rows,
      columns: columns?.call(ExerciseRecordEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseRecordEntity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExerciseRecordEntity> updateRow(
    _i1.DatabaseSession session,
    ExerciseRecordEntity row, {
    _i1.ColumnSelections<ExerciseRecordEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExerciseRecordEntity>(
      row,
      columns: columns?.call(ExerciseRecordEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExerciseRecordEntity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ExerciseRecordEntity?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<ExerciseRecordEntityUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ExerciseRecordEntity>(
      id,
      columnValues: columnValues(ExerciseRecordEntity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ExerciseRecordEntity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ExerciseRecordEntity>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ExerciseRecordEntityUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ExerciseRecordEntityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExerciseRecordEntityTable>? orderBy,
    _i1.OrderByListBuilder<ExerciseRecordEntityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ExerciseRecordEntity>(
      columnValues: columnValues(ExerciseRecordEntity.t.updateTable),
      where: where(ExerciseRecordEntity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExerciseRecordEntity.t),
      orderByList: orderByList?.call(ExerciseRecordEntity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ExerciseRecordEntity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ExerciseRecordEntity>> delete(
    _i1.DatabaseSession session,
    List<ExerciseRecordEntity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ExerciseRecordEntity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ExerciseRecordEntity].
  Future<ExerciseRecordEntity> deleteRow(
    _i1.DatabaseSession session,
    ExerciseRecordEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExerciseRecordEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ExerciseRecordEntity>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ExerciseRecordEntityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ExerciseRecordEntity>(
      where: where(ExerciseRecordEntity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExerciseRecordEntityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ExerciseRecordEntity>(
      where: where?.call(ExerciseRecordEntity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ExerciseRecordEntity] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ExerciseRecordEntityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ExerciseRecordEntity>(
      where: where(ExerciseRecordEntity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ExerciseRecordEntityAttachRowRepository {
  const ExerciseRecordEntityAttachRowRepository._();

  /// Creates a relation between the given [ExerciseRecordEntity] and [WorkoutRecordEntity]
  /// by setting the [ExerciseRecordEntity]'s foreign key `workoutId` to refer to the [WorkoutRecordEntity].
  Future<void> workout(
    _i1.DatabaseSession session,
    ExerciseRecordEntity exerciseRecordEntity,
    _i2.WorkoutRecordEntity workout, {
    _i1.Transaction? transaction,
  }) async {
    if (exerciseRecordEntity.id == null) {
      throw ArgumentError.notNull('exerciseRecordEntity.id');
    }
    if (workout.id == null) {
      throw ArgumentError.notNull('workout.id');
    }

    var $exerciseRecordEntity = exerciseRecordEntity.copyWith(
      workoutId: workout.id,
    );
    await session.db.updateRow<ExerciseRecordEntity>(
      $exerciseRecordEntity,
      columns: [ExerciseRecordEntity.t.workoutId],
      transaction: transaction,
    );
  }
}
