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

abstract class ResumeParseFutureCallParseModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ResumeParseFutureCallParseModel._({required this.resumeId});

  factory ResumeParseFutureCallParseModel({required int resumeId}) =
      _ResumeParseFutureCallParseModelImpl;

  factory ResumeParseFutureCallParseModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ResumeParseFutureCallParseModel(
      resumeId: jsonSerialization['resumeId'] as int,
    );
  }

  int resumeId;

  /// Returns a shallow copy of this [ResumeParseFutureCallParseModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ResumeParseFutureCallParseModel copyWith({int? resumeId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ResumeParseFutureCallParseModel',
      'resumeId': resumeId,
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

class _ResumeParseFutureCallParseModelImpl
    extends ResumeParseFutureCallParseModel {
  _ResumeParseFutureCallParseModelImpl({required int resumeId})
    : super._(resumeId: resumeId);

  /// Returns a shallow copy of this [ResumeParseFutureCallParseModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ResumeParseFutureCallParseModel copyWith({int? resumeId}) {
    return ResumeParseFutureCallParseModel(resumeId: resumeId ?? this.resumeId);
  }
}
