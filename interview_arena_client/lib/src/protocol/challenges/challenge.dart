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
import '../challenges/challenge_difficulty.dart' as _ikp2tgfr;
import '../interview/question_category.dart' as _ietck0qu;

/// A recurring daily challenge. Global, server-only in pass 1.
/// Later phase: offline copy via a separate `database: client` table.
abstract class Challenge
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Challenge._({
    this.id,
    required this.scheduledFor,
    required this.title,
    required this.prompt,
    required this.category,
    _ikp2tgfr.ChallengeDifficulty? difficulty,
    required this.targetSkills,
    this.rubric,
    this.timeLimit,
    DateTime? createdAt,
  }) : difficulty = difficulty ?? _ikp2tgfr.ChallengeDifficulty.medium,
       createdAt = createdAt ?? DateTime.now();

  factory Challenge({
    _isc.UuidValue? id,
    required DateTime scheduledFor,
    required String title,
    required String prompt,
    required _ietck0qu.QuestionCategory category,
    _ikp2tgfr.ChallengeDifficulty? difficulty,
    required List<String> targetSkills,
    List<String>? rubric,
    Duration? timeLimit,
    DateTime? createdAt,
  }) = _ChallengeImpl;

  factory Challenge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Challenge(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      scheduledFor: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledFor'],
      ),
      title: jsonSerialization['title'] as String,
      prompt: jsonSerialization['prompt'] as String,
      category: _ietck0qu.QuestionCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      difficulty: jsonSerialization['difficulty'] == null
          ? null
          : _ikp2tgfr.ChallengeDifficulty.fromJson(
              (jsonSerialization['difficulty'] as String),
            ),
      targetSkills: _i8wnw200.Protocol().deserialize<List<String>>(
        jsonSerialization['targetSkills'],
      ),
      rubric: jsonSerialization['rubric'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<List<String>>(
              jsonSerialization['rubric'],
            ),
      timeLimit: jsonSerialization['timeLimit'] == null
          ? null
          : _isc.DurationJsonExtension.fromJson(jsonSerialization['timeLimit']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _isc.UuidValue? id;

  /// UTC midnight of the day this challenge is for.
  DateTime scheduledFor;

  String title;

  String prompt;

  _ietck0qu.QuestionCategory category;

  _ikp2tgfr.ChallengeDifficulty difficulty;

  List<String> targetSkills;

  List<String>? rubric;

  Duration? timeLimit;

  DateTime createdAt;

  /// Returns a shallow copy of this [Challenge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Challenge copyWith({
    _isc.UuidValue? id,
    DateTime? scheduledFor,
    String? title,
    String? prompt,
    _ietck0qu.QuestionCategory? category,
    _ikp2tgfr.ChallengeDifficulty? difficulty,
    List<String>? targetSkills,
    List<String>? rubric,
    Duration? timeLimit,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Challenge',
      if (id != null) 'id': id?.toJson(),
      'scheduledFor': scheduledFor.toJson(),
      'title': title,
      'prompt': prompt,
      'category': category.toJson(),
      'difficulty': difficulty.toJson(),
      'targetSkills': targetSkills.toJson(),
      if (rubric != null) 'rubric': rubric?.toJson(),
      if (timeLimit != null) 'timeLimit': timeLimit?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Challenge',
      if (id != null) 'id': id?.toJson(),
      'scheduledFor': scheduledFor.toJson(),
      'title': title,
      'prompt': prompt,
      'category': category.toJson(),
      'difficulty': difficulty.toJson(),
      'targetSkills': targetSkills.toJson(),
      if (rubric != null) 'rubric': rubric?.toJson(),
      if (timeLimit != null) 'timeLimit': timeLimit?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeImpl extends Challenge {
  _ChallengeImpl({
    _isc.UuidValue? id,
    required DateTime scheduledFor,
    required String title,
    required String prompt,
    required _ietck0qu.QuestionCategory category,
    _ikp2tgfr.ChallengeDifficulty? difficulty,
    required List<String> targetSkills,
    List<String>? rubric,
    Duration? timeLimit,
    DateTime? createdAt,
  }) : super._(
         id: id,
         scheduledFor: scheduledFor,
         title: title,
         prompt: prompt,
         category: category,
         difficulty: difficulty,
         targetSkills: targetSkills,
         rubric: rubric,
         timeLimit: timeLimit,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Challenge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Challenge copyWith({
    Object? id = _Undefined,
    DateTime? scheduledFor,
    String? title,
    String? prompt,
    _ietck0qu.QuestionCategory? category,
    _ikp2tgfr.ChallengeDifficulty? difficulty,
    List<String>? targetSkills,
    Object? rubric = _Undefined,
    Object? timeLimit = _Undefined,
    DateTime? createdAt,
  }) {
    return Challenge(
      id: id is _isc.UuidValue? ? id : this.id,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      title: title ?? this.title,
      prompt: prompt ?? this.prompt,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      targetSkills: targetSkills ?? this.targetSkills.map((e0) => e0).toList(),
      rubric: rubric is List<String>?
          ? rubric
          : this.rubric?.map((e0) => e0).toList(),
      timeLimit: timeLimit is Duration? ? timeLimit : this.timeLimit,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
