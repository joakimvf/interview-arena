/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

part of 'candidate_input.dart';

abstract class AnswerSubmitted extends _iototaiw.CandidateInput
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AnswerSubmitted._({
    required super.clientSeq,
    required this.questionId,
    required this.transcript,
    this.answerDuration,
  });

  factory AnswerSubmitted({
    required int clientSeq,
    required int questionId,
    required String transcript,
    Duration? answerDuration,
  }) = _AnswerSubmittedImpl;

  factory AnswerSubmitted.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnswerSubmitted(
      clientSeq: jsonSerialization['clientSeq'] as int,
      questionId: jsonSerialization['questionId'] as int,
      transcript: jsonSerialization['transcript'] as String,
      answerDuration: jsonSerialization['answerDuration'] == null
          ? null
          : _isc.DurationJsonExtension.fromJson(
              jsonSerialization['answerDuration'],
            ),
    );
  }

  int questionId;

  String transcript;

  Duration? answerDuration;

  /// Returns a shallow copy of this [AnswerSubmitted]
  /// with some or all fields replaced by the given arguments.
  @override
  @_isc.useResult
  AnswerSubmitted copyWith({
    int? clientSeq,
    int? questionId,
    String? transcript,
    Duration? answerDuration,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnswerSubmitted',
      'clientSeq': clientSeq,
      'questionId': questionId,
      'transcript': transcript,
      if (answerDuration != null) 'answerDuration': answerDuration?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnswerSubmitted',
      'clientSeq': clientSeq,
      'questionId': questionId,
      'transcript': transcript,
      if (answerDuration != null) 'answerDuration': answerDuration?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AnswerSubmittedImpl extends AnswerSubmitted {
  _AnswerSubmittedImpl({
    required int clientSeq,
    required int questionId,
    required String transcript,
    Duration? answerDuration,
  }) : super._(
         clientSeq: clientSeq,
         questionId: questionId,
         transcript: transcript,
         answerDuration: answerDuration,
       );

  /// Returns a shallow copy of this [AnswerSubmitted]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AnswerSubmitted copyWith({
    int? clientSeq,
    int? questionId,
    String? transcript,
    Object? answerDuration = _Undefined,
  }) {
    return AnswerSubmitted(
      clientSeq: clientSeq ?? this.clientSeq,
      questionId: questionId ?? this.questionId,
      transcript: transcript ?? this.transcript,
      answerDuration: answerDuration is Duration?
          ? answerDuration
          : this.answerDuration,
    );
  }
}
