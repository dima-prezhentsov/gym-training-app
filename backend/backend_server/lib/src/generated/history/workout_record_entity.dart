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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i2;
import 'package:backend_server/src/generated/protocol.dart' as _i3;

abstract class WorkoutRecordEntity
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  WorkoutRecordEntity._({
    this.id,
    required this.publicId,
    required this.trainingDayPublicId,
    required this.title,
    required this.startedAt,
    required this.completedAt,
    required this.authUserId,
    this.authUser,
  });

  factory WorkoutRecordEntity({
    _i1.UuidValue? id,
    required String publicId,
    required String trainingDayPublicId,
    required String title,
    required DateTime startedAt,
    required DateTime completedAt,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
  }) = _WorkoutRecordEntityImpl;

  factory WorkoutRecordEntity.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutRecordEntity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      publicId: jsonSerialization['publicId'] as String,
      trainingDayPublicId: jsonSerialization['trainingDayPublicId'] as String,
      title: jsonSerialization['title'] as String,
      startedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      completedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
    );
  }

  static final t = WorkoutRecordEntityTable();

  static const db = WorkoutRecordEntityRepository._();

  @override
  _i1.UuidValue? id;

  String publicId;

  String trainingDayPublicId;

  String title;

  DateTime startedAt;

  DateTime completedAt;

  _i1.UuidValue authUserId;

  _i2.AuthUser? authUser;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [WorkoutRecordEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutRecordEntity copyWith({
    _i1.UuidValue? id,
    String? publicId,
    String? trainingDayPublicId,
    String? title,
    DateTime? startedAt,
    DateTime? completedAt,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutRecordEntity',
      if (id != null) 'id': id?.toJson(),
      'publicId': publicId,
      'trainingDayPublicId': trainingDayPublicId,
      'title': title,
      'startedAt': startedAt.toJson(),
      'completedAt': completedAt.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static WorkoutRecordEntityInclude include({_i2.AuthUserInclude? authUser}) {
    return WorkoutRecordEntityInclude._(authUser: authUser);
  }

  static WorkoutRecordEntityIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkoutRecordEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutRecordEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutRecordEntityTable>? orderByList,
    WorkoutRecordEntityInclude? include,
  }) {
    return WorkoutRecordEntityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutRecordEntity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkoutRecordEntity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutRecordEntityImpl extends WorkoutRecordEntity {
  _WorkoutRecordEntityImpl({
    _i1.UuidValue? id,
    required String publicId,
    required String trainingDayPublicId,
    required String title,
    required DateTime startedAt,
    required DateTime completedAt,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
  }) : super._(
         id: id,
         publicId: publicId,
         trainingDayPublicId: trainingDayPublicId,
         title: title,
         startedAt: startedAt,
         completedAt: completedAt,
         authUserId: authUserId,
         authUser: authUser,
       );

  /// Returns a shallow copy of this [WorkoutRecordEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutRecordEntity copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? trainingDayPublicId,
    String? title,
    DateTime? startedAt,
    DateTime? completedAt,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
  }) {
    return WorkoutRecordEntity(
      id: id is _i1.UuidValue? ? id : this.id,
      publicId: publicId ?? this.publicId,
      trainingDayPublicId: trainingDayPublicId ?? this.trainingDayPublicId,
      title: title ?? this.title,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
    );
  }
}

class WorkoutRecordEntityUpdateTable
    extends _i1.UpdateTable<WorkoutRecordEntityTable> {
  WorkoutRecordEntityUpdateTable(super.table);

  _i1.ColumnValue<String, String> publicId(String value) => _i1.ColumnValue(
    table.publicId,
    value,
  );

  _i1.ColumnValue<String, String> trainingDayPublicId(String value) =>
      _i1.ColumnValue(
        table.trainingDayPublicId,
        value,
      );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );
}

class WorkoutRecordEntityTable extends _i1.Table<_i1.UuidValue?> {
  WorkoutRecordEntityTable({super.tableRelation})
    : super(tableName: 'workout_record') {
    updateTable = WorkoutRecordEntityUpdateTable(this);
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    trainingDayPublicId = _i1.ColumnString(
      'trainingDayPublicId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
  }

  late final WorkoutRecordEntityUpdateTable updateTable;

  late final _i1.ColumnString publicId;

  late final _i1.ColumnString trainingDayPublicId;

  late final _i1.ColumnString title;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnUuid authUserId;

  _i2.AuthUserTable? _authUser;

  _i2.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _i1.createRelationTable(
      relationFieldName: 'authUser',
      field: WorkoutRecordEntity.t.authUserId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    publicId,
    trainingDayPublicId,
    title,
    startedAt,
    completedAt,
    authUserId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class WorkoutRecordEntityInclude extends _i1.IncludeObject {
  WorkoutRecordEntityInclude._({_i2.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _i2.AuthUserInclude? _authUser;

  @override
  Map<String, _i1.Include?> get includes => {'authUser': _authUser};

  @override
  _i1.Table<_i1.UuidValue?> get table => WorkoutRecordEntity.t;
}

class WorkoutRecordEntityIncludeList extends _i1.IncludeList {
  WorkoutRecordEntityIncludeList._({
    _i1.WhereExpressionBuilder<WorkoutRecordEntityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutRecordEntity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => WorkoutRecordEntity.t;
}

class WorkoutRecordEntityRepository {
  const WorkoutRecordEntityRepository._();

  final attachRow = const WorkoutRecordEntityAttachRowRepository._();

  /// Returns a list of [WorkoutRecordEntity]s matching the given query parameters.
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
  Future<List<WorkoutRecordEntity>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutRecordEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutRecordEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutRecordEntityTable>? orderByList,
    _i1.Transaction? transaction,
    WorkoutRecordEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutRecordEntity>(
      where: where?.call(WorkoutRecordEntity.t),
      orderBy: orderBy?.call(WorkoutRecordEntity.t),
      orderByList: orderByList?.call(WorkoutRecordEntity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutRecordEntity] matching the given query parameters.
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
  Future<WorkoutRecordEntity?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutRecordEntityTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkoutRecordEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutRecordEntityTable>? orderByList,
    _i1.Transaction? transaction,
    WorkoutRecordEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutRecordEntity>(
      where: where?.call(WorkoutRecordEntity.t),
      orderBy: orderBy?.call(WorkoutRecordEntity.t),
      orderByList: orderByList?.call(WorkoutRecordEntity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutRecordEntity] by its [id] or null if no such row exists.
  Future<WorkoutRecordEntity?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    WorkoutRecordEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutRecordEntity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutRecordEntity]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutRecordEntity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WorkoutRecordEntity>> insert(
    _i1.DatabaseSession session,
    List<WorkoutRecordEntity> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WorkoutRecordEntity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WorkoutRecordEntity] and returns the inserted row.
  ///
  /// The returned [WorkoutRecordEntity] will have its `id` field set.
  Future<WorkoutRecordEntity> insertRow(
    _i1.DatabaseSession session,
    WorkoutRecordEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutRecordEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutRecordEntity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkoutRecordEntity>> update(
    _i1.DatabaseSession session,
    List<WorkoutRecordEntity> rows, {
    _i1.ColumnSelections<WorkoutRecordEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkoutRecordEntity>(
      rows,
      columns: columns?.call(WorkoutRecordEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutRecordEntity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutRecordEntity> updateRow(
    _i1.DatabaseSession session,
    WorkoutRecordEntity row, {
    _i1.ColumnSelections<WorkoutRecordEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutRecordEntity>(
      row,
      columns: columns?.call(WorkoutRecordEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutRecordEntity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutRecordEntity?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<WorkoutRecordEntityUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutRecordEntity>(
      id,
      columnValues: columnValues(WorkoutRecordEntity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutRecordEntity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkoutRecordEntity>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WorkoutRecordEntityUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<WorkoutRecordEntityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutRecordEntityTable>? orderBy,
    _i1.OrderByListBuilder<WorkoutRecordEntityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkoutRecordEntity>(
      columnValues: columnValues(WorkoutRecordEntity.t.updateTable),
      where: where(WorkoutRecordEntity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutRecordEntity.t),
      orderByList: orderByList?.call(WorkoutRecordEntity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkoutRecordEntity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkoutRecordEntity>> delete(
    _i1.DatabaseSession session,
    List<WorkoutRecordEntity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkoutRecordEntity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkoutRecordEntity].
  Future<WorkoutRecordEntity> deleteRow(
    _i1.DatabaseSession session,
    WorkoutRecordEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutRecordEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkoutRecordEntity>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutRecordEntityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkoutRecordEntity>(
      where: where(WorkoutRecordEntity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutRecordEntityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutRecordEntity>(
      where: where?.call(WorkoutRecordEntity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutRecordEntity] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutRecordEntityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutRecordEntity>(
      where: where(WorkoutRecordEntity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class WorkoutRecordEntityAttachRowRepository {
  const WorkoutRecordEntityAttachRowRepository._();

  /// Creates a relation between the given [WorkoutRecordEntity] and [AuthUser]
  /// by setting the [WorkoutRecordEntity]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _i1.DatabaseSession session,
    WorkoutRecordEntity workoutRecordEntity,
    _i2.AuthUser authUser, {
    _i1.Transaction? transaction,
  }) async {
    if (workoutRecordEntity.id == null) {
      throw ArgumentError.notNull('workoutRecordEntity.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $workoutRecordEntity = workoutRecordEntity.copyWith(
      authUserId: authUser.id,
    );
    await session.db.updateRow<WorkoutRecordEntity>(
      $workoutRecordEntity,
      columns: [WorkoutRecordEntity.t.authUserId],
      transaction: transaction,
    );
  }
}
