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

/// Partial transcript of the answer being spoken (client-side STT).
abstract class AnswerChunk extends _iototaiw.CandidateInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AnswerChunk._({
    required super.clientSeq,
    required this.questionId,
    required this.textSoFar,
  });

  factory AnswerChunk({
    required int clientSeq,
    required int questionId,
    required String textSoFar,
  }) = _AnswerChunkImpl;

  factory AnswerChunk.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnswerChunk(
      clientSeq: jsonSerialization['clientSeq'] as int,
      questionId: jsonSerialization['questionId'] as int,
      textSoFar: jsonSerialization['textSoFar'] as String,
    );
  }

  int questionId;

  String textSoFar;

  /// Returns a shallow copy of this [AnswerChunk]
  /// with some or all fields replaced by the given arguments.
  @override
  @_is.useResult
  AnswerChunk copyWith({
    int? clientSeq,
    int? questionId,
    String? textSoFar,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnswerChunk',
      'clientSeq': clientSeq,
      'questionId': questionId,
      'textSoFar': textSoFar,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnswerChunk',
      'clientSeq': clientSeq,
      'questionId': questionId,
      'textSoFar': textSoFar,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AnswerChunkImpl extends AnswerChunk {
  _AnswerChunkImpl({
    required int clientSeq,
    required int questionId,
    required String textSoFar,
  }) : super._(
         clientSeq: clientSeq,
         questionId: questionId,
         textSoFar: textSoFar,
       );

  /// Returns a shallow copy of this [AnswerChunk]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AnswerChunk copyWith({
    int? clientSeq,
    int? questionId,
    String? textSoFar,
  }) {
    return AnswerChunk(
      clientSeq: clientSeq ?? this.clientSeq,
      questionId: questionId ?? this.questionId,
      textSoFar: textSoFar ?? this.textSoFar,
    );
  }
}
