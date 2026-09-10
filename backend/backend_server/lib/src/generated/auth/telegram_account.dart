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

/// A verified Telegram identity linked to a Serverpod auth user.
abstract class TelegramAccount
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  TelegramAccount._({
    this.id,
    required this.telegramUserId,
    required this.firstName,
    this.lastName,
    this.username,
    this.languageCode,
    required this.authUserId,
    this.authUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory TelegramAccount({
    _i1.UuidValue? id,
    required int telegramUserId,
    required String firstName,
    String? lastName,
    String? username,
    String? languageCode,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TelegramAccountImpl;

  factory TelegramAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return TelegramAccount(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      telegramUserId: jsonSerialization['telegramUserId'] as int,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String?,
      username: jsonSerialization['username'] as String?,
      languageCode: jsonSerialization['languageCode'] as String?,
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

  static final t = TelegramAccountTable();

  static const db = TelegramAccountRepository._();

  @override
  _i1.UuidValue? id;

  int telegramUserId;

  String firstName;

  String? lastName;

  String? username;

  String? languageCode;

  _i1.UuidValue authUserId;

  _i2.AuthUser? authUser;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [TelegramAccount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TelegramAccount copyWith({
    _i1.UuidValue? id,
    int? telegramUserId,
    String? firstName,
    String? lastName,
    String? username,
    String? languageCode,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TelegramAccount',
      if (id != null) 'id': id?.toJson(),
      'telegramUserId': telegramUserId,
      'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (username != null) 'username': username,
      if (languageCode != null) 'languageCode': languageCode,
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

  static TelegramAccountInclude include({_i2.AuthUserInclude? authUser}) {
    return TelegramAccountInclude._(authUser: authUser);
  }

  static TelegramAccountIncludeList includeList({
    _i1.WhereExpressionBuilder<TelegramAccountTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TelegramAccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TelegramAccountTable>? orderByList,
    TelegramAccountInclude? include,
  }) {
    return TelegramAccountIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TelegramAccount.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TelegramAccount.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TelegramAccountImpl extends TelegramAccount {
  _TelegramAccountImpl({
    _i1.UuidValue? id,
    required int telegramUserId,
    required String firstName,
    String? lastName,
    String? username,
    String? languageCode,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         telegramUserId: telegramUserId,
         firstName: firstName,
         lastName: lastName,
         username: username,
         languageCode: languageCode,
         authUserId: authUserId,
         authUser: authUser,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [TelegramAccount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TelegramAccount copyWith({
    Object? id = _Undefined,
    int? telegramUserId,
    String? firstName,
    Object? lastName = _Undefined,
    Object? username = _Undefined,
    Object? languageCode = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TelegramAccount(
      id: id is _i1.UuidValue? ? id : this.id,
      telegramUserId: telegramUserId ?? this.telegramUserId,
      firstName: firstName ?? this.firstName,
      lastName: lastName is String? ? lastName : this.lastName,
      username: username is String? ? username : this.username,
      languageCode: languageCode is String? ? languageCode : this.languageCode,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class TelegramAccountUpdateTable extends _i1.UpdateTable<TelegramAccountTable> {
  TelegramAccountUpdateTable(super.table);

  _i1.ColumnValue<int, int> telegramUserId(int value) => _i1.ColumnValue(
    table.telegramUserId,
    value,
  );

  _i1.ColumnValue<String, String> firstName(String value) => _i1.ColumnValue(
    table.firstName,
    value,
  );

  _i1.ColumnValue<String, String> lastName(String? value) => _i1.ColumnValue(
    table.lastName,
    value,
  );

  _i1.ColumnValue<String, String> username(String? value) => _i1.ColumnValue(
    table.username,
    value,
  );

  _i1.ColumnValue<String, String> languageCode(String? value) =>
      _i1.ColumnValue(
        table.languageCode,
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

class TelegramAccountTable extends _i1.Table<_i1.UuidValue?> {
  TelegramAccountTable({super.tableRelation})
    : super(tableName: 'telegram_account') {
    updateTable = TelegramAccountUpdateTable(this);
    telegramUserId = _i1.ColumnInt(
      'telegramUserId',
      this,
    );
    firstName = _i1.ColumnString(
      'firstName',
      this,
    );
    lastName = _i1.ColumnString(
      'lastName',
      this,
    );
    username = _i1.ColumnString(
      'username',
      this,
    );
    languageCode = _i1.ColumnString(
      'languageCode',
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

  late final TelegramAccountUpdateTable updateTable;

  late final _i1.ColumnInt telegramUserId;

  late final _i1.ColumnString firstName;

  late final _i1.ColumnString lastName;

  late final _i1.ColumnString username;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnUuid authUserId;

  _i2.AuthUserTable? _authUser;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _i1.createRelationTable(
      relationFieldName: 'authUser',
      field: TelegramAccount.t.authUserId,
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
    telegramUserId,
    firstName,
    lastName,
    username,
    languageCode,
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

class TelegramAccountInclude extends _i1.IncludeObject {
  TelegramAccountInclude._({_i2.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _i2.AuthUserInclude? _authUser;

  @override
  Map<String, _i1.Include?> get includes => {'authUser': _authUser};

  @override
  _i1.Table<_i1.UuidValue?> get table => TelegramAccount.t;
}

class TelegramAccountIncludeList extends _i1.IncludeList {
  TelegramAccountIncludeList._({
    _i1.WhereExpressionBuilder<TelegramAccountTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TelegramAccount.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => TelegramAccount.t;
}

class TelegramAccountRepository {
  const TelegramAccountRepository._();

  final attachRow = const TelegramAccountAttachRowRepository._();

  /// Returns a list of [TelegramAccount]s matching the given query parameters.
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
  Future<List<TelegramAccount>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TelegramAccountTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TelegramAccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TelegramAccountTable>? orderByList,
    _i1.Transaction? transaction,
    TelegramAccountInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TelegramAccount>(
      where: where?.call(TelegramAccount.t),
      orderBy: orderBy?.call(TelegramAccount.t),
      orderByList: orderByList?.call(TelegramAccount.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TelegramAccount] matching the given query parameters.
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
  Future<TelegramAccount?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TelegramAccountTable>? where,
    int? offset,
    _i1.OrderByBuilder<TelegramAccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TelegramAccountTable>? orderByList,
    _i1.Transaction? transaction,
    TelegramAccountInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TelegramAccount>(
      where: where?.call(TelegramAccount.t),
      orderBy: orderBy?.call(TelegramAccount.t),
      orderByList: orderByList?.call(TelegramAccount.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TelegramAccount] by its [id] or null if no such row exists.
  Future<TelegramAccount?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TelegramAccountInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TelegramAccount>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TelegramAccount]s in the list and returns the inserted rows.
  ///
  /// The returned [TelegramAccount]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TelegramAccount>> insert(
    _i1.DatabaseSession session,
    List<TelegramAccount> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TelegramAccount>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TelegramAccount] and returns the inserted row.
  ///
  /// The returned [TelegramAccount] will have its `id` field set.
  Future<TelegramAccount> insertRow(
    _i1.DatabaseSession session,
    TelegramAccount row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TelegramAccount>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TelegramAccount]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TelegramAccount>> update(
    _i1.DatabaseSession session,
    List<TelegramAccount> rows, {
    _i1.ColumnSelections<TelegramAccountTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TelegramAccount>(
      rows,
      columns: columns?.call(TelegramAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TelegramAccount]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TelegramAccount> updateRow(
    _i1.DatabaseSession session,
    TelegramAccount row, {
    _i1.ColumnSelections<TelegramAccountTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TelegramAccount>(
      row,
      columns: columns?.call(TelegramAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TelegramAccount] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TelegramAccount?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TelegramAccountUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TelegramAccount>(
      id,
      columnValues: columnValues(TelegramAccount.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TelegramAccount]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TelegramAccount>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TelegramAccountUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TelegramAccountTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TelegramAccountTable>? orderBy,
    _i1.OrderByListBuilder<TelegramAccountTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TelegramAccount>(
      columnValues: columnValues(TelegramAccount.t.updateTable),
      where: where(TelegramAccount.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TelegramAccount.t),
      orderByList: orderByList?.call(TelegramAccount.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TelegramAccount]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TelegramAccount>> delete(
    _i1.DatabaseSession session,
    List<TelegramAccount> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TelegramAccount>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TelegramAccount].
  Future<TelegramAccount> deleteRow(
    _i1.DatabaseSession session,
    TelegramAccount row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TelegramAccount>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TelegramAccount>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TelegramAccountTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TelegramAccount>(
      where: where(TelegramAccount.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TelegramAccountTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TelegramAccount>(
      where: where?.call(TelegramAccount.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TelegramAccount] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TelegramAccountTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TelegramAccount>(
      where: where(TelegramAccount.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TelegramAccountAttachRowRepository {
  const TelegramAccountAttachRowRepository._();

  /// Creates a relation between the given [TelegramAccount] and [AuthUser]
  /// by setting the [TelegramAccount]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _i1.DatabaseSession session,
    TelegramAccount telegramAccount,
    _i2.AuthUser authUser, {
    _i1.Transaction? transaction,
  }) async {
    if (telegramAccount.id == null) {
      throw ArgumentError.notNull('telegramAccount.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $telegramAccount = telegramAccount.copyWith(authUserId: authUser.id);
    await session.db.updateRow<TelegramAccount>(
      $telegramAccount,
      columns: [TelegramAccount.t.authUserId],
      transaction: transaction,
    );
  }
}
