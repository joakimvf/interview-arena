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
import '../interview/answer.dart' as _if3yqgpc;
import '../interview/interview_session.dart' as _iwk4fsrc;
import '../interview/question_category.dart' as _ietck0qu;

/// A question asked during an interview session.
abstract class Question
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Question._({
    this.id,
    required this.interviewSessionId,
    this.interviewSession,
    required this.orderIndex,
    required this.category,
    required this.prompt,
    required this.targetSkills,
    bool? isFollowUp,
    DateTime? askedAt,
    this.answers,
  }) : isFollowUp = isFollowUp ?? false,
       askedAt = askedAt ?? DateTime.now();

  factory Question({
    int? id,
    required int interviewSessionId,
    _iwk4fsrc.InterviewSession? interviewSession,
    required int orderIndex,
    required _ietck0qu.QuestionCategory category,
    required String prompt,
    required List<String> targetSkills,
    bool? isFollowUp,
    DateTime? askedAt,
    List<_if3yqgpc.Answer>? answers,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      interviewSessionId: jsonSerialization['interviewSessionId'] as int,
      interviewSession: jsonSerialization['interviewSession'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_iwk4fsrc.InterviewSession>(
              jsonSerialization['interviewSession'],
            ),
      orderIndex: jsonSerialization['orderIndex'] as int,
      category: _ietck0qu.QuestionCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      prompt: jsonSerialization['prompt'] as String,
      targetSkills: _iq9nucou.Protocol().deserialize<List<String>>(
        jsonSerialization['targetSkills'],
      ),
      isFollowUp: jsonSerialization['isFollowUp'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isFollowUp']),
      askedAt: jsonSerialization['askedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['askedAt']),
      answers: jsonSerialization['answers'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<List<_if3yqgpc.Answer>>(
              jsonSerialization['answers'],
            ),
    );
  }

  static final t = QuestionTable();

  static const db = QuestionRepository._();

  @override
  int? id;

  int interviewSessionId;

  _iwk4fsrc.InterviewSession? interviewSession;

  int orderIndex;

  _ietck0qu.QuestionCategory category;

  String prompt;

  List<String> targetSkills;

  bool isFollowUp;

  DateTime askedAt;

  List<_if3yqgpc.Answer>? answers;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Question copyWith({
    int? id,
    int? interviewSessionId,
    _iwk4fsrc.InterviewSession? interviewSession,
    int? orderIndex,
    _ietck0qu.QuestionCategory? category,
    String? prompt,
    List<String>? targetSkills,
    bool? isFollowUp,
    DateTime? askedAt,
    List<_if3yqgpc.Answer>? answers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'interviewSessionId': interviewSessionId,
      if (interviewSession != null)
        'interviewSession': interviewSession?.toJson(),
      'orderIndex': orderIndex,
      'category': category.toJson(),
      'prompt': prompt,
      'targetSkills': targetSkills.toJson(),
      'isFollowUp': isFollowUp,
      'askedAt': askedAt.toJson(),
      if (answers != null)
        'answers': answers?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'interviewSessionId': interviewSessionId,
      if (interviewSession != null)
        'interviewSession': interviewSession?.toJsonForProtocol(),
      'orderIndex': orderIndex,
      'category': category.toJson(),
      'prompt': prompt,
      'targetSkills': targetSkills.toJson(),
      'isFollowUp': isFollowUp,
      'askedAt': askedAt.toJson(),
      if (answers != null)
        'answers': answers?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static QuestionInclude include({
    _iwk4fsrc.InterviewSessionInclude? interviewSession,
    _if3yqgpc.AnswerIncludeList? answers,
  }) {
    return QuestionInclude._(
      interviewSession: interviewSession,
      answers: answers,
    );
  }

  static QuestionIncludeList includeList({
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    QuestionInclude? include,
  }) {
    return QuestionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required int interviewSessionId,
    _iwk4fsrc.InterviewSession? interviewSession,
    required int orderIndex,
    required _ietck0qu.QuestionCategory category,
    required String prompt,
    required List<String> targetSkills,
    bool? isFollowUp,
    DateTime? askedAt,
    List<_if3yqgpc.Answer>? answers,
  }) : super._(
         id: id,
         interviewSessionId: interviewSessionId,
         interviewSession: interviewSession,
         orderIndex: orderIndex,
         category: category,
         prompt: prompt,
         targetSkills: targetSkills,
         isFollowUp: isFollowUp,
         askedAt: askedAt,
         answers: answers,
       );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    int? interviewSessionId,
    Object? interviewSession = _Undefined,
    int? orderIndex,
    _ietck0qu.QuestionCategory? category,
    String? prompt,
    List<String>? targetSkills,
    bool? isFollowUp,
    DateTime? askedAt,
    Object? answers = _Undefined,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      interviewSessionId: interviewSessionId ?? this.interviewSessionId,
      interviewSession: interviewSession is _iwk4fsrc.InterviewSession?
          ? interviewSession
          : this.interviewSession?.copyWith(),
      orderIndex: orderIndex ?? this.orderIndex,
      category: category ?? this.category,
      prompt: prompt ?? this.prompt,
      targetSkills: targetSkills ?? this.targetSkills.map((e0) => e0).toList(),
      isFollowUp: isFollowUp ?? this.isFollowUp,
      askedAt: askedAt ?? this.askedAt,
      answers: answers is List<_if3yqgpc.Answer>?
          ? answers
          : this.answers?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class QuestionUpdateTable extends _is.UpdateTable<QuestionTable> {
  QuestionUpdateTable(super.table);

  _is.ColumnValue<int, int> interviewSessionId(int value) => _is.ColumnValue(
    table.interviewSessionId,
    value,
  );

  _is.ColumnValue<int, int> orderIndex(int value) => _is.ColumnValue(
    table.orderIndex,
    value,
  );

  _is.ColumnValue<_ietck0qu.QuestionCategory, _ietck0qu.QuestionCategory>
  category(_ietck0qu.QuestionCategory value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> prompt(String value) => _is.ColumnValue(
    table.prompt,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> targetSkills(
    List<String> value,
  ) => _is.ColumnValue(
    table.targetSkills,
    value,
  );

  _is.ColumnValue<bool, bool> isFollowUp(bool value) => _is.ColumnValue(
    table.isFollowUp,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> askedAt(DateTime value) =>
      _is.ColumnValue(
        table.askedAt,
        value,
      );
}

class QuestionTable extends _is.Table<int?> {
  QuestionTable({super.tableRelation}) : super(tableName: 'question') {
    updateTable = QuestionUpdateTable(this);
    interviewSessionId = _is.ColumnInt(
      'interviewSessionId',
      this,
    );
    orderIndex = _is.ColumnInt(
      'orderIndex',
      this,
    );
    category = _is.ColumnEnum(
      'category',
      this,
      _is.EnumSerialization.byName,
    );
    prompt = _is.ColumnString(
      'prompt',
      this,
    );
    targetSkills = _is.ColumnStructured<List<String>>(
      'targetSkills',
      this,
    );
    isFollowUp = _is.ColumnBool(
      'isFollowUp',
      this,
      hasDefault: true,
    );
    askedAt = _is.ColumnDateTime(
      'askedAt',
      this,
      hasDefault: true,
    );
  }

  late final QuestionUpdateTable updateTable;

  late final _is.ColumnInt interviewSessionId;

  _iwk4fsrc.InterviewSessionTable? _interviewSession;

  late final _is.ColumnInt orderIndex;

  late final _is.ColumnEnum<_ietck0qu.QuestionCategory> category;

  late final _is.ColumnString prompt;

  late final _is.ColumnStructured<List<String>> targetSkills;

  late final _is.ColumnBool isFollowUp;

  late final _is.ColumnDateTime askedAt;

  _if3yqgpc.AnswerTable? ___answers;

  _is.ManyRelation<_if3yqgpc.AnswerTable>? _answers;

  _iwk4fsrc.InterviewSessionTable get interviewSession {
    if (_interviewSession != null) return _interviewSession!;
    _interviewSession = _is.createRelationTable(
      relationFieldName: 'interviewSession',
      field: Question.t.interviewSessionId,
      foreignField: _iwk4fsrc.InterviewSession.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iwk4fsrc.InterviewSessionTable(tableRelation: foreignTableRelation),
    );
    return _interviewSession!;
  }

  _if3yqgpc.AnswerTable get __answers {
    if (___answers != null) return ___answers!;
    ___answers = _is.createRelationTable(
      relationFieldName: '__answers',
      field: Question.t.id,
      foreignField: _if3yqgpc.Answer.t.questionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _if3yqgpc.AnswerTable(tableRelation: foreignTableRelation),
    );
    return ___answers!;
  }

  _is.ManyRelation<_if3yqgpc.AnswerTable> get answers {
    if (_answers != null) return _answers!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'answers',
      field: Question.t.id,
      foreignField: _if3yqgpc.Answer.t.questionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _if3yqgpc.AnswerTable(tableRelation: foreignTableRelation),
    );
    _answers = _is.ManyRelation<_if3yqgpc.AnswerTable>(
      tableWithRelations: relationTable,
      table: _if3yqgpc.AnswerTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _answers!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    interviewSessionId,
    orderIndex,
    category,
    prompt,
    targetSkills,
    isFollowUp,
    askedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'interviewSession') {
      return interviewSession;
    }
    if (relationField == 'answers') {
      return __answers;
    }
    return null;
  }
}

class QuestionInclude extends _is.IncludeObject {
  QuestionInclude._({
    _iwk4fsrc.InterviewSessionInclude? interviewSession,
    _if3yqgpc.AnswerIncludeList? answers,
  }) {
    _interviewSession = interviewSession;
    _answers = answers;
  }

  _iwk4fsrc.InterviewSessionInclude? _interviewSession;

  _if3yqgpc.AnswerIncludeList? _answers;

  @override
  Map<String, _is.Include?> get includes => {
    'interviewSession': _interviewSession,
    'answers': _answers,
  };

  @override
  _is.Table<int?> get table => Question.t;
}

class QuestionIncludeList extends _is.IncludeList {
  QuestionIncludeList._({
    _is.WhereExpressionBuilder<QuestionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Question.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Question.t;
}

class QuestionRepository {
  const QuestionRepository._();

  final attach = const QuestionAttachRepository._();

  final attachRow = const QuestionAttachRowRepository._();

  /// Returns a list of [Question]s matching the given query parameters.
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
  Future<List<Question>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    QuestionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Question] matching the given query parameters.
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
  Future<Question?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    QuestionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Question] by its [id] or null if no such row exists.
  Future<Question?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    QuestionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Question>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Question]s in the list and returns the inserted rows.
  ///
  /// The returned [Question]s will have their `id` fields set.
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
  Future<List<Question>> insert(
    _is.DatabaseSession session,
    List<Question> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Question>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Question] and returns the inserted row.
  ///
  /// The returned [Question] will have its `id` field set.
  Future<Question> insertRow(
    _is.DatabaseSession session,
    Question row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Question]s in the list and returns the resulting rows.
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
  /// The returned [Question]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> upsert(
    _is.DatabaseSession session,
    List<Question> rows, {
    required _is.ColumnSelections<QuestionTable> conflictColumns,
    _is.ColumnSelections<QuestionTable>? updateColumns,
    _is.WhereExpressionBuilder<QuestionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Question>(
      rows,
      conflictColumns: conflictColumns(Question.t),
      updateColumns: updateColumns?.call(Question.t),
      updateWhere: updateWhere?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Question] and returns the resulting row.
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
  /// The returned [Question] will have its `id` field set.
  Future<Question?> upsertRow(
    _is.DatabaseSession session,
    Question row, {
    required _is.ColumnSelections<QuestionTable> conflictColumns,
    _is.ColumnSelections<QuestionTable>? updateColumns,
    _is.WhereExpressionBuilder<QuestionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Question>(
      row,
      conflictColumns: conflictColumns(Question.t),
      updateColumns: updateColumns?.call(Question.t),
      updateWhere: updateWhere?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates all [Question]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> update(
    _is.DatabaseSession session,
    List<Question> rows, {
    _is.ColumnSelections<QuestionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Question>(
      rows,
      columns: columns?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Question]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Question> updateRow(
    _is.DatabaseSession session,
    Question row, {
    _is.ColumnSelections<QuestionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Question>(
      row,
      columns: columns?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Question] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Question?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Question>(
      id,
      columnValues: columnValues(Question.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Question]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<QuestionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Question>(
      columnValues: columnValues(Question.t.updateTable),
      where: where(Question.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Question]s in the list and returns the deleted rows.
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
  Future<List<Question>> delete(
    _is.DatabaseSession session,
    List<Question> rows, {
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Question>(
      rows,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Question].
  Future<Question> deleteRow(
    _is.DatabaseSession session,
    Question row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Question>(
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
  Future<List<Question>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuestionTable> where,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Question>(
      where: where(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Question>(
      where: where?.call(Question.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Question] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuestionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Question>(
      where: where(Question.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class QuestionAttachRepository {
  const QuestionAttachRepository._();

  /// Creates a relation between this [Question] and the given [Answer]s
  /// by setting each [Answer]'s foreign key `questionId` to refer to this [Question].
  Future<void> answers(
    _is.DatabaseSession session,
    Question question,
    List<_if3yqgpc.Answer> answer, {
    _is.Transaction? transaction,
  }) async {
    if (answer.any((e) => e.id == null)) {
      throw ArgumentError.notNull('answer.id');
    }
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }

    var $answer = answer
        .map((e) => e.copyWith(questionId: question.id))
        .toList();
    await session.db.update<_if3yqgpc.Answer>(
      $answer,
      columns: [_if3yqgpc.Answer.t.questionId],
      transaction: transaction,
    );
  }
}

class QuestionAttachRowRepository {
  const QuestionAttachRowRepository._();

  /// Creates a relation between the given [Question] and [InterviewSession]
  /// by setting the [Question]'s foreign key `interviewSessionId` to refer to the [InterviewSession].
  Future<void> interviewSession(
    _is.DatabaseSession session,
    Question question,
    _iwk4fsrc.InterviewSession interviewSession, {
    _is.Transaction? transaction,
  }) async {
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }
    if (interviewSession.id == null) {
      throw ArgumentError.notNull('interviewSession.id');
    }

    var $question = question.copyWith(interviewSessionId: interviewSession.id);
    await session.db.updateRow<Question>(
      $question,
      columns: [Question.t.interviewSessionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Question] and the given [Answer]
  /// by setting the [Answer]'s foreign key `questionId` to refer to this [Question].
  Future<void> answers(
    _is.DatabaseSession session,
    Question question,
    _if3yqgpc.Answer answer, {
    _is.Transaction? transaction,
  }) async {
    if (answer.id == null) {
      throw ArgumentError.notNull('answer.id');
    }
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }

    var $answer = answer.copyWith(questionId: question.id);
    await session.db.updateRow<_if3yqgpc.Answer>(
      $answer,
      columns: [_if3yqgpc.Answer.t.questionId],
      transaction: transaction,
    );
  }
}
