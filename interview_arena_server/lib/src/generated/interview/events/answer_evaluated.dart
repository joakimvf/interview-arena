/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

part of 'interview_event.dart';

abstract class AnswerEvaluated extends _iototaiw.InterviewEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AnswerEvaluated._({
    required super.interviewSessionId,
    required super.sequence,
    required this.questionId,
    required this.answerId,
    required this.scores,
    required this.feedback,
  });

  factory AnswerEvaluated({
    required int interviewSessionId,
    required int sequence,
    required int questionId,
    required int answerId,
    required _ifl1hwc4.InterviewScores scores,
    required _i8jmf1yf.AnswerFeedback feedback,
  }) = _AnswerEvaluatedImpl;

  factory AnswerEvaluated.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnswerEvaluated(
      interviewSessionId: jsonSerialization['interviewSessionId'] as int,
      sequence: jsonSerialization['sequence'] as int,
      questionId: jsonSerialization['questionId'] as int,
      answerId: jsonSerialization['answerId'] as int,
      scores: _iq9nucou.Protocol().deserialize<_ifl1hwc4.InterviewScores>(
        jsonSerialization['scores'],
      ),
      feedback: _iq9nucou.Protocol().deserialize<_i8jmf1yf.AnswerFeedback>(
        jsonSerialization['feedback'],
      ),
    );
  }

  int questionId;

  int answerId;

  _ifl1hwc4.InterviewScores scores;

  _i8jmf1yf.AnswerFeedback feedback;

  /// Returns a shallow copy of this [AnswerEvaluated]
  /// with some or all fields replaced by the given arguments.
  @override
  @_is.useResult
  AnswerEvaluated copyWith({
    int? interviewSessionId,
    int? sequence,
    int? questionId,
    int? answerId,
    _ifl1hwc4.InterviewScores? scores,
    _i8jmf1yf.AnswerFeedback? feedback,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnswerEvaluated',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      'questionId': questionId,
      'answerId': answerId,
      'scores': scores.toJson(),
      'feedback': feedback.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnswerEvaluated',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      'questionId': questionId,
      'answerId': answerId,
      'scores': scores.toJsonForProtocol(),
      'feedback': feedback.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AnswerEvaluatedImpl extends AnswerEvaluated {
  _AnswerEvaluatedImpl({
    required int interviewSessionId,
    required int sequence,
    required int questionId,
    required int answerId,
    required _ifl1hwc4.InterviewScores scores,
    required _i8jmf1yf.AnswerFeedback feedback,
  }) : super._(
         interviewSessionId: interviewSessionId,
         sequence: sequence,
         questionId: questionId,
         answerId: answerId,
         scores: scores,
         feedback: feedback,
       );

  /// Returns a shallow copy of this [AnswerEvaluated]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AnswerEvaluated copyWith({
    int? interviewSessionId,
    int? sequence,
    int? questionId,
    int? answerId,
    _ifl1hwc4.InterviewScores? scores,
    _i8jmf1yf.AnswerFeedback? feedback,
  }) {
    return AnswerEvaluated(
      interviewSessionId: interviewSessionId ?? this.interviewSessionId,
      sequence: sequence ?? this.sequence,
      questionId: questionId ?? this.questionId,
      answerId: answerId ?? this.answerId,
      scores: scores ?? this.scores.copyWith(),
      feedback: feedback ?? this.feedback.copyWith(),
    );
  }
}
