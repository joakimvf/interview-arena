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
import 'package:interview_arena_server/src/generated/protocol.dart'
    as _iq9nucou;
import 'package:serverpod/serverpod.dart' as _is;

/// Whole-interview feedback, written once the interview ends.
abstract class InterviewReport
    implements _is.SerializableModel, _is.ProtocolSerialization {
  InterviewReport._({
    required this.summary,
    required this.strengths,
    required this.improvements,
    required this.focusAreas,
  });

  factory InterviewReport({
    required String summary,
    required List<String> strengths,
    required List<String> improvements,
    required List<String> focusAreas,
  }) = _InterviewReportImpl;

  factory InterviewReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return InterviewReport(
      summary: jsonSerialization['summary'] as String,
      strengths: _iq9nucou.Protocol().deserialize<List<String>>(
        jsonSerialization['strengths'],
      ),
      improvements: _iq9nucou.Protocol().deserialize<List<String>>(
        jsonSerialization['improvements'],
      ),
      focusAreas: _iq9nucou.Protocol().deserialize<List<String>>(
        jsonSerialization['focusAreas'],
      ),
    );
  }

  /// Overall impression in a few sentences.
  String summary;

  List<String> strengths;

  List<String> improvements;

  /// Short topic names to study next, e.g. "Database sharding".
  List<String> focusAreas;

  /// Returns a shallow copy of this [InterviewReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InterviewReport copyWith({
    String? summary,
    List<String>? strengths,
    List<String>? improvements,
    List<String>? focusAreas,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InterviewReport',
      'summary': summary,
      'strengths': strengths.toJson(),
      'improvements': improvements.toJson(),
      'focusAreas': focusAreas.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InterviewReport',
      'summary': summary,
      'strengths': strengths.toJson(),
      'improvements': improvements.toJson(),
      'focusAreas': focusAreas.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _InterviewReportImpl extends InterviewReport {
  _InterviewReportImpl({
    required String summary,
    required List<String> strengths,
    required List<String> improvements,
    required List<String> focusAreas,
  }) : super._(
         summary: summary,
         strengths: strengths,
         improvements: improvements,
         focusAreas: focusAreas,
       );

  /// Returns a shallow copy of this [InterviewReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InterviewReport copyWith({
    String? summary,
    List<String>? strengths,
    List<String>? improvements,
    List<String>? focusAreas,
  }) {
    return InterviewReport(
      summary: summary ?? this.summary,
      strengths: strengths ?? this.strengths.map((e0) => e0).toList(),
      improvements: improvements ?? this.improvements.map((e0) => e0).toList(),
      focusAreas: focusAreas ?? this.focusAreas.map((e0) => e0).toList(),
    );
  }
}
