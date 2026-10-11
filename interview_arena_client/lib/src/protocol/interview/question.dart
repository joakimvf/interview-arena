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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../interview/answer.dart' as _if3yqgpc;
import '../interview/interview_session.dart' as _iwk4fsrc;
import '../interview/question_category.dart' as _ietck0qu;

/// A question asked during an interview session.
abstract class Question
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _i8wnw200.Protocol().deserialize<_iwk4fsrc.InterviewSession>(
              jsonSerialization['interviewSession'],
            ),
      orderIndex: jsonSerialization['orderIndex'] as int,
      category: _ietck0qu.QuestionCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      prompt: jsonSerialization['prompt'] as String,
      targetSkills: _i8wnw200.Protocol().deserialize<List<String>>(
        jsonSerialization['targetSkills'],
      ),
      isFollowUp: jsonSerialization['isFollowUp'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isFollowUp']),
      askedAt: jsonSerialization['askedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['askedAt']),
      answers: jsonSerialization['answers'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<List<_if3yqgpc.Answer>>(
              jsonSerialization['answers'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
