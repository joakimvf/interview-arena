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
import '../costs/ai_cost_line.dart' as _izo77p7o;
import '../costs/ai_interview_cost.dart' as _iqw4ww4b;

/// What the app spent on AI in a time window, for the team's cost screen.
abstract class AiCostSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AiCostSummary._({
    this.since,
    required this.total,
    required this.byFeature,
    required this.byModel,
    required this.byDay,
    required this.interviewCount,
    required this.averagePerInterviewUsd,
    required this.recentInterviews,
  });

  factory AiCostSummary({
    DateTime? since,
    required _izo77p7o.AiCostLine total,
    required List<_izo77p7o.AiCostLine> byFeature,
    required List<_izo77p7o.AiCostLine> byModel,
    required List<_izo77p7o.AiCostLine> byDay,
    required int interviewCount,
    required double averagePerInterviewUsd,
    required List<_iqw4ww4b.AiInterviewCost> recentInterviews,
  }) = _AiCostSummaryImpl;

  factory AiCostSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiCostSummary(
      since: jsonSerialization['since'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['since']),
      total: _iq9nucou.Protocol().deserialize<_izo77p7o.AiCostLine>(
        jsonSerialization['total'],
      ),
      byFeature: _iq9nucou.Protocol().deserialize<List<_izo77p7o.AiCostLine>>(
        jsonSerialization['byFeature'],
      ),
      byModel: _iq9nucou.Protocol().deserialize<List<_izo77p7o.AiCostLine>>(
        jsonSerialization['byModel'],
      ),
      byDay: _iq9nucou.Protocol().deserialize<List<_izo77p7o.AiCostLine>>(
        jsonSerialization['byDay'],
      ),
      interviewCount: jsonSerialization['interviewCount'] as int,
      averagePerInterviewUsd:
          (jsonSerialization['averagePerInterviewUsd'] as num).toDouble(),
      recentInterviews: _iq9nucou.Protocol()
          .deserialize<List<_iqw4ww4b.AiInterviewCost>>(
            jsonSerialization['recentInterviews'],
          ),
    );
  }

  /// Start of the window; null for all time.
  DateTime? since;

  _izo77p7o.AiCostLine total;

  List<_izo77p7o.AiCostLine> byFeature;

  List<_izo77p7o.AiCostLine> byModel;

  /// Newest day first.
  List<_izo77p7o.AiCostLine> byDay;

  int interviewCount;

  double averagePerInterviewUsd;

  /// Most recent interviews first.
  List<_iqw4ww4b.AiInterviewCost> recentInterviews;

  /// Returns a shallow copy of this [AiCostSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AiCostSummary copyWith({
    DateTime? since,
    _izo77p7o.AiCostLine? total,
    List<_izo77p7o.AiCostLine>? byFeature,
    List<_izo77p7o.AiCostLine>? byModel,
    List<_izo77p7o.AiCostLine>? byDay,
    int? interviewCount,
    double? averagePerInterviewUsd,
    List<_iqw4ww4b.AiInterviewCost>? recentInterviews,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiCostSummary',
      if (since != null) 'since': since?.toJson(),
      'total': total.toJson(),
      'byFeature': byFeature.toJson(valueToJson: (v) => v.toJson()),
      'byModel': byModel.toJson(valueToJson: (v) => v.toJson()),
      'byDay': byDay.toJson(valueToJson: (v) => v.toJson()),
      'interviewCount': interviewCount,
      'averagePerInterviewUsd': averagePerInterviewUsd,
      'recentInterviews': recentInterviews.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiCostSummary',
      if (since != null) 'since': since?.toJson(),
      'total': total.toJsonForProtocol(),
      'byFeature': byFeature.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'byModel': byModel.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'byDay': byDay.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'interviewCount': interviewCount,
      'averagePerInterviewUsd': averagePerInterviewUsd,
      'recentInterviews': recentInterviews.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiCostSummaryImpl extends AiCostSummary {
  _AiCostSummaryImpl({
    DateTime? since,
    required _izo77p7o.AiCostLine total,
    required List<_izo77p7o.AiCostLine> byFeature,
    required List<_izo77p7o.AiCostLine> byModel,
    required List<_izo77p7o.AiCostLine> byDay,
    required int interviewCount,
    required double averagePerInterviewUsd,
    required List<_iqw4ww4b.AiInterviewCost> recentInterviews,
  }) : super._(
         since: since,
         total: total,
         byFeature: byFeature,
         byModel: byModel,
         byDay: byDay,
         interviewCount: interviewCount,
         averagePerInterviewUsd: averagePerInterviewUsd,
         recentInterviews: recentInterviews,
       );

  /// Returns a shallow copy of this [AiCostSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AiCostSummary copyWith({
    Object? since = _Undefined,
    _izo77p7o.AiCostLine? total,
    List<_izo77p7o.AiCostLine>? byFeature,
    List<_izo77p7o.AiCostLine>? byModel,
    List<_izo77p7o.AiCostLine>? byDay,
    int? interviewCount,
    double? averagePerInterviewUsd,
    List<_iqw4ww4b.AiInterviewCost>? recentInterviews,
  }) {
    return AiCostSummary(
      since: since is DateTime? ? since : this.since,
      total: total ?? this.total.copyWith(),
      byFeature:
          byFeature ?? this.byFeature.map((e0) => e0.copyWith()).toList(),
      byModel: byModel ?? this.byModel.map((e0) => e0.copyWith()).toList(),
      byDay: byDay ?? this.byDay.map((e0) => e0.copyWith()).toList(),
      interviewCount: interviewCount ?? this.interviewCount,
      averagePerInterviewUsd:
          averagePerInterviewUsd ?? this.averagePerInterviewUsd,
      recentInterviews:
          recentInterviews ??
          this.recentInterviews.map((e0) => e0.copyWith()).toList(),
    );
  }
}
