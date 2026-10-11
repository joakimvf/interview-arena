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

abstract class AnswerEmbeddingFutureCallEmbedModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AnswerEmbeddingFutureCallEmbedModel._({required this.answerId});

  factory AnswerEmbeddingFutureCallEmbedModel({required int answerId}) =
      _AnswerEmbeddingFutureCallEmbedModelImpl;

  factory AnswerEmbeddingFutureCallEmbedModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AnswerEmbeddingFutureCallEmbedModel(
      answerId: jsonSerialization['answerId'] as int,
    );
  }

  int answerId;

  /// Returns a shallow copy of this [AnswerEmbeddingFutureCallEmbedModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AnswerEmbeddingFutureCallEmbedModel copyWith({int? answerId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnswerEmbeddingFutureCallEmbedModel',
      'answerId': answerId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AnswerEmbeddingFutureCallEmbedModelImpl
    extends AnswerEmbeddingFutureCallEmbedModel {
  _AnswerEmbeddingFutureCallEmbedModelImpl({required int answerId})
    : super._(answerId: answerId);

  /// Returns a shallow copy of this [AnswerEmbeddingFutureCallEmbedModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AnswerEmbeddingFutureCallEmbedModel copyWith({int? answerId}) {
    return AnswerEmbeddingFutureCallEmbedModel(
      answerId: answerId ?? this.answerId,
    );
  }
}
