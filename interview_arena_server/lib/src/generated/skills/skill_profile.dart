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
import '../interview/interview_scores.dart' as _i5tfukg1;
import '../skills/skill_node.dart' as _isj6cble;
import '../skills/weakness.dart' as _iqykx933;

/// Per-user skill graph with strengths/weaknesses (jsonb).
abstract class SkillProfile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SkillProfile._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.skillGraph,
    required this.weaknesses,
    required this.strengths,
    this.averageScores,
    int? sessionsCompleted,
    DateTime? updatedAt,
  }) : sessionsCompleted = sessionsCompleted ?? 0,
       updatedAt = updatedAt ?? DateTime.now();

  factory SkillProfile({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required Map<String, _isj6cble.SkillNode> skillGraph,
    required List<_iqykx933.Weakness> weaknesses,
    required List<String> strengths,
    _i5tfukg1.InterviewScores? averageScores,
    int? sessionsCompleted,
    DateTime? updatedAt,
  }) = _SkillProfileImpl;

  factory SkillProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return SkillProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      skillGraph: _iq9nucou.Protocol()
          .deserialize<Map<String, _isj6cble.SkillNode>>(
            jsonSerialization['skillGraph'],
          ),
      weaknesses: _iq9nucou.Protocol().deserialize<List<_iqykx933.Weakness>>(
        jsonSerialization['weaknesses'],
      ),
      strengths: _iq9nucou.Protocol().deserialize<List<String>>(
        jsonSerialization['strengths'],
      ),
      averageScores: jsonSerialization['averageScores'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_i5tfukg1.InterviewScores>(
              jsonSerialization['averageScores'],
            ),
      sessionsCompleted: jsonSerialization['sessionsCompleted'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SkillProfileTable();

  static const db = SkillProfileRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  Map<String, _isj6cble.SkillNode> skillGraph;

  List<_iqykx933.Weakness> weaknesses;

  List<String> strengths;

  _i5tfukg1.InterviewScores? averageScores;

  int sessionsCompleted;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SkillProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SkillProfile copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    Map<String, _isj6cble.SkillNode>? skillGraph,
    List<_iqykx933.Weakness>? weaknesses,
    List<String>? strengths,
    _i5tfukg1.InterviewScores? averageScores,
    int? sessionsCompleted,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SkillProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'skillGraph': skillGraph.toJson(valueToJson: (v) => v.toJson()),
      'weaknesses': weaknesses.toJson(valueToJson: (v) => v.toJson()),
      'strengths': strengths.toJson(),
      if (averageScores != null) 'averageScores': averageScores?.toJson(),
      'sessionsCompleted': sessionsCompleted,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SkillProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'skillGraph': skillGraph.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'weaknesses': weaknesses.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'strengths': strengths.toJson(),
      if (averageScores != null)
        'averageScores': averageScores?.toJsonForProtocol(),
      'sessionsCompleted': sessionsCompleted,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SkillProfileInclude include({_iacs.AuthUserInclude? authUser}) {
    return SkillProfileInclude._(authUser: authUser);
  }

  static SkillProfileIncludeList includeList({
    _is.WhereExpressionBuilder<SkillProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SkillProfileTable>? orderBy,
    _is.OrderByListBuilder<SkillProfileTable>? orderByList,
    SkillProfileInclude? include,
  }) {
    return SkillProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SkillProfile.t),
      orderByList: orderByList?.call(SkillProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SkillProfileImpl extends SkillProfile {
  _SkillProfileImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required Map<String, _isj6cble.SkillNode> skillGraph,
    required List<_iqykx933.Weakness> weaknesses,
    required List<String> strengths,
    _i5tfukg1.InterviewScores? averageScores,
    int? sessionsCompleted,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         skillGraph: skillGraph,
         weaknesses: weaknesses,
         strengths: strengths,
         averageScores: averageScores,
         sessionsCompleted: sessionsCompleted,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SkillProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SkillProfile copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Map<String, _isj6cble.SkillNode>? skillGraph,
    List<_iqykx933.Weakness>? weaknesses,
    List<String>? strengths,
    Object? averageScores = _Undefined,
    int? sessionsCompleted,
    DateTime? updatedAt,
  }) {
    return SkillProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      skillGraph:
          skillGraph ??
          this.skillGraph.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0.copyWith(),
            ),
          ),
      weaknesses:
          weaknesses ?? this.weaknesses.map((e0) => e0.copyWith()).toList(),
      strengths: strengths ?? this.strengths.map((e0) => e0).toList(),
      averageScores: averageScores is _i5tfukg1.InterviewScores?
          ? averageScores
          : this.averageScores?.copyWith(),
      sessionsCompleted: sessionsCompleted ?? this.sessionsCompleted,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SkillProfileUpdateTable extends _is.UpdateTable<SkillProfileTable> {
  SkillProfileUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<
    Map<String, _isj6cble.SkillNode>,
    Map<String, _isj6cble.SkillNode>
  >
  skillGraph(Map<String, _isj6cble.SkillNode> value) => _is.ColumnValue(
    table.skillGraph,
    value,
  );

  _is.ColumnValue<List<_iqykx933.Weakness>, List<_iqykx933.Weakness>>
  weaknesses(List<_iqykx933.Weakness> value) => _is.ColumnValue(
    table.weaknesses,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> strengths(List<String> value) =>
      _is.ColumnValue(
        table.strengths,
        value,
      );

  _is.ColumnValue<_i5tfukg1.InterviewScores, _i5tfukg1.InterviewScores>
  averageScores(_i5tfukg1.InterviewScores? value) => _is.ColumnValue(
    table.averageScores,
    value,
  );

  _is.ColumnValue<int, int> sessionsCompleted(int value) => _is.ColumnValue(
    table.sessionsCompleted,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class SkillProfileTable extends _is.Table<int?> {
  SkillProfileTable({super.tableRelation}) : super(tableName: 'skill_profile') {
    updateTable = SkillProfileUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    skillGraph = _is.ColumnStructured<Map<String, _isj6cble.SkillNode>>(
      'skillGraph',
      this,
    );
    weaknesses = _is.ColumnStructured<List<_iqykx933.Weakness>>(
      'weaknesses',
      this,
    );
    strengths = _is.ColumnStructured<List<String>>(
      'strengths',
      this,
    );
    averageScores = _is.ColumnStructured<_i5tfukg1.InterviewScores>(
      'averageScores',
      this,
    );
    sessionsCompleted = _is.ColumnInt(
      'sessionsCompleted',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final SkillProfileUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnStructured<Map<String, _isj6cble.SkillNode>> skillGraph;

  late final _is.ColumnStructured<List<_iqykx933.Weakness>> weaknesses;

  late final _is.ColumnStructured<List<String>> strengths;

  late final _is.ColumnStructured<_i5tfukg1.InterviewScores> averageScores;

  late final _is.ColumnInt sessionsCompleted;

  late final _is.ColumnDateTime updatedAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: SkillProfile.t.authUserId,
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
    skillGraph,
    weaknesses,
    strengths,
    averageScores,
    sessionsCompleted,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class SkillProfileInclude extends _is.IncludeObject {
  SkillProfileInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => SkillProfile.t;
}

class SkillProfileIncludeList extends _is.IncludeList {
  SkillProfileIncludeList._({
    _is.WhereExpressionBuilder<SkillProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SkillProfile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SkillProfile.t;
}

class SkillProfileRepository {
  const SkillProfileRepository._();

  final attachRow = const SkillProfileAttachRowRepository._();

  /// Returns a list of [SkillProfile]s matching the given query parameters.
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
  Future<List<SkillProfile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SkillProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SkillProfileTable>? orderBy,
    _is.OrderByListBuilder<SkillProfileTable>? orderByList,
    _is.Transaction? transaction,
    SkillProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SkillProfile>(
      where: where?.call(SkillProfile.t),
      orderBy: orderBy?.call(SkillProfile.t),
      orderByList: orderByList?.call(SkillProfile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SkillProfile] matching the given query parameters.
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
  Future<SkillProfile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SkillProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<SkillProfileTable>? orderBy,
    _is.OrderByListBuilder<SkillProfileTable>? orderByList,
    _is.Transaction? transaction,
    SkillProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SkillProfile>(
      where: where?.call(SkillProfile.t),
      orderBy: orderBy?.call(SkillProfile.t),
      orderByList: orderByList?.call(SkillProfile.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SkillProfile] by its [id] or null if no such row exists.
  Future<SkillProfile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    SkillProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SkillProfile>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SkillProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [SkillProfile]s will have their `id` fields set.
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
  Future<List<SkillProfile>> insert(
    _is.DatabaseSession session,
    List<SkillProfile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SkillProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SkillProfile] and returns the inserted row.
  ///
  /// The returned [SkillProfile] will have its `id` field set.
  Future<SkillProfile> insertRow(
    _is.DatabaseSession session,
    SkillProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SkillProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SkillProfile]s in the list and returns the resulting rows.
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
  /// The returned [SkillProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SkillProfile>> upsert(
    _is.DatabaseSession session,
    List<SkillProfile> rows, {
    required _is.ColumnSelections<SkillProfileTable> conflictColumns,
    _is.ColumnSelections<SkillProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<SkillProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SkillProfile>(
      rows,
      conflictColumns: conflictColumns(SkillProfile.t),
      updateColumns: updateColumns?.call(SkillProfile.t),
      updateWhere: updateWhere?.call(SkillProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SkillProfile] and returns the resulting row.
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
  /// The returned [SkillProfile] will have its `id` field set.
  Future<SkillProfile?> upsertRow(
    _is.DatabaseSession session,
    SkillProfile row, {
    required _is.ColumnSelections<SkillProfileTable> conflictColumns,
    _is.ColumnSelections<SkillProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<SkillProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SkillProfile>(
      row,
      conflictColumns: conflictColumns(SkillProfile.t),
      updateColumns: updateColumns?.call(SkillProfile.t),
      updateWhere: updateWhere?.call(SkillProfile.t),
      transaction: transaction,
    );
  }

  /// Updates all [SkillProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SkillProfile>> update(
    _is.DatabaseSession session,
    List<SkillProfile> rows, {
    _is.ColumnSelections<SkillProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SkillProfile>(
      rows,
      columns: columns?.call(SkillProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SkillProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SkillProfile> updateRow(
    _is.DatabaseSession session,
    SkillProfile row, {
    _is.ColumnSelections<SkillProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SkillProfile>(
      row,
      columns: columns?.call(SkillProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SkillProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SkillProfile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SkillProfileUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SkillProfile>(
      id,
      columnValues: columnValues(SkillProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SkillProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SkillProfile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SkillProfileUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SkillProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SkillProfileTable>? orderBy,
    _is.OrderByListBuilder<SkillProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SkillProfile>(
      columnValues: columnValues(SkillProfile.t.updateTable),
      where: where(SkillProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SkillProfile.t),
      orderByList: orderByList?.call(SkillProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SkillProfile]s in the list and returns the deleted rows.
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
  Future<List<SkillProfile>> delete(
    _is.DatabaseSession session,
    List<SkillProfile> rows, {
    _is.OrderByBuilder<SkillProfileTable>? orderBy,
    _is.OrderByListBuilder<SkillProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SkillProfile>(
      rows,
      orderBy: orderBy?.call(SkillProfile.t),
      orderByList: orderByList?.call(SkillProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SkillProfile].
  Future<SkillProfile> deleteRow(
    _is.DatabaseSession session,
    SkillProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SkillProfile>(
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
  Future<List<SkillProfile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SkillProfileTable> where,
    _is.OrderByBuilder<SkillProfileTable>? orderBy,
    _is.OrderByListBuilder<SkillProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SkillProfile>(
      where: where(SkillProfile.t),
      orderBy: orderBy?.call(SkillProfile.t),
      orderByList: orderByList?.call(SkillProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SkillProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SkillProfile>(
      where: where?.call(SkillProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SkillProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SkillProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SkillProfile>(
      where: where(SkillProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SkillProfileAttachRowRepository {
  const SkillProfileAttachRowRepository._();

  /// Creates a relation between the given [SkillProfile] and [AuthUser]
  /// by setting the [SkillProfile]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    SkillProfile skillProfile,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (skillProfile.id == null) {
      throw ArgumentError.notNull('skillProfile.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $skillProfile = skillProfile.copyWith(authUserId: authUser.id);
    await session.db.updateRow<SkillProfile>(
      $skillProfile,
      columns: [SkillProfile.t.authUserId],
      transaction: transaction,
    );
  }
}
