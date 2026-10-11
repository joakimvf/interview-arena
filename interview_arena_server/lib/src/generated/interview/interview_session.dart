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
import '../interview/interview_report.dart' as _ih9ckeg8;
import '../interview/interview_scores.dart' as _i5tfukg1;
import '../interview/interview_status.dart' as _iu09kb34;
import '../interview/question.dart' as _i6athr3z;
import '../resume/resume.dart' as _ieq3een9;

/// One mock interview run by a signed-in user.
abstract class InterviewSession
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  InterviewSession._({
    this.id,
    required this.authUserId,
    this.authUser,
    this.resumeId,
    this.resume,
    required this.targetRole,
    _iu09kb34.InterviewStatus? status,
    this.scores,
    this.overallScore,
    int? questionCount,
    int? maxQuestions,
    this.summary,
    this.report,
    DateTime? startedAt,
    this.endedAt,
    this.questions,
  }) : status = status ?? _iu09kb34.InterviewStatus.pending,
       questionCount = questionCount ?? 0,
       maxQuestions = maxQuestions ?? 6,
       startedAt = startedAt ?? DateTime.now();

  factory InterviewSession({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    int? resumeId,
    _ieq3een9.Resume? resume,
    required String targetRole,
    _iu09kb34.InterviewStatus? status,
    _i5tfukg1.InterviewScores? scores,
    double? overallScore,
    int? questionCount,
    int? maxQuestions,
    String? summary,
    _ih9ckeg8.InterviewReport? report,
    DateTime? startedAt,
    DateTime? endedAt,
    List<_i6athr3z.Question>? questions,
  }) = _InterviewSessionImpl;

  factory InterviewSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return InterviewSession(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      resumeId: jsonSerialization['resumeId'] as int?,
      resume: jsonSerialization['resume'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_ieq3een9.Resume>(
              jsonSerialization['resume'],
            ),
      targetRole: jsonSerialization['targetRole'] as String,
      status: jsonSerialization['status'] == null
          ? null
          : _iu09kb34.InterviewStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      scores: jsonSerialization['scores'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_i5tfukg1.InterviewScores>(
              jsonSerialization['scores'],
            ),
      overallScore: (jsonSerialization['overallScore'] as num?)?.toDouble(),
      questionCount: jsonSerialization['questionCount'] as int?,
      maxQuestions: jsonSerialization['maxQuestions'] as int?,
      summary: jsonSerialization['summary'] as String?,
      report: jsonSerialization['report'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_ih9ckeg8.InterviewReport>(
              jsonSerialization['report'],
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      questions: jsonSerialization['questions'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<List<_i6athr3z.Question>>(
              jsonSerialization['questions'],
            ),
    );
  }

  static final t = InterviewSessionTable();

  static const db = InterviewSessionRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  int? resumeId;

  /// Optional source resume; kept (FK nulled) if the resume is deleted.
  _ieq3een9.Resume? resume;

  String targetRole;

  _iu09kb34.InterviewStatus status;

  /// Latest aggregate live scores.
  _i5tfukg1.InterviewScores? scores;

  double? overallScore;

  int questionCount;

  int maxQuestions;

  String? summary;

  /// Whole-interview feedback; null until the interview is completed.
  _ih9ckeg8.InterviewReport? report;

  DateTime startedAt;

  DateTime? endedAt;

  List<_i6athr3z.Question>? questions;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [InterviewSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InterviewSession copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    int? resumeId,
    _ieq3een9.Resume? resume,
    String? targetRole,
    _iu09kb34.InterviewStatus? status,
    _i5tfukg1.InterviewScores? scores,
    double? overallScore,
    int? questionCount,
    int? maxQuestions,
    String? summary,
    _ih9ckeg8.InterviewReport? report,
    DateTime? startedAt,
    DateTime? endedAt,
    List<_i6athr3z.Question>? questions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InterviewSession',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (resumeId != null) 'resumeId': resumeId,
      if (resume != null) 'resume': resume?.toJson(),
      'targetRole': targetRole,
      'status': status.toJson(),
      if (scores != null) 'scores': scores?.toJson(),
      if (overallScore != null) 'overallScore': overallScore,
      'questionCount': questionCount,
      'maxQuestions': maxQuestions,
      if (summary != null) 'summary': summary,
      if (report != null) 'report': report?.toJson(),
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (questions != null)
        'questions': questions?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InterviewSession',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (resumeId != null) 'resumeId': resumeId,
      if (resume != null) 'resume': resume?.toJsonForProtocol(),
      'targetRole': targetRole,
      'status': status.toJson(),
      if (scores != null) 'scores': scores?.toJsonForProtocol(),
      if (overallScore != null) 'overallScore': overallScore,
      'questionCount': questionCount,
      'maxQuestions': maxQuestions,
      if (summary != null) 'summary': summary,
      if (report != null) 'report': report?.toJsonForProtocol(),
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (questions != null)
        'questions': questions?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static InterviewSessionInclude include({
    _iacs.AuthUserInclude? authUser,
    _ieq3een9.ResumeInclude? resume,
    _i6athr3z.QuestionIncludeList? questions,
  }) {
    return InterviewSessionInclude._(
      authUser: authUser,
      resume: resume,
      questions: questions,
    );
  }

  static InterviewSessionIncludeList includeList({
    _is.WhereExpressionBuilder<InterviewSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InterviewSessionTable>? orderBy,
    _is.OrderByListBuilder<InterviewSessionTable>? orderByList,
    InterviewSessionInclude? include,
  }) {
    return InterviewSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InterviewSession.t),
      orderByList: orderByList?.call(InterviewSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InterviewSessionImpl extends InterviewSession {
  _InterviewSessionImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    int? resumeId,
    _ieq3een9.Resume? resume,
    required String targetRole,
    _iu09kb34.InterviewStatus? status,
    _i5tfukg1.InterviewScores? scores,
    double? overallScore,
    int? questionCount,
    int? maxQuestions,
    String? summary,
    _ih9ckeg8.InterviewReport? report,
    DateTime? startedAt,
    DateTime? endedAt,
    List<_i6athr3z.Question>? questions,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         resumeId: resumeId,
         resume: resume,
         targetRole: targetRole,
         status: status,
         scores: scores,
         overallScore: overallScore,
         questionCount: questionCount,
         maxQuestions: maxQuestions,
         summary: summary,
         report: report,
         startedAt: startedAt,
         endedAt: endedAt,
         questions: questions,
       );

  /// Returns a shallow copy of this [InterviewSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InterviewSession copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Object? resumeId = _Undefined,
    Object? resume = _Undefined,
    String? targetRole,
    _iu09kb34.InterviewStatus? status,
    Object? scores = _Undefined,
    Object? overallScore = _Undefined,
    int? questionCount,
    int? maxQuestions,
    Object? summary = _Undefined,
    Object? report = _Undefined,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
    Object? questions = _Undefined,
  }) {
    return InterviewSession(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      resumeId: resumeId is int? ? resumeId : this.resumeId,
      resume: resume is _ieq3een9.Resume? ? resume : this.resume?.copyWith(),
      targetRole: targetRole ?? this.targetRole,
      status: status ?? this.status,
      scores: scores is _i5tfukg1.InterviewScores?
          ? scores
          : this.scores?.copyWith(),
      overallScore: overallScore is double? ? overallScore : this.overallScore,
      questionCount: questionCount ?? this.questionCount,
      maxQuestions: maxQuestions ?? this.maxQuestions,
      summary: summary is String? ? summary : this.summary,
      report: report is _ih9ckeg8.InterviewReport?
          ? report
          : this.report?.copyWith(),
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      questions: questions is List<_i6athr3z.Question>?
          ? questions
          : this.questions?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class InterviewSessionUpdateTable
    extends _is.UpdateTable<InterviewSessionTable> {
  InterviewSessionUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<int, int> resumeId(int? value) => _is.ColumnValue(
    table.resumeId,
    value,
  );

  _is.ColumnValue<String, String> targetRole(String value) => _is.ColumnValue(
    table.targetRole,
    value,
  );

  _is.ColumnValue<_iu09kb34.InterviewStatus, _iu09kb34.InterviewStatus> status(
    _iu09kb34.InterviewStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_i5tfukg1.InterviewScores, _i5tfukg1.InterviewScores> scores(
    _i5tfukg1.InterviewScores? value,
  ) => _is.ColumnValue(
    table.scores,
    value,
  );

  _is.ColumnValue<double, double> overallScore(double? value) =>
      _is.ColumnValue(
        table.overallScore,
        value,
      );

  _is.ColumnValue<int, int> questionCount(int value) => _is.ColumnValue(
    table.questionCount,
    value,
  );

  _is.ColumnValue<int, int> maxQuestions(int value) => _is.ColumnValue(
    table.maxQuestions,
    value,
  );

  _is.ColumnValue<String, String> summary(String? value) => _is.ColumnValue(
    table.summary,
    value,
  );

  _is.ColumnValue<_ih9ckeg8.InterviewReport, _ih9ckeg8.InterviewReport> report(
    _ih9ckeg8.InterviewReport? value,
  ) => _is.ColumnValue(
    table.report,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endedAt(DateTime? value) =>
      _is.ColumnValue(
        table.endedAt,
        value,
      );
}

class InterviewSessionTable extends _is.Table<int?> {
  InterviewSessionTable({super.tableRelation})
    : super(tableName: 'interview_session') {
    updateTable = InterviewSessionUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    resumeId = _is.ColumnInt(
      'resumeId',
      this,
    );
    targetRole = _is.ColumnString(
      'targetRole',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    scores = _is.ColumnStructured<_i5tfukg1.InterviewScores>(
      'scores',
      this,
    );
    overallScore = _is.ColumnDouble(
      'overallScore',
      this,
    );
    questionCount = _is.ColumnInt(
      'questionCount',
      this,
      hasDefault: true,
    );
    maxQuestions = _is.ColumnInt(
      'maxQuestions',
      this,
      hasDefault: true,
    );
    summary = _is.ColumnString(
      'summary',
      this,
    );
    report = _is.ColumnStructured<_ih9ckeg8.InterviewReport>(
      'report',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
      hasDefault: true,
    );
    endedAt = _is.ColumnDateTime(
      'endedAt',
      this,
    );
  }

  late final InterviewSessionUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnInt resumeId;

  /// Optional source resume; kept (FK nulled) if the resume is deleted.
  _ieq3een9.ResumeTable? _resume;

  late final _is.ColumnString targetRole;

  late final _is.ColumnEnum<_iu09kb34.InterviewStatus> status;

  /// Latest aggregate live scores.
  late final _is.ColumnStructured<_i5tfukg1.InterviewScores> scores;

  late final _is.ColumnDouble overallScore;

  late final _is.ColumnInt questionCount;

  late final _is.ColumnInt maxQuestions;

  late final _is.ColumnString summary;

  /// Whole-interview feedback; null until the interview is completed.
  late final _is.ColumnStructured<_ih9ckeg8.InterviewReport> report;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime endedAt;

  _i6athr3z.QuestionTable? ___questions;

  _is.ManyRelation<_i6athr3z.QuestionTable>? _questions;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: InterviewSession.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  _ieq3een9.ResumeTable get resume {
    if (_resume != null) return _resume!;
    _resume = _is.createRelationTable(
      relationFieldName: 'resume',
      field: InterviewSession.t.resumeId,
      foreignField: _ieq3een9.Resume.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ieq3een9.ResumeTable(tableRelation: foreignTableRelation),
    );
    return _resume!;
  }

  _i6athr3z.QuestionTable get __questions {
    if (___questions != null) return ___questions!;
    ___questions = _is.createRelationTable(
      relationFieldName: '__questions',
      field: InterviewSession.t.id,
      foreignField: _i6athr3z.Question.t.interviewSessionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6athr3z.QuestionTable(tableRelation: foreignTableRelation),
    );
    return ___questions!;
  }

  _is.ManyRelation<_i6athr3z.QuestionTable> get questions {
    if (_questions != null) return _questions!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'questions',
      field: InterviewSession.t.id,
      foreignField: _i6athr3z.Question.t.interviewSessionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6athr3z.QuestionTable(tableRelation: foreignTableRelation),
    );
    _questions = _is.ManyRelation<_i6athr3z.QuestionTable>(
      tableWithRelations: relationTable,
      table: _i6athr3z.QuestionTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _questions!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    resumeId,
    targetRole,
    status,
    scores,
    overallScore,
    questionCount,
    maxQuestions,
    summary,
    report,
    startedAt,
    endedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    if (relationField == 'resume') {
      return resume;
    }
    if (relationField == 'questions') {
      return __questions;
    }
    return null;
  }
}

class InterviewSessionInclude extends _is.IncludeObject {
  InterviewSessionInclude._({
    _iacs.AuthUserInclude? authUser,
    _ieq3een9.ResumeInclude? resume,
    _i6athr3z.QuestionIncludeList? questions,
  }) {
    _authUser = authUser;
    _resume = resume;
    _questions = questions;
  }

  _iacs.AuthUserInclude? _authUser;

  _ieq3een9.ResumeInclude? _resume;

  _i6athr3z.QuestionIncludeList? _questions;

  @override
  Map<String, _is.Include?> get includes => {
    'authUser': _authUser,
    'resume': _resume,
    'questions': _questions,
  };

  @override
  _is.Table<int?> get table => InterviewSession.t;
}

class InterviewSessionIncludeList extends _is.IncludeList {
  InterviewSessionIncludeList._({
    _is.WhereExpressionBuilder<InterviewSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InterviewSession.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => InterviewSession.t;
}

class InterviewSessionRepository {
  const InterviewSessionRepository._();

  final attach = const InterviewSessionAttachRepository._();

  final attachRow = const InterviewSessionAttachRowRepository._();

  final detachRow = const InterviewSessionDetachRowRepository._();

  /// Returns a list of [InterviewSession]s matching the given query parameters.
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
  Future<List<InterviewSession>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InterviewSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InterviewSessionTable>? orderBy,
    _is.OrderByListBuilder<InterviewSessionTable>? orderByList,
    _is.Transaction? transaction,
    InterviewSessionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InterviewSession>(
      where: where?.call(InterviewSession.t),
      orderBy: orderBy?.call(InterviewSession.t),
      orderByList: orderByList?.call(InterviewSession.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InterviewSession] matching the given query parameters.
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
  Future<InterviewSession?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InterviewSessionTable>? where,
    int? offset,
    _is.OrderByBuilder<InterviewSessionTable>? orderBy,
    _is.OrderByListBuilder<InterviewSessionTable>? orderByList,
    _is.Transaction? transaction,
    InterviewSessionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InterviewSession>(
      where: where?.call(InterviewSession.t),
      orderBy: orderBy?.call(InterviewSession.t),
      orderByList: orderByList?.call(InterviewSession.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InterviewSession] by its [id] or null if no such row exists.
  Future<InterviewSession?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    InterviewSessionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InterviewSession>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InterviewSession]s in the list and returns the inserted rows.
  ///
  /// The returned [InterviewSession]s will have their `id` fields set.
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
  Future<List<InterviewSession>> insert(
    _is.DatabaseSession session,
    List<InterviewSession> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<InterviewSession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [InterviewSession] and returns the inserted row.
  ///
  /// The returned [InterviewSession] will have its `id` field set.
  Future<InterviewSession> insertRow(
    _is.DatabaseSession session,
    InterviewSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<InterviewSession>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [InterviewSession]s in the list and returns the resulting rows.
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
  /// The returned [InterviewSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InterviewSession>> upsert(
    _is.DatabaseSession session,
    List<InterviewSession> rows, {
    required _is.ColumnSelections<InterviewSessionTable> conflictColumns,
    _is.ColumnSelections<InterviewSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<InterviewSessionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<InterviewSession>(
      rows,
      conflictColumns: conflictColumns(InterviewSession.t),
      updateColumns: updateColumns?.call(InterviewSession.t),
      updateWhere: updateWhere?.call(InterviewSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [InterviewSession] and returns the resulting row.
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
  /// The returned [InterviewSession] will have its `id` field set.
  Future<InterviewSession?> upsertRow(
    _is.DatabaseSession session,
    InterviewSession row, {
    required _is.ColumnSelections<InterviewSessionTable> conflictColumns,
    _is.ColumnSelections<InterviewSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<InterviewSessionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<InterviewSession>(
      row,
      conflictColumns: conflictColumns(InterviewSession.t),
      updateColumns: updateColumns?.call(InterviewSession.t),
      updateWhere: updateWhere?.call(InterviewSession.t),
      transaction: transaction,
    );
  }

  /// Updates all [InterviewSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InterviewSession>> update(
    _is.DatabaseSession session,
    List<InterviewSession> rows, {
    _is.ColumnSelections<InterviewSessionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<InterviewSession>(
      rows,
      columns: columns?.call(InterviewSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [InterviewSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InterviewSession> updateRow(
    _is.DatabaseSession session,
    InterviewSession row, {
    _is.ColumnSelections<InterviewSessionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<InterviewSession>(
      row,
      columns: columns?.call(InterviewSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InterviewSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InterviewSession?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InterviewSessionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<InterviewSession>(
      id,
      columnValues: columnValues(InterviewSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InterviewSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InterviewSession>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InterviewSessionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<InterviewSessionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InterviewSessionTable>? orderBy,
    _is.OrderByListBuilder<InterviewSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<InterviewSession>(
      columnValues: columnValues(InterviewSession.t.updateTable),
      where: where(InterviewSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InterviewSession.t),
      orderByList: orderByList?.call(InterviewSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [InterviewSession]s in the list and returns the deleted rows.
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
  Future<List<InterviewSession>> delete(
    _is.DatabaseSession session,
    List<InterviewSession> rows, {
    _is.OrderByBuilder<InterviewSessionTable>? orderBy,
    _is.OrderByListBuilder<InterviewSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<InterviewSession>(
      rows,
      orderBy: orderBy?.call(InterviewSession.t),
      orderByList: orderByList?.call(InterviewSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [InterviewSession].
  Future<InterviewSession> deleteRow(
    _is.DatabaseSession session,
    InterviewSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InterviewSession>(
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
  Future<List<InterviewSession>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InterviewSessionTable> where,
    _is.OrderByBuilder<InterviewSessionTable>? orderBy,
    _is.OrderByListBuilder<InterviewSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<InterviewSession>(
      where: where(InterviewSession.t),
      orderBy: orderBy?.call(InterviewSession.t),
      orderByList: orderByList?.call(InterviewSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InterviewSessionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<InterviewSession>(
      where: where?.call(InterviewSession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InterviewSession] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InterviewSessionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InterviewSession>(
      where: where(InterviewSession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class InterviewSessionAttachRepository {
  const InterviewSessionAttachRepository._();

  /// Creates a relation between this [InterviewSession] and the given [Question]s
  /// by setting each [Question]'s foreign key `interviewSessionId` to refer to this [InterviewSession].
  Future<void> questions(
    _is.DatabaseSession session,
    InterviewSession interviewSession,
    List<_i6athr3z.Question> question, {
    _is.Transaction? transaction,
  }) async {
    if (question.any((e) => e.id == null)) {
      throw ArgumentError.notNull('question.id');
    }
    if (interviewSession.id == null) {
      throw ArgumentError.notNull('interviewSession.id');
    }

    var $question = question
        .map((e) => e.copyWith(interviewSessionId: interviewSession.id))
        .toList();
    await session.db.update<_i6athr3z.Question>(
      $question,
      columns: [_i6athr3z.Question.t.interviewSessionId],
      transaction: transaction,
    );
  }
}

class InterviewSessionAttachRowRepository {
  const InterviewSessionAttachRowRepository._();

  /// Creates a relation between the given [InterviewSession] and [AuthUser]
  /// by setting the [InterviewSession]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    InterviewSession interviewSession,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (interviewSession.id == null) {
      throw ArgumentError.notNull('interviewSession.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $interviewSession = interviewSession.copyWith(authUserId: authUser.id);
    await session.db.updateRow<InterviewSession>(
      $interviewSession,
      columns: [InterviewSession.t.authUserId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [InterviewSession] and [Resume]
  /// by setting the [InterviewSession]'s foreign key `resumeId` to refer to the [Resume].
  Future<void> resume(
    _is.DatabaseSession session,
    InterviewSession interviewSession,
    _ieq3een9.Resume resume, {
    _is.Transaction? transaction,
  }) async {
    if (interviewSession.id == null) {
      throw ArgumentError.notNull('interviewSession.id');
    }
    if (resume.id == null) {
      throw ArgumentError.notNull('resume.id');
    }

    var $interviewSession = interviewSession.copyWith(resumeId: resume.id);
    await session.db.updateRow<InterviewSession>(
      $interviewSession,
      columns: [InterviewSession.t.resumeId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [InterviewSession] and the given [Question]
  /// by setting the [Question]'s foreign key `interviewSessionId` to refer to this [InterviewSession].
  Future<void> questions(
    _is.DatabaseSession session,
    InterviewSession interviewSession,
    _i6athr3z.Question question, {
    _is.Transaction? transaction,
  }) async {
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }
    if (interviewSession.id == null) {
      throw ArgumentError.notNull('interviewSession.id');
    }

    var $question = question.copyWith(interviewSessionId: interviewSession.id);
    await session.db.updateRow<_i6athr3z.Question>(
      $question,
      columns: [_i6athr3z.Question.t.interviewSessionId],
      transaction: transaction,
    );
  }
}

class InterviewSessionDetachRowRepository {
  const InterviewSessionDetachRowRepository._();

  /// Detaches the relation between this [InterviewSession] and the [Resume] set in `resume`
  /// by setting the [InterviewSession]'s foreign key `resumeId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resume(
    _is.DatabaseSession session,
    InterviewSession interviewSession, {
    _is.Transaction? transaction,
  }) async {
    if (interviewSession.id == null) {
      throw ArgumentError.notNull('interviewSession.id');
    }

    var $interviewSession = interviewSession.copyWith(resumeId: null);
    await session.db.updateRow<InterviewSession>(
      $interviewSession,
      columns: [InterviewSession.t.resumeId],
      transaction: transaction,
    );
  }
}
