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

/// Live five scores (partial-answer estimate or post-evaluation aggregate).
abstract class ScoreUpdate extends _iototaiw.InterviewEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ScoreUpdate._({
    required super.interviewSessionId,
    required super.sequence,
    this.questionId,
    bool? isPartial,
    required this.scores,
  }) : isPartial = isPartial ?? false;

  factory ScoreUpdate({
    required int interviewSessionId,
    required int sequence,
    int? questionId,
    bool? isPartial,
    required _ifl1hwc4.InterviewScores scores,
  }) = _ScoreUpdateImpl;

  factory ScoreUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScoreUpdate(
      interviewSessionId: jsonSerialization['interviewSessionId'] as int,
      sequence: jsonSerialization['sequence'] as int,
      questionId: jsonSerialization['questionId'] as int?,
      isPartial: jsonSerialization['isPartial'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isPartial']),
      scores: _iq9nucou.Protocol().deserialize<_ifl1hwc4.InterviewScores>(
        jsonSerialization['scores'],
      ),
    );
  }

  int? questionId;

  bool isPartial;

  _ifl1hwc4.InterviewScores scores;

  /// Returns a shallow copy of this [ScoreUpdate]
  /// with some or all fields replaced by the given arguments.
  @override
  @_is.useResult
  ScoreUpdate copyWith({
    int? interviewSessionId,
    int? sequence,
    int? questionId,
    bool? isPartial,
    _ifl1hwc4.InterviewScores? scores,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScoreUpdate',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      if (questionId != null) 'questionId': questionId,
      'isPartial': isPartial,
      'scores': scores.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScoreUpdate',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      if (questionId != null) 'questionId': questionId,
      'isPartial': isPartial,
      'scores': scores.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ScoreUpdateImpl extends ScoreUpdate {
  _ScoreUpdateImpl({
    required int interviewSessionId,
    required int sequence,
    int? questionId,
    bool? isPartial,
    required _ifl1hwc4.InterviewScores scores,
  }) : super._(
         interviewSessionId: interviewSessionId,
         sequence: sequence,
         questionId: questionId,
         isPartial: isPartial,
         scores: scores,
       );

  /// Returns a shallow copy of this [ScoreUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ScoreUpdate copyWith({
    int? interviewSessionId,
    int? sequence,
    Object? questionId = _Undefined,
    bool? isPartial,
    _ifl1hwc4.InterviewScores? scores,
  }) {
    return ScoreUpdate(
      interviewSessionId: interviewSessionId ?? this.interviewSessionId,
      sequence: sequence ?? this.sequence,
      questionId: questionId is int? ? questionId : this.questionId,
      isPartial: isPartial ?? this.isPartial,
      scores: scores ?? this.scores.copyWith(),
    );
  }
}
