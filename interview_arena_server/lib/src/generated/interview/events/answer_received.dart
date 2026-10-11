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

/// Ack: the answer is persisted (sent before slow evaluation starts).
abstract class AnswerReceived extends _iototaiw.InterviewEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AnswerReceived._({
    required super.interviewSessionId,
    required super.sequence,
    required this.questionId,
    required this.answerId,
  });

  factory AnswerReceived({
    required int interviewSessionId,
    required int sequence,
    required int questionId,
    required int answerId,
  }) = _AnswerReceivedImpl;

  factory AnswerReceived.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnswerReceived(
      interviewSessionId: jsonSerialization['interviewSessionId'] as int,
      sequence: jsonSerialization['sequence'] as int,
      questionId: jsonSerialization['questionId'] as int,
      answerId: jsonSerialization['answerId'] as int,
    );
  }

  int questionId;

  int answerId;

  /// Returns a shallow copy of this [AnswerReceived]
  /// with some or all fields replaced by the given arguments.
  @override
  @_is.useResult
  AnswerReceived copyWith({
    int? interviewSessionId,
    int? sequence,
    int? questionId,
    int? answerId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnswerReceived',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      'questionId': questionId,
      'answerId': answerId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnswerReceived',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      'questionId': questionId,
      'answerId': answerId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AnswerReceivedImpl extends AnswerReceived {
  _AnswerReceivedImpl({
    required int interviewSessionId,
    required int sequence,
    required int questionId,
    required int answerId,
  }) : super._(
         interviewSessionId: interviewSessionId,
         sequence: sequence,
         questionId: questionId,
         answerId: answerId,
       );

  /// Returns a shallow copy of this [AnswerReceived]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AnswerReceived copyWith({
    int? interviewSessionId,
    int? sequence,
    int? questionId,
    int? answerId,
  }) {
    return AnswerReceived(
      interviewSessionId: interviewSessionId ?? this.interviewSessionId,
      sequence: sequence ?? this.sequence,
      questionId: questionId ?? this.questionId,
      answerId: answerId ?? this.answerId,
    );
  }
}
