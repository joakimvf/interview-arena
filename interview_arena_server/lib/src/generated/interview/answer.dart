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
import '../interview/answer_feedback.dart' as _ied67bjz;
import '../interview/interview_scores.dart' as _i5tfukg1;
import '../interview/question.dart' as _i6athr3z;

/// A candidate answer. Also the "career memory" row (embedding).
abstract class Answer implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Answer._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.questionId,
    this.question,
    required this.transcript,
    this.answerDuration,
    this.scores,
    this.feedback,
    this.embedding,
    this.embeddingModel,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Answer({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required int questionId,
    _i6athr3z.Question? question,
    required String transcript,
    Duration? answerDuration,
    _i5tfukg1.InterviewScores? scores,
    _ied67bjz.AnswerFeedback? feedback,
    _is.Vector? embedding,
    String? embeddingModel,
    DateTime? createdAt,
  }) = _AnswerImpl;

  factory Answer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Answer(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      questionId: jsonSerialization['questionId'] as int,
      question: jsonSerialization['question'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_i6athr3z.Question>(
              jsonSerialization['question'],
            ),
      transcript: jsonSerialization['transcript'] as String,
      answerDuration: jsonSerialization['answerDuration'] == null
          ? null
          : _is.DurationJsonExtension.fromJson(
              jsonSerialization['answerDuration'],
            ),
      scores: jsonSerialization['scores'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_i5tfukg1.InterviewScores>(
              jsonSerialization['scores'],
            ),
      feedback: jsonSerialization['feedback'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_ied67bjz.AnswerFeedback>(
              jsonSerialization['feedback'],
            ),
      embedding: jsonSerialization['embedding'] == null
          ? null
          : _is.VectorJsonExtension.fromJson(jsonSerialization['embedding']),
      embeddingModel: jsonSerialization['embeddingModel'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AnswerTable();

  static const db = AnswerRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// Denormalised owner so similarity search filters without joins.
  _iacs.AuthUser? authUser;

  int questionId;

  _i6athr3z.Question? question;

  String transcript;

  Duration? answerDuration;

  _i5tfukg1.InterviewScores? scores;

  _ied67bjz.AnswerFeedback? feedback;

  /// pgvector embedding (voyage-4 @ 1024 dims). Server-only.
  _is.Vector? embedding;

  /// Set together with embedding: which model produced it (idempotency check).
  String? embeddingModel;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Answer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Answer copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    int? questionId,
    _i6athr3z.Question? question,
    String? transcript,
    Duration? answerDuration,
    _i5tfukg1.InterviewScores? scores,
    _ied67bjz.AnswerFeedback? feedback,
    _is.Vector? embedding,
    String? embeddingModel,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Answer',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'questionId': questionId,
      if (question != null) 'question': question?.toJson(),
      'transcript': transcript,
      if (answerDuration != null) 'answerDuration': answerDuration?.toJson(),
      if (scores != null) 'scores': scores?.toJson(),
      if (feedback != null) 'feedback': feedback?.toJson(),
      if (embedding != null) 'embedding': embedding?.toJson(),
      if (embeddingModel != null) 'embeddingModel': embeddingModel,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Answer',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'questionId': questionId,
      if (question != null) 'question': question?.toJsonForProtocol(),
      'transcript': transcript,
      if (answerDuration != null) 'answerDuration': answerDuration?.toJson(),
      if (scores != null) 'scores': scores?.toJsonForProtocol(),
      if (feedback != null) 'feedback': feedback?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static AnswerInclude include({
    _iacs.AuthUserInclude? authUser,
    _i6athr3z.QuestionInclude? question,
  }) {
    return AnswerInclude._(
      authUser: authUser,
      question: question,
    );
  }

  static AnswerIncludeList includeList({
    _is.WhereExpressionBuilder<AnswerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AnswerTable>? orderBy,
    _is.OrderByListBuilder<AnswerTable>? orderByList,
    AnswerInclude? include,
  }) {
    return AnswerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Answer.t),
      orderByList: orderByList?.call(Answer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnswerImpl extends Answer {
  _AnswerImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required int questionId,
    _i6athr3z.Question? question,
    required String transcript,
    Duration? answerDuration,
    _i5tfukg1.InterviewScores? scores,
    _ied67bjz.AnswerFeedback? feedback,
    _is.Vector? embedding,
    String? embeddingModel,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         questionId: questionId,
         question: question,
         transcript: transcript,
         answerDuration: answerDuration,
         scores: scores,
         feedback: feedback,
         embedding: embedding,
         embeddingModel: embeddingModel,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Answer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Answer copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    int? questionId,
    Object? question = _Undefined,
    String? transcript,
    Object? answerDuration = _Undefined,
    Object? scores = _Undefined,
    Object? feedback = _Undefined,
    Object? embedding = _Undefined,
    Object? embeddingModel = _Undefined,
    DateTime? createdAt,
  }) {
    return Answer(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      questionId: questionId ?? this.questionId,
      question: question is _i6athr3z.Question?
          ? question
          : this.question?.copyWith(),
      transcript: transcript ?? this.transcript,
      answerDuration: answerDuration is Duration?
          ? answerDuration
          : this.answerDuration,
      scores: scores is _i5tfukg1.InterviewScores?
          ? scores
          : this.scores?.copyWith(),
      feedback: feedback is _ied67bjz.AnswerFeedback?
          ? feedback
          : this.feedback?.copyWith(),
      embedding: embedding is _is.Vector? ? embedding : this.embedding?.clone(),
      embeddingModel: embeddingModel is String?
          ? embeddingModel
          : this.embeddingModel,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AnswerUpdateTable extends _is.UpdateTable<AnswerTable> {
  AnswerUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<int, int> questionId(int value) => _is.ColumnValue(
    table.questionId,
    value,
  );

  _is.ColumnValue<String, String> transcript(String value) => _is.ColumnValue(
    table.transcript,
    value,
  );

  _is.ColumnValue<Duration, Duration> answerDuration(Duration? value) =>
      _is.ColumnValue(
        table.answerDuration,
        value,
      );

  _is.ColumnValue<_i5tfukg1.InterviewScores, _i5tfukg1.InterviewScores> scores(
    _i5tfukg1.InterviewScores? value,
  ) => _is.ColumnValue(
    table.scores,
    value,
  );

  _is.ColumnValue<_ied67bjz.AnswerFeedback, _ied67bjz.AnswerFeedback> feedback(
    _ied67bjz.AnswerFeedback? value,
  ) => _is.ColumnValue(
    table.feedback,
    value,
  );

  _is.ColumnValue<_is.Vector, _is.Vector> embedding(_is.Vector? value) =>
      _is.ColumnValue(
        table.embedding,
        value,
      );

  _is.ColumnValue<String, String> embeddingModel(String? value) =>
      _is.ColumnValue(
        table.embeddingModel,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class AnswerTable extends _is.Table<int?> {
  AnswerTable({super.tableRelation}) : super(tableName: 'answer') {
    updateTable = AnswerUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    questionId = _is.ColumnInt(
      'questionId',
      this,
    );
    transcript = _is.ColumnString(
      'transcript',
      this,
    );
    answerDuration = _is.ColumnDuration(
      'answerDuration',
      this,
    );
    scores = _is.ColumnStructured<_i5tfukg1.InterviewScores>(
      'scores',
      this,
    );
    feedback = _is.ColumnStructured<_ied67bjz.AnswerFeedback>(
      'feedback',
      this,
    );
    embedding = _is.ColumnVector(
      'embedding',
      this,
      dimension: 1024,
    );
    embeddingModel = _is.ColumnString(
      'embeddingModel',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final AnswerUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// Denormalised owner so similarity search filters without joins.
  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnInt questionId;

  _i6athr3z.QuestionTable? _question;

  late final _is.ColumnString transcript;

  late final _is.ColumnDuration answerDuration;

  late final _is.ColumnStructured<_i5tfukg1.InterviewScores> scores;

  late final _is.ColumnStructured<_ied67bjz.AnswerFeedback> feedback;

  /// pgvector embedding (voyage-4 @ 1024 dims). Server-only.
  late final _is.ColumnVector embedding;

  /// Set together with embedding: which model produced it (idempotency check).
  late final _is.ColumnString embeddingModel;

  late final _is.ColumnDateTime createdAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: Answer.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  _i6athr3z.QuestionTable get question {
    if (_question != null) return _question!;
    _question = _is.createRelationTable(
      relationFieldName: 'question',
      field: Answer.t.questionId,
      foreignField: _i6athr3z.Question.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6athr3z.QuestionTable(tableRelation: foreignTableRelation),
    );
    return _question!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    questionId,
    transcript,
    answerDuration,
    scores,
    feedback,
    embedding,
    embeddingModel,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    if (relationField == 'question') {
      return question;
    }
    return null;
  }
}

class AnswerInclude extends _is.IncludeObject {
  AnswerInclude._({
    _iacs.AuthUserInclude? authUser,
    _i6athr3z.QuestionInclude? question,
  }) {
    _authUser = authUser;
    _question = question;
  }

  _iacs.AuthUserInclude? _authUser;

  _i6athr3z.QuestionInclude? _question;

  @override
  Map<String, _is.Include?> get includes => {
    'authUser': _authUser,
    'question': _question,
  };

  @override
  _is.Table<int?> get table => Answer.t;
}

class AnswerIncludeList extends _is.IncludeList {
  AnswerIncludeList._({
    _is.WhereExpressionBuilder<AnswerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Answer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Answer.t;
}

class AnswerRepository {
  const AnswerRepository._();

  final attachRow = const AnswerAttachRowRepository._();

  /// Returns a list of [Answer]s matching the given query parameters.
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
  Future<List<Answer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AnswerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AnswerTable>? orderBy,
    _is.OrderByListBuilder<AnswerTable>? orderByList,
    _is.Transaction? transaction,
    AnswerInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Answer>(
      where: where?.call(Answer.t),
      orderBy: orderBy?.call(Answer.t),
      orderByList: orderByList?.call(Answer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Answer] matching the given query parameters.
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
  Future<Answer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AnswerTable>? where,
    int? offset,
    _is.OrderByBuilder<AnswerTable>? orderBy,
    _is.OrderByListBuilder<AnswerTable>? orderByList,
    _is.Transaction? transaction,
    AnswerInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Answer>(
      where: where?.call(Answer.t),
      orderBy: orderBy?.call(Answer.t),
      orderByList: orderByList?.call(Answer.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Answer] by its [id] or null if no such row exists.
  Future<Answer?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    AnswerInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Answer>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Answer]s in the list and returns the inserted rows.
  ///
  /// The returned [Answer]s will have their `id` fields set.
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
  Future<List<Answer>> insert(
    _is.DatabaseSession session,
    List<Answer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Answer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Answer] and returns the inserted row.
  ///
  /// The returned [Answer] will have its `id` field set.
  Future<Answer> insertRow(
    _is.DatabaseSession session,
    Answer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Answer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Answer]s in the list and returns the resulting rows.
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
  /// The returned [Answer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Answer>> upsert(
    _is.DatabaseSession session,
    List<Answer> rows, {
    required _is.ColumnSelections<AnswerTable> conflictColumns,
    _is.ColumnSelections<AnswerTable>? updateColumns,
    _is.WhereExpressionBuilder<AnswerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Answer>(
      rows,
      conflictColumns: conflictColumns(Answer.t),
      updateColumns: updateColumns?.call(Answer.t),
      updateWhere: updateWhere?.call(Answer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Answer] and returns the resulting row.
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
  /// The returned [Answer] will have its `id` field set.
  Future<Answer?> upsertRow(
    _is.DatabaseSession session,
    Answer row, {
    required _is.ColumnSelections<AnswerTable> conflictColumns,
    _is.ColumnSelections<AnswerTable>? updateColumns,
    _is.WhereExpressionBuilder<AnswerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Answer>(
      row,
      conflictColumns: conflictColumns(Answer.t),
      updateColumns: updateColumns?.call(Answer.t),
      updateWhere: updateWhere?.call(Answer.t),
      transaction: transaction,
    );
  }

  /// Updates all [Answer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Answer>> update(
    _is.DatabaseSession session,
    List<Answer> rows, {
    _is.ColumnSelections<AnswerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Answer>(
      rows,
      columns: columns?.call(Answer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Answer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Answer> updateRow(
    _is.DatabaseSession session,
    Answer row, {
    _is.ColumnSelections<AnswerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Answer>(
      row,
      columns: columns?.call(Answer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Answer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Answer?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AnswerUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Answer>(
      id,
      columnValues: columnValues(Answer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Answer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Answer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AnswerUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AnswerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AnswerTable>? orderBy,
    _is.OrderByListBuilder<AnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Answer>(
      columnValues: columnValues(Answer.t.updateTable),
      where: where(Answer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Answer.t),
      orderByList: orderByList?.call(Answer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Answer]s in the list and returns the deleted rows.
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
  Future<List<Answer>> delete(
    _is.DatabaseSession session,
    List<Answer> rows, {
    _is.OrderByBuilder<AnswerTable>? orderBy,
    _is.OrderByListBuilder<AnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Answer>(
      rows,
      orderBy: orderBy?.call(Answer.t),
      orderByList: orderByList?.call(Answer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Answer].
  Future<Answer> deleteRow(
    _is.DatabaseSession session,
    Answer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Answer>(
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
  Future<List<Answer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AnswerTable> where,
    _is.OrderByBuilder<AnswerTable>? orderBy,
    _is.OrderByListBuilder<AnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Answer>(
      where: where(Answer.t),
      orderBy: orderBy?.call(Answer.t),
      orderByList: orderByList?.call(Answer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AnswerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Answer>(
      where: where?.call(Answer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Answer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AnswerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Answer>(
      where: where(Answer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AnswerAttachRowRepository {
  const AnswerAttachRowRepository._();

  /// Creates a relation between the given [Answer] and [AuthUser]
  /// by setting the [Answer]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    Answer answer,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (answer.id == null) {
      throw ArgumentError.notNull('answer.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $answer = answer.copyWith(authUserId: authUser.id);
    await session.db.updateRow<Answer>(
      $answer,
      columns: [Answer.t.authUserId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Answer] and [Question]
  /// by setting the [Answer]'s foreign key `questionId` to refer to the [Question].
  Future<void> question(
    _is.DatabaseSession session,
    Answer answer,
    _i6athr3z.Question question, {
    _is.Transaction? transaction,
  }) async {
    if (answer.id == null) {
      throw ArgumentError.notNull('answer.id');
    }
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }

    var $answer = answer.copyWith(questionId: question.id);
    await session.db.updateRow<Answer>(
      $answer,
      columns: [Answer.t.questionId],
      transaction: transaction,
    );
  }
}
