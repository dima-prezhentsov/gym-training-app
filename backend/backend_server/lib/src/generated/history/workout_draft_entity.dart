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

/// One active workout draft per account.
abstract class WorkoutDraftEntity
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  WorkoutDraftEntity._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.recordJson,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory WorkoutDraftEntity({
    _i1.UuidValue? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    required String recordJson,
    DateTime? updatedAt,
  }) = _WorkoutDraftEntityImpl;

  factory WorkoutDraftEntity.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutDraftEntity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
      recordJson: jsonSerialization['recordJson'] as String,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = WorkoutDraftEntityTable();

  static const db = WorkoutDraftEntityRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue authUserId;

  _i2.AuthUser? authUser;

  String recordJson;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [WorkoutDraftEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutDraftEntity copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    String? recordJson,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutDraftEntity',
      if (id != null) 'id': id?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'recordJson': recordJson,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static WorkoutDraftEntityInclude include({_i2.AuthUserInclude? authUser}) {
    return WorkoutDraftEntityInclude._(authUser: authUser);
  }

  static WorkoutDraftEntityIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkoutDraftEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutDraftEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutDraftEntityTable>? orderByList,
    WorkoutDraftEntityInclude? include,
  }) {
    return WorkoutDraftEntityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutDraftEntity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkoutDraftEntity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutDraftEntityImpl extends WorkoutDraftEntity {
  _WorkoutDraftEntityImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    required String recordJson,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         recordJson: recordJson,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WorkoutDraftEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutDraftEntity copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? recordJson,
    DateTime? updatedAt,
  }) {
    return WorkoutDraftEntity(
      id: id is _i1.UuidValue? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      recordJson: recordJson ?? this.recordJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WorkoutDraftEntityUpdateTable
    extends _i1.UpdateTable<WorkoutDraftEntityTable> {
  WorkoutDraftEntityUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<String, String> recordJson(String value) => _i1.ColumnValue(
    table.recordJson,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class WorkoutDraftEntityTable extends _i1.Table<_i1.UuidValue?> {
  WorkoutDraftEntityTable({super.tableRelation})
    : super(tableName: 'workout_draft') {
    updateTable = WorkoutDraftEntityUpdateTable(this);
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    recordJson = _i1.ColumnString(
      'recordJson',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final WorkoutDraftEntityUpdateTable updateTable;

  late final _i1.ColumnUuid authUserId;

  _i2.AuthUserTable? _authUser;

  late final _i1.ColumnString recordJson;

  late final _i1.ColumnDateTime updatedAt;

  _i2.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _i1.createRelationTable(
      relationFieldName: 'authUser',
      field: WorkoutDraftEntity.t.authUserId,
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
    authUserId,
    recordJson,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class WorkoutDraftEntityInclude extends _i1.IncludeObject {
  WorkoutDraftEntityInclude._({_i2.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _i2.AuthUserInclude? _authUser;

  @override
  Map<String, _i1.Include?> get includes => {'authUser': _authUser};

  @override
  _i1.Table<_i1.UuidValue?> get table => WorkoutDraftEntity.t;
}

class WorkoutDraftEntityIncludeList extends _i1.IncludeList {
  WorkoutDraftEntityIncludeList._({
    _i1.WhereExpressionBuilder<WorkoutDraftEntityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutDraftEntity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => WorkoutDraftEntity.t;
}

class WorkoutDraftEntityRepository {
  const WorkoutDraftEntityRepository._();

  final attachRow = const WorkoutDraftEntityAttachRowRepository._();

  /// Returns a list of [WorkoutDraftEntity]s matching the given query parameters.
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
  Future<List<WorkoutDraftEntity>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutDraftEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutDraftEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutDraftEntityTable>? orderByList,
    _i1.Transaction? transaction,
    WorkoutDraftEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutDraftEntity>(
      where: where?.call(WorkoutDraftEntity.t),
      orderBy: orderBy?.call(WorkoutDraftEntity.t),
      orderByList: orderByList?.call(WorkoutDraftEntity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutDraftEntity] matching the given query parameters.
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
  Future<WorkoutDraftEntity?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutDraftEntityTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkoutDraftEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutDraftEntityTable>? orderByList,
    _i1.Transaction? transaction,
    WorkoutDraftEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutDraftEntity>(
      where: where?.call(WorkoutDraftEntity.t),
      orderBy: orderBy?.call(WorkoutDraftEntity.t),
      orderByList: orderByList?.call(WorkoutDraftEntity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutDraftEntity] by its [id] or null if no such row exists.
  Future<WorkoutDraftEntity?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    WorkoutDraftEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutDraftEntity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutDraftEntity]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutDraftEntity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WorkoutDraftEntity>> insert(
    _i1.DatabaseSession session,
    List<WorkoutDraftEntity> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WorkoutDraftEntity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WorkoutDraftEntity] and returns the inserted row.
  ///
  /// The returned [WorkoutDraftEntity] will have its `id` field set.
  Future<WorkoutDraftEntity> insertRow(
    _i1.DatabaseSession session,
    WorkoutDraftEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutDraftEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutDraftEntity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkoutDraftEntity>> update(
    _i1.DatabaseSession session,
    List<WorkoutDraftEntity> rows, {
    _i1.ColumnSelections<WorkoutDraftEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkoutDraftEntity>(
      rows,
      columns: columns?.call(WorkoutDraftEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutDraftEntity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutDraftEntity> updateRow(
    _i1.DatabaseSession session,
    WorkoutDraftEntity row, {
    _i1.ColumnSelections<WorkoutDraftEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutDraftEntity>(
      row,
      columns: columns?.call(WorkoutDraftEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutDraftEntity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutDraftEntity?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<WorkoutDraftEntityUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutDraftEntity>(
      id,
      columnValues: columnValues(WorkoutDraftEntity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutDraftEntity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkoutDraftEntity>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WorkoutDraftEntityUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<WorkoutDraftEntityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutDraftEntityTable>? orderBy,
    _i1.OrderByListBuilder<WorkoutDraftEntityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkoutDraftEntity>(
      columnValues: columnValues(WorkoutDraftEntity.t.updateTable),
      where: where(WorkoutDraftEntity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutDraftEntity.t),
      orderByList: orderByList?.call(WorkoutDraftEntity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkoutDraftEntity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkoutDraftEntity>> delete(
    _i1.DatabaseSession session,
    List<WorkoutDraftEntity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkoutDraftEntity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkoutDraftEntity].
  Future<WorkoutDraftEntity> deleteRow(
    _i1.DatabaseSession session,
    WorkoutDraftEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutDraftEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkoutDraftEntity>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutDraftEntityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkoutDraftEntity>(
      where: where(WorkoutDraftEntity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutDraftEntityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutDraftEntity>(
      where: where?.call(WorkoutDraftEntity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutDraftEntity] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutDraftEntityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutDraftEntity>(
      where: where(WorkoutDraftEntity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class WorkoutDraftEntityAttachRowRepository {
  const WorkoutDraftEntityAttachRowRepository._();

  /// Creates a relation between the given [WorkoutDraftEntity] and [AuthUser]
  /// by setting the [WorkoutDraftEntity]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _i1.DatabaseSession session,
    WorkoutDraftEntity workoutDraftEntity,
    _i2.AuthUser authUser, {
    _i1.Transaction? transaction,
  }) async {
    if (workoutDraftEntity.id == null) {
      throw ArgumentError.notNull('workoutDraftEntity.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $workoutDraftEntity = workoutDraftEntity.copyWith(
      authUserId: authUser.id,
    );
    await session.db.updateRow<WorkoutDraftEntity>(
      $workoutDraftEntity,
      columns: [WorkoutDraftEntity.t.authUserId],
      transaction: transaction,
    );
  }
}
