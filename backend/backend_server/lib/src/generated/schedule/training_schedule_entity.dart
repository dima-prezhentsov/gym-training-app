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

/// The single editable training schedule owned by an authenticated user.
abstract class TrainingScheduleEntity
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  TrainingScheduleEntity._({
    this.id,
    required this.publicId,
    required this.name,
    required this.authUserId,
    this.authUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory TrainingScheduleEntity({
    _i1.UuidValue? id,
    required String publicId,
    required String name,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TrainingScheduleEntityImpl;

  factory TrainingScheduleEntity.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingScheduleEntity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      publicId: jsonSerialization['publicId'] as String,
      name: jsonSerialization['name'] as String,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = TrainingScheduleEntityTable();

  static const db = TrainingScheduleEntityRepository._();

  @override
  _i1.UuidValue? id;

  String publicId;

  String name;

  _i1.UuidValue authUserId;

  _i2.AuthUser? authUser;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [TrainingScheduleEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingScheduleEntity copyWith({
    _i1.UuidValue? id,
    String? publicId,
    String? name,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingScheduleEntity',
      if (id != null) 'id': id?.toJson(),
      'publicId': publicId,
      'name': name,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static TrainingScheduleEntityInclude include({
    _i2.AuthUserInclude? authUser,
  }) {
    return TrainingScheduleEntityInclude._(authUser: authUser);
  }

  static TrainingScheduleEntityIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingScheduleEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingScheduleEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingScheduleEntityTable>? orderByList,
    TrainingScheduleEntityInclude? include,
  }) {
    return TrainingScheduleEntityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingScheduleEntity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingScheduleEntity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingScheduleEntityImpl extends TrainingScheduleEntity {
  _TrainingScheduleEntityImpl({
    _i1.UuidValue? id,
    required String publicId,
    required String name,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         publicId: publicId,
         name: name,
         authUserId: authUserId,
         authUser: authUser,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [TrainingScheduleEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingScheduleEntity copyWith({
    Object? id = _Undefined,
    String? publicId,
    String? name,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TrainingScheduleEntity(
      id: id is _i1.UuidValue? ? id : this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class TrainingScheduleEntityUpdateTable
    extends _i1.UpdateTable<TrainingScheduleEntityTable> {
  TrainingScheduleEntityUpdateTable(super.table);

  _i1.ColumnValue<String, String> publicId(String value) => _i1.ColumnValue(
    table.publicId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class TrainingScheduleEntityTable extends _i1.Table<_i1.UuidValue?> {
  TrainingScheduleEntityTable({super.tableRelation})
    : super(tableName: 'training_schedule') {
    updateTable = TrainingScheduleEntityUpdateTable(this);
    publicId = _i1.ColumnString(
      'publicId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final TrainingScheduleEntityUpdateTable updateTable;

  late final _i1.ColumnString publicId;

  late final _i1.ColumnString name;

  late final _i1.ColumnUuid authUserId;

  _i2.AuthUserTable? _authUser;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _i1.createRelationTable(
      relationFieldName: 'authUser',
      field: TrainingScheduleEntity.t.authUserId,
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
    name,
    authUserId,
    createdAt,
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

class TrainingScheduleEntityInclude extends _i1.IncludeObject {
  TrainingScheduleEntityInclude._({_i2.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _i2.AuthUserInclude? _authUser;

  @override
  Map<String, _i1.Include?> get includes => {'authUser': _authUser};

  @override
  _i1.Table<_i1.UuidValue?> get table => TrainingScheduleEntity.t;
}

class TrainingScheduleEntityIncludeList extends _i1.IncludeList {
  TrainingScheduleEntityIncludeList._({
    _i1.WhereExpressionBuilder<TrainingScheduleEntityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingScheduleEntity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => TrainingScheduleEntity.t;
}

class TrainingScheduleEntityRepository {
  const TrainingScheduleEntityRepository._();

  final attachRow = const TrainingScheduleEntityAttachRowRepository._();

  /// Returns a list of [TrainingScheduleEntity]s matching the given query parameters.
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
  Future<List<TrainingScheduleEntity>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingScheduleEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingScheduleEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingScheduleEntityTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingScheduleEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingScheduleEntity>(
      where: where?.call(TrainingScheduleEntity.t),
      orderBy: orderBy?.call(TrainingScheduleEntity.t),
      orderByList: orderByList?.call(TrainingScheduleEntity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingScheduleEntity] matching the given query parameters.
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
  Future<TrainingScheduleEntity?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingScheduleEntityTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingScheduleEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingScheduleEntityTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingScheduleEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingScheduleEntity>(
      where: where?.call(TrainingScheduleEntity.t),
      orderBy: orderBy?.call(TrainingScheduleEntity.t),
      orderByList: orderByList?.call(TrainingScheduleEntity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingScheduleEntity] by its [id] or null if no such row exists.
  Future<TrainingScheduleEntity?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TrainingScheduleEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingScheduleEntity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingScheduleEntity]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingScheduleEntity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingScheduleEntity>> insert(
    _i1.DatabaseSession session,
    List<TrainingScheduleEntity> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingScheduleEntity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingScheduleEntity] and returns the inserted row.
  ///
  /// The returned [TrainingScheduleEntity] will have its `id` field set.
  Future<TrainingScheduleEntity> insertRow(
    _i1.DatabaseSession session,
    TrainingScheduleEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingScheduleEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingScheduleEntity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingScheduleEntity>> update(
    _i1.DatabaseSession session,
    List<TrainingScheduleEntity> rows, {
    _i1.ColumnSelections<TrainingScheduleEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingScheduleEntity>(
      rows,
      columns: columns?.call(TrainingScheduleEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingScheduleEntity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingScheduleEntity> updateRow(
    _i1.DatabaseSession session,
    TrainingScheduleEntity row, {
    _i1.ColumnSelections<TrainingScheduleEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingScheduleEntity>(
      row,
      columns: columns?.call(TrainingScheduleEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingScheduleEntity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingScheduleEntity?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TrainingScheduleEntityUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingScheduleEntity>(
      id,
      columnValues: columnValues(TrainingScheduleEntity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingScheduleEntity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingScheduleEntity>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrainingScheduleEntityUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TrainingScheduleEntityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingScheduleEntityTable>? orderBy,
    _i1.OrderByListBuilder<TrainingScheduleEntityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingScheduleEntity>(
      columnValues: columnValues(TrainingScheduleEntity.t.updateTable),
      where: where(TrainingScheduleEntity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingScheduleEntity.t),
      orderByList: orderByList?.call(TrainingScheduleEntity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingScheduleEntity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingScheduleEntity>> delete(
    _i1.DatabaseSession session,
    List<TrainingScheduleEntity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingScheduleEntity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingScheduleEntity].
  Future<TrainingScheduleEntity> deleteRow(
    _i1.DatabaseSession session,
    TrainingScheduleEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingScheduleEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingScheduleEntity>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingScheduleEntityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingScheduleEntity>(
      where: where(TrainingScheduleEntity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingScheduleEntityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingScheduleEntity>(
      where: where?.call(TrainingScheduleEntity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingScheduleEntity] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingScheduleEntityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingScheduleEntity>(
      where: where(TrainingScheduleEntity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingScheduleEntityAttachRowRepository {
  const TrainingScheduleEntityAttachRowRepository._();

  /// Creates a relation between the given [TrainingScheduleEntity] and [AuthUser]
  /// by setting the [TrainingScheduleEntity]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _i1.DatabaseSession session,
    TrainingScheduleEntity trainingScheduleEntity,
    _i2.AuthUser authUser, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingScheduleEntity.id == null) {
      throw ArgumentError.notNull('trainingScheduleEntity.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $trainingScheduleEntity = trainingScheduleEntity.copyWith(
      authUserId: authUser.id,
    );
    await session.db.updateRow<TrainingScheduleEntity>(
      $trainingScheduleEntity,
      columns: [TrainingScheduleEntity.t.authUserId],
      transaction: transaction,
    );
  }
}
