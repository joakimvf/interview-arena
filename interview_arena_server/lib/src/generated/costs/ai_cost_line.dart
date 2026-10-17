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
import 'package:serverpod/serverpod.dart' as _is;

/// Totals for one group of AI calls (a feature, a model or a day).
abstract class AiCostLine
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AiCostLine._({
    required this.label,
    required this.calls,
    required this.inputTokens,
    required this.outputTokens,
    required this.cacheReadTokens,
    required this.cacheWriteTokens,
    required this.characters,
    required this.costUsd,
    required this.unpricedCalls,
  });

  factory AiCostLine({
    required String label,
    required int calls,
    required int inputTokens,
    required int outputTokens,
    required int cacheReadTokens,
    required int cacheWriteTokens,
    required int characters,
    required double costUsd,
    required int unpricedCalls,
  }) = _AiCostLineImpl;

  factory AiCostLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiCostLine(
      label: jsonSerialization['label'] as String,
      calls: jsonSerialization['calls'] as int,
      inputTokens: jsonSerialization['inputTokens'] as int,
      outputTokens: jsonSerialization['outputTokens'] as int,
      cacheReadTokens: jsonSerialization['cacheReadTokens'] as int,
      cacheWriteTokens: jsonSerialization['cacheWriteTokens'] as int,
      characters: jsonSerialization['characters'] as int,
      costUsd: (jsonSerialization['costUsd'] as num).toDouble(),
      unpricedCalls: jsonSerialization['unpricedCalls'] as int,
    );
  }

  String label;

  int calls;

  int inputTokens;

  int outputTokens;

  int cacheReadTokens;

  int cacheWriteTokens;

  int characters;

  double costUsd;

  /// Calls without a known price (not included in costUsd).
  int unpricedCalls;

  /// Returns a shallow copy of this [AiCostLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AiCostLine copyWith({
    String? label,
    int? calls,
    int? inputTokens,
    int? outputTokens,
    int? cacheReadTokens,
    int? cacheWriteTokens,
    int? characters,
    double? costUsd,
    int? unpricedCalls,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiCostLine',
      'label': label,
      'calls': calls,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'cacheReadTokens': cacheReadTokens,
      'cacheWriteTokens': cacheWriteTokens,
      'characters': characters,
      'costUsd': costUsd,
      'unpricedCalls': unpricedCalls,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiCostLine',
      'label': label,
      'calls': calls,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'cacheReadTokens': cacheReadTokens,
      'cacheWriteTokens': cacheWriteTokens,
      'characters': characters,
      'costUsd': costUsd,
      'unpricedCalls': unpricedCalls,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AiCostLineImpl extends AiCostLine {
  _AiCostLineImpl({
    required String label,
    required int calls,
    required int inputTokens,
    required int outputTokens,
    required int cacheReadTokens,
    required int cacheWriteTokens,
    required int characters,
    required double costUsd,
    required int unpricedCalls,
  }) : super._(
         label: label,
         calls: calls,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
         cacheReadTokens: cacheReadTokens,
         cacheWriteTokens: cacheWriteTokens,
         characters: characters,
         costUsd: costUsd,
         unpricedCalls: unpricedCalls,
       );

  /// Returns a shallow copy of this [AiCostLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AiCostLine copyWith({
    String? label,
    int? calls,
    int? inputTokens,
    int? outputTokens,
    int? cacheReadTokens,
    int? cacheWriteTokens,
    int? characters,
    double? costUsd,
    int? unpricedCalls,
  }) {
    return AiCostLine(
      label: label ?? this.label,
      calls: calls ?? this.calls,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      cacheReadTokens: cacheReadTokens ?? this.cacheReadTokens,
      cacheWriteTokens: cacheWriteTokens ?? this.cacheWriteTokens,
      characters: characters ?? this.characters,
      costUsd: costUsd ?? this.costUsd,
      unpricedCalls: unpricedCalls ?? this.unpricedCalls,
    );
  }
}
