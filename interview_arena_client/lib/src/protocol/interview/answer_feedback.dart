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

/// Structured AI feedback for one answer. Stored as jsonb in Answer.feedback.
abstract class AnswerFeedback
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AnswerFeedback._({
    required this.summary,
    required this.strengths,
    required this.improvements,
  });

  factory AnswerFeedback({
    required String summary,
    required List<String> strengths,
    required List<String> improvements,
  }) = _AnswerFeedbackImpl;

  factory AnswerFeedback.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnswerFeedback(
      summary: jsonSerialization['summary'] as String,
      strengths: _i8wnw200.Protocol().deserialize<List<String>>(
        jsonSerialization['strengths'],
      ),
      improvements: _i8wnw200.Protocol().deserialize<List<String>>(
        jsonSerialization['improvements'],
      ),
    );
  }

  String summary;

  List<String> strengths;

  List<String> improvements;

  /// Returns a shallow copy of this [AnswerFeedback]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AnswerFeedback copyWith({
    String? summary,
    List<String>? strengths,
    List<String>? improvements,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnswerFeedback',
      'summary': summary,
      'strengths': strengths.toJson(),
      'improvements': improvements.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnswerFeedback',
      'summary': summary,
      'strengths': strengths.toJson(),
      'improvements': improvements.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AnswerFeedbackImpl extends AnswerFeedback {
  _AnswerFeedbackImpl({
    required String summary,
    required List<String> strengths,
    required List<String> improvements,
  }) : super._(
         summary: summary,
         strengths: strengths,
         improvements: improvements,
       );

  /// Returns a shallow copy of this [AnswerFeedback]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AnswerFeedback copyWith({
    String? summary,
    List<String>? strengths,
    List<String>? improvements,
  }) {
    return AnswerFeedback(
      summary: summary ?? this.summary,
      strengths: strengths ?? this.strengths.map((e0) => e0).toList(),
      improvements: improvements ?? this.improvements.map((e0) => e0).toList(),
    );
  }
}
