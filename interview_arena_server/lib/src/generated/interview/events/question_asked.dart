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

abstract class QuestionAsked extends _iototaiw.InterviewEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  QuestionAsked._({
    required super.interviewSessionId,
    required super.sequence,
    required this.questionId,
    required this.orderIndex,
    required this.category,
    required this.prompt,
    bool? isFollowUp,
  }) : isFollowUp = isFollowUp ?? false;

  factory QuestionAsked({
    required int interviewSessionId,
    required int sequence,
    required int questionId,
    required int orderIndex,
    required _irka2p12.QuestionCategory category,
    required String prompt,
    bool? isFollowUp,
  }) = _QuestionAskedImpl;

  factory QuestionAsked.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuestionAsked(
      interviewSessionId: jsonSerialization['interviewSessionId'] as int,
      sequence: jsonSerialization['sequence'] as int,
      questionId: jsonSerialization['questionId'] as int,
      orderIndex: jsonSerialization['orderIndex'] as int,
      category: _irka2p12.QuestionCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      prompt: jsonSerialization['prompt'] as String,
      isFollowUp: jsonSerialization['isFollowUp'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isFollowUp']),
    );
  }

  int questionId;

  int orderIndex;

  _irka2p12.QuestionCategory category;

  String prompt;

  bool isFollowUp;

  /// Returns a shallow copy of this [QuestionAsked]
  /// with some or all fields replaced by the given arguments.
  @override
  @_is.useResult
  QuestionAsked copyWith({
    int? interviewSessionId,
    int? sequence,
    int? questionId,
    int? orderIndex,
    _irka2p12.QuestionCategory? category,
    String? prompt,
    bool? isFollowUp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuestionAsked',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      'questionId': questionId,
      'orderIndex': orderIndex,
      'category': category.toJson(),
      'prompt': prompt,
      'isFollowUp': isFollowUp,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuestionAsked',
      'interviewSessionId': interviewSessionId,
      'sequence': sequence,
      'questionId': questionId,
      'orderIndex': orderIndex,
      'category': category.toJson(),
      'prompt': prompt,
      'isFollowUp': isFollowUp,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _QuestionAskedImpl extends QuestionAsked {
  _QuestionAskedImpl({
    required int interviewSessionId,
    required int sequence,
    required int questionId,
    required int orderIndex,
    required _irka2p12.QuestionCategory category,
    required String prompt,
    bool? isFollowUp,
  }) : super._(
         interviewSessionId: interviewSessionId,
         sequence: sequence,
         questionId: questionId,
         orderIndex: orderIndex,
         category: category,
         prompt: prompt,
         isFollowUp: isFollowUp,
       );

  /// Returns a shallow copy of this [QuestionAsked]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuestionAsked copyWith({
    int? interviewSessionId,
    int? sequence,
    int? questionId,
    int? orderIndex,
    _irka2p12.QuestionCategory? category,
    String? prompt,
    bool? isFollowUp,
  }) {
    return QuestionAsked(
      interviewSessionId: interviewSessionId ?? this.interviewSessionId,
      sequence: sequence ?? this.sequence,
      questionId: questionId ?? this.questionId,
      orderIndex: orderIndex ?? this.orderIndex,
      category: category ?? this.category,
      prompt: prompt ?? this.prompt,
      isFollowUp: isFollowUp ?? this.isFollowUp,
    );
  }
}
