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

/// One pair of users. Shares are directional and private by default.
abstract class FriendshipEntity
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  FriendshipEntity._({
    this.id,
    required this.userAId,
    this.userA,
    required this.userBId,
    this.userB,
    required this.requestedById,
    required this.status,
    required this.aSharesStats,
    required this.aSharesHistory,
    required this.bSharesStats,
    required this.bSharesHistory,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory FriendshipEntity({
    _i1.UuidValue? id,
    required _i1.UuidValue userAId,
    _i2.AuthUser? userA,
    required _i1.UuidValue userBId,
    _i2.AuthUser? userB,
    required _i1.UuidValue requestedById,
    required String status,
    required bool aSharesStats,
    required bool aSharesHistory,
    required bool bSharesStats,
    required bool bSharesHistory,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FriendshipEntityImpl;

  factory FriendshipEntity.fromJson(Map<String, dynamic> jsonSerialization) {
    return FriendshipEntity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userAId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['userAId'],
      ),
      userA: jsonSerialization['userA'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['userA'],
            ),
      userBId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['userBId'],
      ),
      userB: jsonSerialization['userB'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['userB'],
            ),
      requestedById: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['requestedById'],
      ),
      status: jsonSerialization['status'] as String,
      aSharesStats: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['aSharesStats'],
      ),
      aSharesHistory: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['aSharesHistory'],
      ),
      bSharesStats: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['bSharesStats'],
      ),
      bSharesHistory: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['bSharesHistory'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = FriendshipEntityTable();

  static const db = FriendshipEntityRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue userAId;

  _i2.AuthUser? userA;

  _i1.UuidValue userBId;

  _i2.AuthUser? userB;

  _i1.UuidValue requestedById;

  String status;

  bool aSharesStats;

  bool aSharesHistory;

  bool bSharesStats;

  bool bSharesHistory;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [FriendshipEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FriendshipEntity copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userAId,
    _i2.AuthUser? userA,
    _i1.UuidValue? userBId,
    _i2.AuthUser? userB,
    _i1.UuidValue? requestedById,
    String? status,
    bool? aSharesStats,
    bool? aSharesHistory,
    bool? bSharesStats,
    bool? bSharesHistory,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FriendshipEntity',
      if (id != null) 'id': id?.toJson(),
      'userAId': userAId.toJson(),
      if (userA != null) 'userA': userA?.toJson(),
      'userBId': userBId.toJson(),
      if (userB != null) 'userB': userB?.toJson(),
      'requestedById': requestedById.toJson(),
      'status': status,
      'aSharesStats': aSharesStats,
      'aSharesHistory': aSharesHistory,
      'bSharesStats': bSharesStats,
      'bSharesHistory': bSharesHistory,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static FriendshipEntityInclude include({
    _i2.AuthUserInclude? userA,
    _i2.AuthUserInclude? userB,
  }) {
    return FriendshipEntityInclude._(
      userA: userA,
      userB: userB,
    );
  }

  static FriendshipEntityIncludeList includeList({
    _i1.WhereExpressionBuilder<FriendshipEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FriendshipEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FriendshipEntityTable>? orderByList,
    FriendshipEntityInclude? include,
  }) {
    return FriendshipEntityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FriendshipEntity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FriendshipEntity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FriendshipEntityImpl extends FriendshipEntity {
  _FriendshipEntityImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue userAId,
    _i2.AuthUser? userA,
    required _i1.UuidValue userBId,
    _i2.AuthUser? userB,
    required _i1.UuidValue requestedById,
    required String status,
    required bool aSharesStats,
    required bool aSharesHistory,
    required bool bSharesStats,
    required bool bSharesHistory,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userAId: userAId,
         userA: userA,
         userBId: userBId,
         userB: userB,
         requestedById: requestedById,
         status: status,
         aSharesStats: aSharesStats,
         aSharesHistory: aSharesHistory,
         bSharesStats: bSharesStats,
         bSharesHistory: bSharesHistory,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FriendshipEntity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FriendshipEntity copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userAId,
    Object? userA = _Undefined,
    _i1.UuidValue? userBId,
    Object? userB = _Undefined,
    _i1.UuidValue? requestedById,
    String? status,
    bool? aSharesStats,
    bool? aSharesHistory,
    bool? bSharesStats,
    bool? bSharesHistory,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FriendshipEntity(
      id: id is _i1.UuidValue? ? id : this.id,
      userAId: userAId ?? this.userAId,
      userA: userA is _i2.AuthUser? ? userA : this.userA?.copyWith(),
      userBId: userBId ?? this.userBId,
      userB: userB is _i2.AuthUser? ? userB : this.userB?.copyWith(),
      requestedById: requestedById ?? this.requestedById,
      status: status ?? this.status,
      aSharesStats: aSharesStats ?? this.aSharesStats,
      aSharesHistory: aSharesHistory ?? this.aSharesHistory,
      bSharesStats: bSharesStats ?? this.bSharesStats,
      bSharesHistory: bSharesHistory ?? this.bSharesHistory,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FriendshipEntityUpdateTable
    extends _i1.UpdateTable<FriendshipEntityTable> {
  FriendshipEntityUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userAId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userAId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userBId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userBId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> requestedById(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.requestedById,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<bool, bool> aSharesStats(bool value) => _i1.ColumnValue(
    table.aSharesStats,
    value,
  );

  _i1.ColumnValue<bool, bool> aSharesHistory(bool value) => _i1.ColumnValue(
    table.aSharesHistory,
    value,
  );

  _i1.ColumnValue<bool, bool> bSharesStats(bool value) => _i1.ColumnValue(
    table.bSharesStats,
    value,
  );

  _i1.ColumnValue<bool, bool> bSharesHistory(bool value) => _i1.ColumnValue(
    table.bSharesHistory,
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

class FriendshipEntityTable extends _i1.Table<_i1.UuidValue?> {
  FriendshipEntityTable({super.tableRelation})
    : super(tableName: 'friendship') {
    updateTable = FriendshipEntityUpdateTable(this);
    userAId = _i1.ColumnUuid(
      'userAId',
      this,
    );
    userBId = _i1.ColumnUuid(
      'userBId',
      this,
    );
    requestedById = _i1.ColumnUuid(
      'requestedById',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    aSharesStats = _i1.ColumnBool(
      'aSharesStats',
      this,
    );
    aSharesHistory = _i1.ColumnBool(
      'aSharesHistory',
      this,
    );
    bSharesStats = _i1.ColumnBool(
      'bSharesStats',
      this,
    );
    bSharesHistory = _i1.ColumnBool(
      'bSharesHistory',
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

  late final FriendshipEntityUpdateTable updateTable;

  late final _i1.ColumnUuid userAId;

  _i2.AuthUserTable? _userA;

  late final _i1.ColumnUuid userBId;

  _i2.AuthUserTable? _userB;

  late final _i1.ColumnUuid requestedById;

  late final _i1.ColumnString status;

  late final _i1.ColumnBool aSharesStats;

  late final _i1.ColumnBool aSharesHistory;

  late final _i1.ColumnBool bSharesStats;

  late final _i1.ColumnBool bSharesHistory;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.AuthUserTable get userA {
    if (_userA != null) return _userA!;
    _userA = _i1.createRelationTable(
      relationFieldName: 'userA',
      field: FriendshipEntity.t.userAId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _userA!;
  }

  _i2.AuthUserTable get userB {
    if (_userB != null) return _userB!;
    _userB = _i1.createRelationTable(
      relationFieldName: 'userB',
      field: FriendshipEntity.t.userBId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _userB!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userAId,
    userBId,
    requestedById,
    status,
    aSharesStats,
    aSharesHistory,
    bSharesStats,
    bSharesHistory,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userA') {
      return userA;
    }
    if (relationField == 'userB') {
      return userB;
    }
    return null;
  }
}

class FriendshipEntityInclude extends _i1.IncludeObject {
  FriendshipEntityInclude._({
    _i2.AuthUserInclude? userA,
    _i2.AuthUserInclude? userB,
  }) {
    _userA = userA;
    _userB = userB;
  }

  _i2.AuthUserInclude? _userA;

  _i2.AuthUserInclude? _userB;

  @override
  Map<String, _i1.Include?> get includes => {
    'userA': _userA,
    'userB': _userB,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => FriendshipEntity.t;
}

class FriendshipEntityIncludeList extends _i1.IncludeList {
  FriendshipEntityIncludeList._({
    _i1.WhereExpressionBuilder<FriendshipEntityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FriendshipEntity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => FriendshipEntity.t;
}

class FriendshipEntityRepository {
  const FriendshipEntityRepository._();

  final attachRow = const FriendshipEntityAttachRowRepository._();

  /// Returns a list of [FriendshipEntity]s matching the given query parameters.
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
  Future<List<FriendshipEntity>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FriendshipEntityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FriendshipEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FriendshipEntityTable>? orderByList,
    _i1.Transaction? transaction,
    FriendshipEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FriendshipEntity>(
      where: where?.call(FriendshipEntity.t),
      orderBy: orderBy?.call(FriendshipEntity.t),
      orderByList: orderByList?.call(FriendshipEntity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FriendshipEntity] matching the given query parameters.
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
  Future<FriendshipEntity?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FriendshipEntityTable>? where,
    int? offset,
    _i1.OrderByBuilder<FriendshipEntityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FriendshipEntityTable>? orderByList,
    _i1.Transaction? transaction,
    FriendshipEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FriendshipEntity>(
      where: where?.call(FriendshipEntity.t),
      orderBy: orderBy?.call(FriendshipEntity.t),
      orderByList: orderByList?.call(FriendshipEntity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FriendshipEntity] by its [id] or null if no such row exists.
  Future<FriendshipEntity?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    FriendshipEntityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FriendshipEntity>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FriendshipEntity]s in the list and returns the inserted rows.
  ///
  /// The returned [FriendshipEntity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FriendshipEntity>> insert(
    _i1.DatabaseSession session,
    List<FriendshipEntity> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FriendshipEntity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FriendshipEntity] and returns the inserted row.
  ///
  /// The returned [FriendshipEntity] will have its `id` field set.
  Future<FriendshipEntity> insertRow(
    _i1.DatabaseSession session,
    FriendshipEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FriendshipEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FriendshipEntity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FriendshipEntity>> update(
    _i1.DatabaseSession session,
    List<FriendshipEntity> rows, {
    _i1.ColumnSelections<FriendshipEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FriendshipEntity>(
      rows,
      columns: columns?.call(FriendshipEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FriendshipEntity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FriendshipEntity> updateRow(
    _i1.DatabaseSession session,
    FriendshipEntity row, {
    _i1.ColumnSelections<FriendshipEntityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FriendshipEntity>(
      row,
      columns: columns?.call(FriendshipEntity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FriendshipEntity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FriendshipEntity?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<FriendshipEntityUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FriendshipEntity>(
      id,
      columnValues: columnValues(FriendshipEntity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FriendshipEntity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FriendshipEntity>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FriendshipEntityUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<FriendshipEntityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FriendshipEntityTable>? orderBy,
    _i1.OrderByListBuilder<FriendshipEntityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FriendshipEntity>(
      columnValues: columnValues(FriendshipEntity.t.updateTable),
      where: where(FriendshipEntity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FriendshipEntity.t),
      orderByList: orderByList?.call(FriendshipEntity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FriendshipEntity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FriendshipEntity>> delete(
    _i1.DatabaseSession session,
    List<FriendshipEntity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FriendshipEntity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FriendshipEntity].
  Future<FriendshipEntity> deleteRow(
    _i1.DatabaseSession session,
    FriendshipEntity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FriendshipEntity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FriendshipEntity>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FriendshipEntityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FriendshipEntity>(
      where: where(FriendshipEntity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FriendshipEntityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FriendshipEntity>(
      where: where?.call(FriendshipEntity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FriendshipEntity] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FriendshipEntityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FriendshipEntity>(
      where: where(FriendshipEntity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FriendshipEntityAttachRowRepository {
  const FriendshipEntityAttachRowRepository._();

  /// Creates a relation between the given [FriendshipEntity] and [AuthUser]
  /// by setting the [FriendshipEntity]'s foreign key `userAId` to refer to the [AuthUser].
  Future<void> userA(
    _i1.DatabaseSession session,
    FriendshipEntity friendshipEntity,
    _i2.AuthUser userA, {
    _i1.Transaction? transaction,
  }) async {
    if (friendshipEntity.id == null) {
      throw ArgumentError.notNull('friendshipEntity.id');
    }
    if (userA.id == null) {
      throw ArgumentError.notNull('userA.id');
    }

    var $friendshipEntity = friendshipEntity.copyWith(userAId: userA.id);
    await session.db.updateRow<FriendshipEntity>(
      $friendshipEntity,
      columns: [FriendshipEntity.t.userAId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FriendshipEntity] and [AuthUser]
  /// by setting the [FriendshipEntity]'s foreign key `userBId` to refer to the [AuthUser].
  Future<void> userB(
    _i1.DatabaseSession session,
    FriendshipEntity friendshipEntity,
    _i2.AuthUser userB, {
    _i1.Transaction? transaction,
  }) async {
    if (friendshipEntity.id == null) {
      throw ArgumentError.notNull('friendshipEntity.id');
    }
    if (userB.id == null) {
      throw ArgumentError.notNull('userB.id');
    }

    var $friendshipEntity = friendshipEntity.copyWith(userBId: userB.id);
    await session.db.updateRow<FriendshipEntity>(
      $friendshipEntity,
      columns: [FriendshipEntity.t.userBId],
      transaction: transaction,
    );
  }
}
