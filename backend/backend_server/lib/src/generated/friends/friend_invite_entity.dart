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

abstract class FriendInviteEntity
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  FriendInviteEntity._({
    this.id,
    required this.code,
    required this.creatorId,
    this.creator,
    required this.expiresAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory FriendInviteEntity({
    _i1.UuidValue? id,
    required String code,
    required _i1.UuidValue creatorId,
    _i2.AuthUser? creator,
    required DateTime expiresAt,
    DateTime? createdAt,
  }) = _FriendInviteEntityImpl;

  factory FriendInviteEntity.fromJson(Map<String, dynamic> jsonSerialization) {
    return FriendInviteEntity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      code: jsonSerialization['code'] as String,
      creatorId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['creatorId'],
      ),
      creator: jsonSerialization['creator'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['creator'],
            ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = FriendInviteEntityTable();

  static const db = FriendInviteEntityRepository._();

  @override
  _i1.UuidValue? id;

  String code;

  _i1.UuidValue creatorId;

  _i2.AuthUser? creator;

  DateTime expiresAt;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [FriendInviteEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FriendInviteEntity copyWith({
    _i1.UuidValue? id,
    String? code,
    _i1.UuidValue? creatorId,
    _i2.AuthUser? creator,
    DateTime? expiresAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FriendInviteEntity',
      if (id != null) 'id': id?.toJson(),
      'code': code,
      'creatorId': creatorId.toJson(),
      if (creator != null) 'creator': creator?.toJson(),
      'expiresAt': expiresAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static FriendInviteEntityInclude include({_i2.AuthUserInclude? creator}) {
    return FriendInviteEntityInclude._(creator: creator);
  }

  static FriendInviteEntityIncludeList includeList({
    _i1.WhereExpressionBuilder<FriendInviteEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FriendInviteEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FriendInviteEntityTable>? orderByList,
    FriendInviteEntityInclude? include,
  }) {
    return FriendInviteEntityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FriendInviteEntity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FriendInviteEntity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FriendInviteEntityImpl extends FriendInviteEntity {
  _FriendInviteEntityImpl({
    _i1.UuidValue? id,
    required String code,
    required _i1.UuidValue creatorId,
    _i2.AuthUser? creator,
    required DateTime expiresAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         code: code,
         creatorId: creatorId,
         creator: creator,
         expiresAt: expiresAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FriendInviteEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FriendInviteEntity copyWith({
    Object? id = _Undefined,
    String? code,
    _i1.UuidValue? creatorId,
    Object? creator = _Undefined,
    DateTime? expiresAt,
    DateTime? createdAt,
  }) {
    return FriendInviteEntity(
      id: id is _i1.UuidValue? ? id : this.id,
      code: code ?? this.code,
      creatorId: creatorId ?? this.creatorId,
      creator: creator is _i2.AuthUser? ? creator : this.creator?.copyWith(),
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FriendInviteEntityUpdateTable
    extends _i1.UpdateTable<FriendInviteEntityTable> {
  FriendInviteEntityUpdateTable(super.table);

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> creatorId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.creatorId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class FriendInviteEntityTable extends _i1.Table<_i1.UuidValue?> {
  FriendInviteEntityTable({super.tableRelation})
    : super(tableName: 'friend_invite') {
    updateTable = FriendInviteEntityUpdateTable(this);
    code = _i1.ColumnString(
      'code',
      this,
    );
    creatorId = _i1.ColumnUuid(
      'creatorId',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final FriendInviteEntityUpdateTable updateTable;

  late final _i1.ColumnString code;

  late final _i1.ColumnUuid creatorId;

  _i2.AuthUserTable? _creator;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnDateTime createdAt;

  _i2.AuthUserTable get creator {
    if (_creator != null) return _creator!;
    _creator = _i1.createRelationTable(
      relationFieldName: 'creator',
      field: FriendInviteEntity.t.creatorId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _creator!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    code,
    creatorId,
    expiresAt,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'creator') {
      return creator;
    }
    return null;
  }
}

class FriendInviteEntityInclude extends _i1.IncludeObject {
  FriendInviteEntityInclude._({_i2.AuthUserInclude? creator}) {
    _creator = creator;
  }

  _i2.AuthUserInclude? _creator;

  @override
  Map<String, _i1.Include?> get includes => {'creator': _creator};

  @override
  _i1.Table<_i1.UuidValue?> get table => FriendInviteEntity.t;
}

class FriendInviteEntityIncludeList extends _i1.IncludeList {
  FriendInviteEntityIncludeList._({
    _i1.WhereExpressionBuilder<FriendInviteEntityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FriendInviteEntity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => FriendInviteEntity.t;
}

class FriendInviteEntityRepository {
  const FriendInviteEntityRepository._();

  final attachRow = const FriendInviteEntityAttachRowRepository._();

  /// Returns a list of [FriendInviteEntity]s matching the given query parameters.
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
  Future<List<FriendInviteEntity>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FriendInviteEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FriendInviteEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FriendInviteEntityTable>? orderByList,
    _i1.Transaction? transaction,
    FriendInviteEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FriendInviteEntity>(
      where: where?.call(FriendInviteEntity.t),
      orderBy: orderBy?.call(FriendInviteEntity.t),
      orderByList: orderByList?.call(FriendInviteEntity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FriendInviteEntity] matching the given query parameters.
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
  Future<FriendInviteEntity?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FriendInviteEntityTable>? where,
    int? offset,
    _i1.OrderByBuilder<FriendInviteEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FriendInviteEntityTable>? orderByList,
    _i1.Transaction? transaction,
    FriendInviteEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FriendInviteEntity>(
      where: where?.call(FriendInviteEntity.t),
      orderBy: orderBy?.call(FriendInviteEntity.t),
      orderByList: orderByList?.call(FriendInviteEntity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FriendInviteEntity] by its [id] or null if no such row exists.
  Future<FriendInviteEntity?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    FriendInviteEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FriendInviteEntity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FriendInviteEntity]s in the list and returns the inserted rows.
  ///
  /// The returned [FriendInviteEntity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FriendInviteEntity>> insert(
    _i1.DatabaseSession session,
    List<FriendInviteEntity> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FriendInviteEntity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FriendInviteEntity] and returns the inserted row.
  ///
  /// The returned [FriendInviteEntity] will have its `id` field set.
  Future<FriendInviteEntity> insertRow(
    _i1.DatabaseSession session,
    FriendInviteEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FriendInviteEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FriendInviteEntity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FriendInviteEntity>> update(
    _i1.DatabaseSession session,
    List<FriendInviteEntity> rows, {
    _i1.ColumnSelections<FriendInviteEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FriendInviteEntity>(
      rows,
      columns: columns?.call(FriendInviteEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FriendInviteEntity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FriendInviteEntity> updateRow(
    _i1.DatabaseSession session,
    FriendInviteEntity row, {
    _i1.ColumnSelections<FriendInviteEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FriendInviteEntity>(
      row,
      columns: columns?.call(FriendInviteEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FriendInviteEntity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FriendInviteEntity?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<FriendInviteEntityUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FriendInviteEntity>(
      id,
      columnValues: columnValues(FriendInviteEntity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FriendInviteEntity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FriendInviteEntity>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FriendInviteEntityUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<FriendInviteEntityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FriendInviteEntityTable>? orderBy,
    _i1.OrderByListBuilder<FriendInviteEntityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FriendInviteEntity>(
      columnValues: columnValues(FriendInviteEntity.t.updateTable),
      where: where(FriendInviteEntity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FriendInviteEntity.t),
      orderByList: orderByList?.call(FriendInviteEntity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FriendInviteEntity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FriendInviteEntity>> delete(
    _i1.DatabaseSession session,
    List<FriendInviteEntity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FriendInviteEntity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FriendInviteEntity].
  Future<FriendInviteEntity> deleteRow(
    _i1.DatabaseSession session,
    FriendInviteEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FriendInviteEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FriendInviteEntity>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FriendInviteEntityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FriendInviteEntity>(
      where: where(FriendInviteEntity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FriendInviteEntityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FriendInviteEntity>(
      where: where?.call(FriendInviteEntity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FriendInviteEntity] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FriendInviteEntityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FriendInviteEntity>(
      where: where(FriendInviteEntity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FriendInviteEntityAttachRowRepository {
  const FriendInviteEntityAttachRowRepository._();

  /// Creates a relation between the given [FriendInviteEntity] and [AuthUser]
  /// by setting the [FriendInviteEntity]'s foreign key `creatorId` to refer to the [AuthUser].
  Future<void> creator(
    _i1.DatabaseSession session,
    FriendInviteEntity friendInviteEntity,
    _i2.AuthUser creator, {
    _i1.Transaction? transaction,
  }) async {
    if (friendInviteEntity.id == null) {
      throw ArgumentError.notNull('friendInviteEntity.id');
    }
    if (creator.id == null) {
      throw ArgumentError.notNull('creator.id');
    }

    var $friendInviteEntity = friendInviteEntity.copyWith(
      creatorId: creator.id,
    );
    await session.db.updateRow<FriendInviteEntity>(
      $friendInviteEntity,
      columns: [FriendInviteEntity.t.creatorId],
      transaction: transaction,
    );
  }
}
