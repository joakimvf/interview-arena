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
import '../interview/answer_feedback.dart' as _ied67bjz;
import '../interview/interview_scores.dart' as _i5tfukg1;
import '../interview/question.dart' as _i6athr3z;

/// A candidate answer.
abstract class Answer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Answer._({
    this.id,
    required this.questionId,
    this.question,
    required this.transcript,
    this.answerDuration,
    this.scores,
    this.feedback,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Answer({
    int? id,
    required int questionId,
    _i6athr3z.Question? question,
    required String transcript,
    Duration? answerDuration,
    _i5tfukg1.InterviewScores? scores,
    _ied67bjz.AnswerFeedback? feedback,
    DateTime? createdAt,
  }) = _AnswerImpl;

  factory Answer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Answer(
      id: jsonSerialization['id'] as int?,
      questionId: jsonSerialization['questionId'] as int,
      question: jsonSerialization['question'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_i6athr3z.Question>(
              jsonSerialization['question'],
            ),
      transcript: jsonSerialization['transcript'] as String,
      answerDuration: jsonSerialization['answerDuration'] == null
          ? null
          : _isc.DurationJsonExtension.fromJson(
              jsonSerialization['answerDuration'],
            ),
      scores: jsonSerialization['scores'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_i5tfukg1.InterviewScores>(
              jsonSerialization['scores'],
            ),
      feedback: jsonSerialization['feedback'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_ied67bjz.AnswerFeedback>(
              jsonSerialization['feedback'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int questionId;

  _i6athr3z.Question? question;

  String transcript;

  Duration? answerDuration;

  _i5tfukg1.InterviewScores? scores;

  _ied67bjz.AnswerFeedback? feedback;

  DateTime createdAt;

  /// Returns a shallow copy of this [Answer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Answer copyWith({
    int? id,
    int? questionId,
    _i6athr3z.Question? question,
    String? transcript,
    Duration? answerDuration,
    _i5tfukg1.InterviewScores? scores,
    _ied67bjz.AnswerFeedback? feedback,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Answer',
      if (id != null) 'id': id,
      'questionId': questionId,
      if (question != null) 'question': question?.toJson(),
      'transcript': transcript,
      if (answerDuration != null) 'answerDuration': answerDuration?.toJson(),
      if (scores != null) 'scores': scores?.toJson(),
      if (feedback != null) 'feedback': feedback?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Answer',
      if (id != null) 'id': id,
      'questionId': questionId,
      if (question != null) 'question': question?.toJsonForProtocol(),
      'transcript': transcript,
      if (answerDuration != null) 'answerDuration': answerDuration?.toJson(),
      if (scores != null) 'scores': scores?.toJsonForProtocol(),
      if (feedback != null) 'feedback': feedback?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnswerImpl extends Answer {
  _AnswerImpl({
    int? id,
    required int questionId,
    _i6athr3z.Question? question,
    required String transcript,
    Duration? answerDuration,
    _i5tfukg1.InterviewScores? scores,
    _ied67bjz.AnswerFeedback? feedback,
    DateTime? createdAt,
  }) : super._(
         id: id,
         questionId: questionId,
         question: question,
         transcript: transcript,
         answerDuration: answerDuration,
         scores: scores,
         feedback: feedback,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Answer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Answer copyWith({
    Object? id = _Undefined,
    int? questionId,
    Object? question = _Undefined,
    String? transcript,
    Object? answerDuration = _Undefined,
    Object? scores = _Undefined,
    Object? feedback = _Undefined,
    DateTime? createdAt,
  }) {
    return Answer(
      id: id is int? ? id : this.id,
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
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
