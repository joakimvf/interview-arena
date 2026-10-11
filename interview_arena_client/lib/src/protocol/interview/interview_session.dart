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
import 'package:interview_arena_client/src/protocol/protocol.dart' as _i8wnw200;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../interview/interview_report.dart' as _ih9ckeg8;
import '../interview/interview_scores.dart' as _i5tfukg1;
import '../interview/interview_status.dart' as _iu09kb34;
import '../interview/question.dart' as _i6athr3z;
import '../resume/resume.dart' as _ieq3een9;

/// One mock interview run by a signed-in user.
abstract class InterviewSession
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
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
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      resumeId: jsonSerialization['resumeId'] as int?,
      resume: jsonSerialization['resume'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_ieq3een9.Resume>(
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
          : _i8wnw200.Protocol().deserialize<_i5tfukg1.InterviewScores>(
              jsonSerialization['scores'],
            ),
      overallScore: (jsonSerialization['overallScore'] as num?)?.toDouble(),
      questionCount: jsonSerialization['questionCount'] as int?,
      maxQuestions: jsonSerialization['maxQuestions'] as int?,
      summary: jsonSerialization['summary'] as String?,
      report: jsonSerialization['report'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_ih9ckeg8.InterviewReport>(
              jsonSerialization['report'],
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      questions: jsonSerialization['questions'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<List<_i6athr3z.Question>>(
              jsonSerialization['questions'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  _iacc.AuthUser? authUser;

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

  /// Returns a shallow copy of this [InterviewSession]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InterviewSession copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InterviewSessionImpl extends InterviewSession {
  _InterviewSessionImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
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
  @_isc.useResult
  @override
  InterviewSession copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
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
      authUser: authUser is _iacc.AuthUser?
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
