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

abstract class InterviewFinished extends _iototaiw.InterviewEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  InterviewFinished._({
    required super.interviewSessionId,
    required super.sequence,
    this.overallScore,
    this.scores,
    required this.summary,
    this.report,
  });

  factory InterviewFinished({
    required int interviewSessionId,
    required int sequence,
    double? overallScore,
    _ifl1hwc4.InterviewScores? scores,
    required String summary,
    _id2icacn.InterviewReport? report,
  }) = _InterviewFinishedImpl;

  factory InterviewFinished.fromJson(Map<String, dynamic> jsonSerialization) {
    return InterviewFinished(
      interviewSessionId: jsonSerialization['interviewSessionId'] as int,
      sequence: jsonSerialization['sequence'] as int,
      overallScore: (jsonSerialization['overallScore'] as num?)?.toDouble(),
      scores: jsonSerialization['scores'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_ifl1hwc4.InterviewScores>(
              jsonSerialization['scores'],
            ),
      summary: jsonSerialization['summary'] as String,
      report: jsonSerialization['report'] == null
          ? null
          : _iq9nucou.Protocol().deserialize<_id2icacn.InterviewReport>(
              jsonSerialization['report'],
            ),
    );
  }

  /// Null when no answer could be evaluated (e.g. the AI was unavailable).
  double? overallScore;

  _ifl1hwc4.InterviewScores? scores;

  String summary;

  _id2icacn.InterviewReport? report;

  /// Returns a shallow copy of this [InterviewFinished]
  /// with some or all fields replaced by the given arguments.
  @override
  @_is.useResult
  InterviewFinished copyWith({
    int? interviewSessionId,
    int? sequence,
    double? overallScore,
    _ifl1hwc4.InterviewScores? scores,
    String? summary,
    _id2icacn.InterviewReport? report,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InterviewFinished',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      if (overallScore != null) 'overallScore': overallScore,
      if (scores != null) 'scores': scores?.toJson(),
      'summary': summary,
      if (report != null) 'report': report?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InterviewFinished',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      if (overallScore != null) 'overallScore': overallScore,
      if (scores != null) 'scores': scores?.toJsonForProtocol(),
      'summary': summary,
      if (report != null) 'report': report?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _InterviewFinishedImpl extends InterviewFinished {
  _InterviewFinishedImpl({
    required int interviewSessionId,
    required int sequence,
    double? overallScore,
    _ifl1hwc4.InterviewScores? scores,
    required String summary,
    _id2icacn.InterviewReport? report,
  }) : super._(
         interviewSessionId: interviewSessionId,
         sequence: sequence,
         overallScore: overallScore,
         scores: scores,
         summary: summary,
         report: report,
       );

  /// Returns a shallow copy of this [InterviewFinished]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InterviewFinished copyWith({
    int? interviewSessionId,
    int? sequence,
    Object? overallScore = _Undefined,
    Object? scores = _Undefined,
    String? summary,
    Object? report = _Undefined,
  }) {
    return InterviewFinished(
      interviewSessionId: interviewSessionId ?? this.interviewSessionId,
      sequence: sequence ?? this.sequence,
      overallScore: overallScore is double? ? overallScore : this.overallScore,
      scores: scores is _ifl1hwc4.InterviewScores?
          ? scores
          : this.scores?.copyWith(),
      summary: summary ?? this.summary,
      report: report is _id2icacn.InterviewReport?
          ? report
          : this.report?.copyWith(),
    );
  }
}
