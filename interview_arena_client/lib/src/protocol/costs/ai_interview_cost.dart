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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// AI spend of one interview (questions, scoring, report and voice).
abstract class AiInterviewCost
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AiInterviewCost._({
    required this.interviewSessionId,
    this.targetRole,
    this.startedAt,
    required this.calls,
    required this.costUsd,
  });

  factory AiInterviewCost({
    required int interviewSessionId,
    String? targetRole,
    DateTime? startedAt,
    required int calls,
    required double costUsd,
  }) = _AiInterviewCostImpl;

  factory AiInterviewCost.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiInterviewCost(
      interviewSessionId: jsonSerialization['interviewSessionId'] as int,
      targetRole: jsonSerialization['targetRole'] as String?,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      calls: jsonSerialization['calls'] as int,
      costUsd: (jsonSerialization['costUsd'] as num).toDouble(),
    );
  }

  int interviewSessionId;

  /// Null when the interview has been deleted.
  String? targetRole;

  DateTime? startedAt;

  int calls;

  double costUsd;

  /// Returns a shallow copy of this [AiInterviewCost]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AiInterviewCost copyWith({
    int? interviewSessionId,
    String? targetRole,
    DateTime? startedAt,
    int? calls,
    double? costUsd,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiInterviewCost',
      'interviewSessionId': interviewSessionId,
      if (targetRole != null) 'targetRole': targetRole,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      'calls': calls,
      'costUsd': costUsd,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiInterviewCost',
      'interviewSessionId': interviewSessionId,
      if (targetRole != null) 'targetRole': targetRole,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      'calls': calls,
      'costUsd': costUsd,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiInterviewCostImpl extends AiInterviewCost {
  _AiInterviewCostImpl({
    required int interviewSessionId,
    String? targetRole,
    DateTime? startedAt,
    required int calls,
    required double costUsd,
  }) : super._(
         interviewSessionId: interviewSessionId,
         targetRole: targetRole,
         startedAt: startedAt,
         calls: calls,
         costUsd: costUsd,
       );

  /// Returns a shallow copy of this [AiInterviewCost]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AiInterviewCost copyWith({
    int? interviewSessionId,
    Object? targetRole = _Undefined,
    Object? startedAt = _Undefined,
    int? calls,
    double? costUsd,
  }) {
    return AiInterviewCost(
      interviewSessionId: interviewSessionId ?? this.interviewSessionId,
      targetRole: targetRole is String? ? targetRole : this.targetRole,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      calls: calls ?? this.calls,
      costUsd: costUsd ?? this.costUsd,
    );
  }
}
