/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:interview_arena_server/src/generated/protocol.dart'
    as _iq9nucou;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import '../resume/parsed_resume.dart' as _iyylb1hm;
import '../resume/resume_parse_status.dart' as _i4n08ko5;

/// An uploaded resume PDF and its parse result.
abstract class Resume implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Resume._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.fileName,
    required this.storagePath,
    required this.sizeBytes,
    _i4n08ko5.ResumeParseStatus? status,
    this.parsedData,
    this.parseError,
    this.parseModel,
    DateTime? createdAt,
    this.parsedAt,
  }) : status = status ?? _i4n08ko5.ResumeParseStatus.awaitingUpload,
       createdAt = createdAt ?? DateTime.now();

  factory Resume({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String fileName,
    required String storagePath,
    required int sizeBytes,
    _i4n08ko5.ResumeParseStatus? status,
    _iyylb1hm.ParsedResume? parsedData,
    String? parseError,
    String? parseModel,
    DateTime? createdAt,
    DateTime? parsedAt,
  }) = _ResumeImpl;

  factory Resume.fromJson(Map<String, dynamic> jsonSerialization) {
    return Resume(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      fileName: jsonSerialization['fileName'] as String,
      storagePath: jsonSerialization['storagePath'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      status: jsonSerialization['status'] == null
          ? null
          : _i4n08ko5.ResumeParseStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      parsedData: jsonSerialization['parsedData'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_iyylb1hm.ParsedResume>(
              jsonSerialization['parsedData'],
            ),
      parseError: jsonSerialization['parseError'] as String?,
      parseModel: jsonSerialization['parseModel'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      parsedAt: jsonSerialization['parsedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['parsedAt']),
    );
  }

  static final t = ResumeTable();

  static const db = ResumeRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  String fileName;

  /// Path inside the 'private' cloud storage. Derived server-side.
  String storagePath;

  int sizeBytes;

  _i4n08ko5.ResumeParseStatus status;

  _iyylb1hm.ParsedResume? parsedData;

  String? parseError;

  /// Model id that produced parsedData (e.g. claude-opus-5-5).
  String? parseModel;

  DateTime createdAt;

  DateTime? parsedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Resume]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Resume copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    String? fileName,
    String? storagePath,
    int? sizeBytes,
    _i4n08ko5.ResumeParseStatus? status,
    _iyylb1hm.ParsedResume? parsedData,
    String? parseError,
    String? parseModel,
    DateTime? createdAt,
    DateTime? parsedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Resume',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fileName': fileName,
      'storagePath': storagePath,
      'sizeBytes': sizeBytes,
      'status': status.toJson(),
      if (parsedData != null) 'parsedData': parsedData?.toJson(),
      if (parseError != null) 'parseError': parseError,
      if (parseModel != null) 'parseModel': parseModel,
      'createdAt': createdAt.toJson(),
      if (parsedAt != null) 'parsedAt': parsedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Resume',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fileName': fileName,
      'storagePath': storagePath,
      'sizeBytes': sizeBytes,
      'status': status.toJson(),
      if (parsedData != null) 'parsedData': parsedData?.toJsonForProtocol(),
      if (parseError != null) 'parseError': parseError,
      'createdAt': createdAt.toJson(),
      if (parsedAt != null) 'parsedAt': parsedAt?.toJson(),
    };
  }

  static ResumeInclude include({_iacs.AuthUserInclude? authUser}) {
    return ResumeInclude._(authUser: authUser);
  }

  static ResumeIncludeList includeList({
    _is.WhereExpressionBuilder<ResumeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ResumeTable>? orderBy,
    _is.OrderByListBuilder<ResumeTable>? orderByList,
    ResumeInclude? include,
  }) {
    return ResumeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Resume.t),
      orderByList: orderByList?.call(Resume.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ResumeImpl extends Resume {
  _ResumeImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String fileName,
    required String storagePath,
    required int sizeBytes,
    _i4n08ko5.ResumeParseStatus? status,
    _iyylb1hm.ParsedResume? parsedData,
    String? parseError,
    String? parseModel,
    DateTime? createdAt,
    DateTime? parsedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         fileName: fileName,
         storagePath: storagePath,
         sizeBytes: sizeBytes,
         status: status,
         parsedData: parsedData,
         parseError: parseError,
         parseModel: parseModel,
         createdAt: createdAt,
         parsedAt: parsedAt,
       );

  /// Returns a shallow copy of this [Resume]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Resume copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? fileName,
    String? storagePath,
    int? sizeBytes,
    _i4n08ko5.ResumeParseStatus? status,
    Object? parsedData = _Undefined,
    Object? parseError = _Undefined,
    Object? parseModel = _Undefined,
    DateTime? createdAt,
    Object? parsedAt = _Undefined,
  }) {
    return Resume(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      fileName: fileName ?? this.fileName,
      storagePath: storagePath ?? this.storagePath,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      status: status ?? this.status,
      parsedData: parsedData is _iyylb1hm.ParsedResume?
          ? parsedData
          : this.parsedData?.copyWith(),
      parseError: parseError is String? ? parseError : this.parseError,
      parseModel: parseModel is String? ? parseModel : this.parseModel,
      createdAt: createdAt ?? this.createdAt,
      parsedAt: parsedAt is DateTime? ? parsedAt : this.parsedAt,
    );
  }
}

class ResumeUpdateTable extends _is.UpdateTable<ResumeTable> {
  ResumeUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> fileName(String value) => _is.ColumnValue(
    table.fileName,
    value,
  );

  _is.ColumnValue<String, String> storagePath(String value) => _is.ColumnValue(
    table.storagePath,
    value,
  );

  _is.ColumnValue<int, int> sizeBytes(int value) => _is.ColumnValue(
    table.sizeBytes,
    value,
  );

  _is.ColumnValue<_i4n08ko5.ResumeParseStatus, _i4n08ko5.ResumeParseStatus>
  status(_i4n08ko5.ResumeParseStatus value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_iyylb1hm.ParsedResume, _iyylb1hm.ParsedResume> parsedData(
    _iyylb1hm.ParsedResume? value,
  ) => _is.ColumnValue(
    table.parsedData,
    value,
  );

  _is.ColumnValue<String, String> parseError(String? value) => _is.ColumnValue(
    table.parseError,
    value,
  );

  _is.ColumnValue<String, String> parseModel(String? value) => _is.ColumnValue(
    table.parseModel,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> parsedAt(DateTime? value) =>
      _is.ColumnValue(
        table.parsedAt,
        value,
      );
}

class ResumeTable extends _is.Table<int?> {
  ResumeTable({super.tableRelation}) : super(tableName: 'resume') {
    updateTable = ResumeUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    fileName = _is.ColumnString(
      'fileName',
      this,
    );
    storagePath = _is.ColumnString(
      'storagePath',
      this,
    );
    sizeBytes = _is.ColumnInt(
      'sizeBytes',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    parsedData = _is.ColumnStructured<_iyylb1hm.ParsedResume>(
      'parsedData',
      this,
    );
    parseError = _is.ColumnString(
      'parseError',
      this,
    );
    parseModel = _is.ColumnString(
      'parseModel',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    parsedAt = _is.ColumnDateTime(
      'parsedAt',
      this,
    );
  }

  late final ResumeUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnString fileName;

  /// Path inside the 'private' cloud storage. Derived server-side.
  late final _is.ColumnString storagePath;

  late final _is.ColumnInt sizeBytes;

  late final _is.ColumnEnum<_i4n08ko5.ResumeParseStatus> status;

  late final _is.ColumnStructured<_iyylb1hm.ParsedResume> parsedData;

  late final _is.ColumnString parseError;

  /// Model id that produced parsedData (e.g. claude-opus-5-5).
  late final _is.ColumnString parseModel;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime parsedAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: Resume.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    fileName,
    storagePath,
    sizeBytes,
    status,
    parsedData,
    parseError,
    parseModel,
    createdAt,
    parsedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class ResumeInclude extends _is.IncludeObject {
  ResumeInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => Resume.t;
}

class ResumeIncludeList extends _is.IncludeList {
  ResumeIncludeList._({
    _is.WhereExpressionBuilder<ResumeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Resume.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Resume.t;
}

class ResumeRepository {
  const ResumeRepository._();

  final attachRow = const ResumeAttachRowRepository._();

  /// Returns a list of [Resume]s matching the given query parameters.
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
  Future<List<Resume>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ResumeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ResumeTable>? orderBy,
    _is.OrderByListBuilder<ResumeTable>? orderByList,
    _is.Transaction? transaction,
    ResumeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Resume>(
      where: where?.call(Resume.t),
      orderBy: orderBy?.call(Resume.t),
      orderByList: orderByList?.call(Resume.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Resume] matching the given query parameters.
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
  Future<Resume?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ResumeTable>? where,
    int? offset,
    _is.OrderByBuilder<ResumeTable>? orderBy,
    _is.OrderByListBuilder<ResumeTable>? orderByList,
    _is.Transaction? transaction,
    ResumeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Resume>(
      where: where?.call(Resume.t),
      orderBy: orderBy?.call(Resume.t),
      orderByList: orderByList?.call(Resume.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Resume] by its [id] or null if no such row exists.
  Future<Resume?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ResumeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Resume>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Resume]s in the list and returns the inserted rows.
  ///
  /// The returned [Resume]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Resume>> insert(
    _is.DatabaseSession session,
    List<Resume> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Resume>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Resume] and returns the inserted row.
  ///
  /// The returned [Resume] will have its `id` field set.
  Future<Resume> insertRow(
    _is.DatabaseSession session,
    Resume row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Resume>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Resume]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Resume]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Resume>> upsert(
    _is.DatabaseSession session,
    List<Resume> rows, {
    required _is.ColumnSelections<ResumeTable> conflictColumns,
    _is.ColumnSelections<ResumeTable>? updateColumns,
    _is.WhereExpressionBuilder<ResumeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Resume>(
      rows,
      conflictColumns: conflictColumns(Resume.t),
      updateColumns: updateColumns?.call(Resume.t),
      updateWhere: updateWhere?.call(Resume.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Resume] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Resume] will have its `id` field set.
  Future<Resume?> upsertRow(
    _is.DatabaseSession session,
    Resume row, {
    required _is.ColumnSelections<ResumeTable> conflictColumns,
    _is.ColumnSelections<ResumeTable>? updateColumns,
    _is.WhereExpressionBuilder<ResumeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Resume>(
      row,
      conflictColumns: conflictColumns(Resume.t),
      updateColumns: updateColumns?.call(Resume.t),
      updateWhere: updateWhere?.call(Resume.t),
      transaction: transaction,
    );
  }

  /// Updates all [Resume]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Resume>> update(
    _is.DatabaseSession session,
    List<Resume> rows, {
    _is.ColumnSelections<ResumeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Resume>(
      rows,
      columns: columns?.call(Resume.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Resume]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Resume> updateRow(
    _is.DatabaseSession session,
    Resume row, {
    _is.ColumnSelections<ResumeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Resume>(
      row,
      columns: columns?.call(Resume.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Resume] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Resume?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ResumeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Resume>(
      id,
      columnValues: columnValues(Resume.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Resume]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Resume>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ResumeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ResumeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ResumeTable>? orderBy,
    _is.OrderByListBuilder<ResumeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Resume>(
      columnValues: columnValues(Resume.t.updateTable),
      where: where(Resume.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Resume.t),
      orderByList: orderByList?.call(Resume.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Resume]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Resume>> delete(
    _is.DatabaseSession session,
    List<Resume> rows, {
    _is.OrderByBuilder<ResumeTable>? orderBy,
    _is.OrderByListBuilder<ResumeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Resume>(
      rows,
      orderBy: orderBy?.call(Resume.t),
      orderByList: orderByList?.call(Resume.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Resume].
  Future<Resume> deleteRow(
    _is.DatabaseSession session,
    Resume row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Resume>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Resume>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ResumeTable> where,
    _is.OrderByBuilder<ResumeTable>? orderBy,
    _is.OrderByListBuilder<ResumeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Resume>(
      where: where(Resume.t),
      orderBy: orderBy?.call(Resume.t),
      orderByList: orderByList?.call(Resume.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ResumeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Resume>(
      where: where?.call(Resume.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Resume] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ResumeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Resume>(
      where: where(Resume.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ResumeAttachRowRepository {
  const ResumeAttachRowRepository._();

  /// Creates a relation between the given [Resume] and [AuthUser]
  /// by setting the [Resume]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    Resume resume,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (resume.id == null) {
      throw ArgumentError.notNull('resume.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $resume = resume.copyWith(authUserId: authUser.id);
    await session.db.updateRow<Resume>(
      $resume,
      columns: [Resume.t.authUserId],
      transaction: transaction,
    );
  }
}
