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
import 'package:interview_arena_server/src/generated/protocol.dart'
    as _iq9nucou;
import 'package:serverpod/serverpod.dart' as _is;
import '../challenges/challenge_difficulty.dart' as _ikp2tgfr;
import '../interview/question_category.dart' as _ietck0qu;

/// A recurring daily challenge. Global, server-only in pass 1.
/// Later phase: offline copy via a separate `database: client` table.
abstract class Challenge
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Challenge._({
    this.id,
    required this.scheduledFor,
    required this.title,
    required this.prompt,
    required this.category,
    _ikp2tgfr.ChallengeDifficulty? difficulty,
    required this.targetSkills,
    this.rubric,
    this.timeLimit,
    DateTime? createdAt,
  }) : difficulty = difficulty ?? _ikp2tgfr.ChallengeDifficulty.medium,
       createdAt = createdAt ?? DateTime.now();

  factory Challenge({
    _is.UuidValue? id,
    required DateTime scheduledFor,
    required String title,
    required String prompt,
    required _ietck0qu.QuestionCategory category,
    _ikp2tgfr.ChallengeDifficulty? difficulty,
    required List<String> targetSkills,
    List<String>? rubric,
    Duration? timeLimit,
    DateTime? createdAt,
  }) = _ChallengeImpl;

  factory Challenge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Challenge(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      scheduledFor: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledFor'],
      ),
      title: jsonSerialization['title'] as String,
      prompt: jsonSerialization['prompt'] as String,
      category: _ietck0qu.QuestionCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      difficulty: jsonSerialization['difficulty'] == null
          ? null
          : _ikp2tgfr.ChallengeDifficulty.fromJson(
              (jsonSerialization['difficulty'] as String),
            ),
      targetSkills: _iq9nucou.Protocol().deserialize<List<String>>(
        jsonSerialization['targetSkills'],
      ),
      rubric: jsonSerialization['rubric'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<List<String>>(
              jsonSerialization['rubric'],
            ),
      timeLimit: jsonSerialization['timeLimit'] == null
          ? null
          : _is.DurationJsonExtension.fromJson(jsonSerialization['timeLimit']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ChallengeTable();

  static const db = ChallengeRepository._();

  @override
  _is.UuidValue? id;

  /// UTC midnight of the day this challenge is for.
  DateTime scheduledFor;

  String title;

  String prompt;

  _ietck0qu.QuestionCategory category;

  _ikp2tgfr.ChallengeDifficulty difficulty;

  List<String> targetSkills;

  List<String>? rubric;

  Duration? timeLimit;

  DateTime createdAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Challenge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Challenge copyWith({
    _is.UuidValue? id,
    DateTime? scheduledFor,
    String? title,
    String? prompt,
    _ietck0qu.QuestionCategory? category,
    _ikp2tgfr.ChallengeDifficulty? difficulty,
    List<String>? targetSkills,
    List<String>? rubric,
    Duration? timeLimit,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Challenge',
      if (id != null) 'id': id?.toJson(),
      'scheduledFor': scheduledFor.toJson(),
      'title': title,
      'prompt': prompt,
      'category': category.toJson(),
      'difficulty': difficulty.toJson(),
      'targetSkills': targetSkills.toJson(),
      if (rubric != null) 'rubric': rubric?.toJson(),
      if (timeLimit != null) 'timeLimit': timeLimit?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Challenge',
      if (id != null) 'id': id?.toJson(),
      'scheduledFor': scheduledFor.toJson(),
      'title': title,
      'prompt': prompt,
      'category': category.toJson(),
      'difficulty': difficulty.toJson(),
      'targetSkills': targetSkills.toJson(),
      if (rubric != null) 'rubric': rubric?.toJson(),
      if (timeLimit != null) 'timeLimit': timeLimit?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static ChallengeInclude include() {
    return ChallengeInclude._();
  }

  static ChallengeIncludeList includeList({
    _is.WhereExpressionBuilder<ChallengeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChallengeTable>? orderBy,
    _is.OrderByListBuilder<ChallengeTable>? orderByList,
    ChallengeInclude? include,
  }) {
    return ChallengeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeImpl extends Challenge {
  _ChallengeImpl({
    _is.UuidValue? id,
    required DateTime scheduledFor,
    required String title,
    required String prompt,
    required _ietck0qu.QuestionCategory category,
    _ikp2tgfr.ChallengeDifficulty? difficulty,
    required List<String> targetSkills,
    List<String>? rubric,
    Duration? timeLimit,
    DateTime? createdAt,
  }) : super._(
         id: id,
         scheduledFor: scheduledFor,
         title: title,
         prompt: prompt,
         category: category,
         difficulty: difficulty,
         targetSkills: targetSkills,
         rubric: rubric,
         timeLimit: timeLimit,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Challenge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Challenge copyWith({
    Object? id = _Undefined,
    DateTime? scheduledFor,
    String? title,
    String? prompt,
    _ietck0qu.QuestionCategory? category,
    _ikp2tgfr.ChallengeDifficulty? difficulty,
    List<String>? targetSkills,
    Object? rubric = _Undefined,
    Object? timeLimit = _Undefined,
    DateTime? createdAt,
  }) {
    return Challenge(
      id: id is _is.UuidValue? ? id : this.id,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      title: title ?? this.title,
      prompt: prompt ?? this.prompt,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      targetSkills: targetSkills ?? this.targetSkills.map((e0) => e0).toList(),
      rubric: rubric is List<String>?
          ? rubric
          : this.rubric?.map((e0) => e0).toList(),
      timeLimit: timeLimit is Duration? ? timeLimit : this.timeLimit,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ChallengeUpdateTable extends _is.UpdateTable<ChallengeTable> {
  ChallengeUpdateTable(super.table);

  _is.ColumnValue<DateTime, DateTime> scheduledFor(DateTime value) =>
      _is.ColumnValue(
        table.scheduledFor,
        value,
      );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> prompt(String value) => _is.ColumnValue(
    table.prompt,
    value,
  );

  _is.ColumnValue<_ietck0qu.QuestionCategory, _ietck0qu.QuestionCategory>
  category(_ietck0qu.QuestionCategory value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<_ikp2tgfr.ChallengeDifficulty, _ikp2tgfr.ChallengeDifficulty>
  difficulty(_ikp2tgfr.ChallengeDifficulty value) => _is.ColumnValue(
    table.difficulty,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> targetSkills(
    List<String> value,
  ) => _is.ColumnValue(
    table.targetSkills,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> rubric(List<String>? value) =>
      _is.ColumnValue(
        table.rubric,
        value,
      );

  _is.ColumnValue<Duration, Duration> timeLimit(Duration? value) =>
      _is.ColumnValue(
        table.timeLimit,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ChallengeTable extends _is.Table<_is.UuidValue?> {
  ChallengeTable({super.tableRelation}) : super(tableName: 'challenge') {
    updateTable = ChallengeUpdateTable(this);
    scheduledFor = _is.ColumnDateTime(
      'scheduledFor',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    prompt = _is.ColumnString(
      'prompt',
      this,
    );
    category = _is.ColumnEnum(
      'category',
      this,
      _is.EnumSerialization.byName,
    );
    difficulty = _is.ColumnEnum(
      'difficulty',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    targetSkills = _is.ColumnStructured<List<String>>(
      'targetSkills',
      this,
    );
    rubric = _is.ColumnStructured<List<String>>(
      'rubric',
      this,
    );
    timeLimit = _is.ColumnDuration(
      'timeLimit',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ChallengeUpdateTable updateTable;

  /// UTC midnight of the day this challenge is for.
  late final _is.ColumnDateTime scheduledFor;

  late final _is.ColumnString title;

  late final _is.ColumnString prompt;

  late final _is.ColumnEnum<_ietck0qu.QuestionCategory> category;

  late final _is.ColumnEnum<_ikp2tgfr.ChallengeDifficulty> difficulty;

  late final _is.ColumnStructured<List<String>> targetSkills;

  late final _is.ColumnStructured<List<String>> rubric;

  late final _is.ColumnDuration timeLimit;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    scheduledFor,
    title,
    prompt,
    category,
    difficulty,
    targetSkills,
    rubric,
    timeLimit,
    createdAt,
  ];
}

class ChallengeInclude extends _is.IncludeObject {
  ChallengeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => Challenge.t;
}

class ChallengeIncludeList extends _is.IncludeList {
  ChallengeIncludeList._({
    _is.WhereExpressionBuilder<ChallengeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Challenge.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Challenge.t;
}

class ChallengeRepository {
  const ChallengeRepository._();

  /// Returns a list of [Challenge]s matching the given query parameters.
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
  Future<List<Challenge>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChallengeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChallengeTable>? orderBy,
    _is.OrderByListBuilder<ChallengeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Challenge>(
      where: where?.call(Challenge.t),
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Challenge] matching the given query parameters.
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
  Future<Challenge?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChallengeTable>? where,
    int? offset,
    _is.OrderByBuilder<ChallengeTable>? orderBy,
    _is.OrderByListBuilder<ChallengeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Challenge>(
      where: where?.call(Challenge.t),
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Challenge] by its [id] or null if no such row exists.
  Future<Challenge?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Challenge>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Challenge]s in the list and returns the inserted rows.
  ///
  /// The returned [Challenge]s will have their `id` fields set.
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
  Future<List<Challenge>> insert(
    _is.DatabaseSession session,
    List<Challenge> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Challenge>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Challenge] and returns the inserted row.
  ///
  /// The returned [Challenge] will have its `id` field set.
  Future<Challenge> insertRow(
    _is.DatabaseSession session,
    Challenge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Challenge>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Challenge]s in the list and returns the resulting rows.
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
  /// The returned [Challenge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Challenge>> upsert(
    _is.DatabaseSession session,
    List<Challenge> rows, {
    required _is.ColumnSelections<ChallengeTable> conflictColumns,
    _is.ColumnSelections<ChallengeTable>? updateColumns,
    _is.WhereExpressionBuilder<ChallengeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Challenge>(
      rows,
      conflictColumns: conflictColumns(Challenge.t),
      updateColumns: updateColumns?.call(Challenge.t),
      updateWhere: updateWhere?.call(Challenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Challenge] and returns the resulting row.
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
  /// The returned [Challenge] will have its `id` field set.
  Future<Challenge?> upsertRow(
    _is.DatabaseSession session,
    Challenge row, {
    required _is.ColumnSelections<ChallengeTable> conflictColumns,
    _is.ColumnSelections<ChallengeTable>? updateColumns,
    _is.WhereExpressionBuilder<ChallengeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Challenge>(
      row,
      conflictColumns: conflictColumns(Challenge.t),
      updateColumns: updateColumns?.call(Challenge.t),
      updateWhere: updateWhere?.call(Challenge.t),
      transaction: transaction,
    );
  }

  /// Updates all [Challenge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Challenge>> update(
    _is.DatabaseSession session,
    List<Challenge> rows, {
    _is.ColumnSelections<ChallengeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Challenge>(
      rows,
      columns: columns?.call(Challenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Challenge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Challenge> updateRow(
    _is.DatabaseSession session,
    Challenge row, {
    _is.ColumnSelections<ChallengeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Challenge>(
      row,
      columns: columns?.call(Challenge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Challenge] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Challenge?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<ChallengeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Challenge>(
      id,
      columnValues: columnValues(Challenge.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Challenge]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Challenge>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChallengeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ChallengeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChallengeTable>? orderBy,
    _is.OrderByListBuilder<ChallengeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Challenge>(
      columnValues: columnValues(Challenge.t.updateTable),
      where: where(Challenge.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Challenge]s in the list and returns the deleted rows.
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
  Future<List<Challenge>> delete(
    _is.DatabaseSession session,
    List<Challenge> rows, {
    _is.OrderByBuilder<ChallengeTable>? orderBy,
    _is.OrderByListBuilder<ChallengeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Challenge>(
      rows,
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Challenge].
  Future<Challenge> deleteRow(
    _is.DatabaseSession session,
    Challenge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Challenge>(
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
  Future<List<Challenge>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChallengeTable> where,
    _is.OrderByBuilder<ChallengeTable>? orderBy,
    _is.OrderByListBuilder<ChallengeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Challenge>(
      where: where(Challenge.t),
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChallengeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Challenge>(
      where: where?.call(Challenge.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Challenge] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChallengeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Challenge>(
      where: where(Challenge.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
