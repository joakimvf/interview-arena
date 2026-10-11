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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// App-level profile for a signed-in candidate. One row per auth user.
abstract class CandidateProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CandidateProfile._({
    this.id,
    required this.authUserId,
    this.authUser,
    this.displayName,
    this.targetRole,
    this.yearsOfExperience,
    String? timeZone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : timeZone = timeZone ?? 'UTC',
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory CandidateProfile({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    String? displayName,
    String? targetRole,
    double? yearsOfExperience,
    String? timeZone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CandidateProfileImpl;

  factory CandidateProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return CandidateProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      displayName: jsonSerialization['displayName'] as String?,
      targetRole: jsonSerialization['targetRole'] as String?,
      yearsOfExperience: (jsonSerialization['yearsOfExperience'] as num?)
          ?.toDouble(),
      timeZone: jsonSerialization['timeZone'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  /// Owner: UuidValue FK to serverpod_auth_core_user, cascade on account deletion.
  _iacc.AuthUser? authUser;

  String? displayName;

  String? targetRole;

  double? yearsOfExperience;

  /// IANA time zone name, used later for the daily challenge.
  String timeZone;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [CandidateProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CandidateProfile copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    String? displayName,
    String? targetRole,
    double? yearsOfExperience,
    String? timeZone,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CandidateProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (displayName != null) 'displayName': displayName,
      if (targetRole != null) 'targetRole': targetRole,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      'timeZone': timeZone,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CandidateProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (displayName != null) 'displayName': displayName,
      if (targetRole != null) 'targetRole': targetRole,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      'timeZone': timeZone,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CandidateProfileImpl extends CandidateProfile {
  _CandidateProfileImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    String? displayName,
    String? targetRole,
    double? yearsOfExperience,
    String? timeZone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         displayName: displayName,
         targetRole: targetRole,
         yearsOfExperience: yearsOfExperience,
         timeZone: timeZone,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CandidateProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CandidateProfile copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Object? displayName = _Undefined,
    Object? targetRole = _Undefined,
    Object? yearsOfExperience = _Undefined,
    String? timeZone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CandidateProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      displayName: displayName is String? ? displayName : this.displayName,
      targetRole: targetRole is String? ? targetRole : this.targetRole,
      yearsOfExperience: yearsOfExperience is double?
          ? yearsOfExperience
          : this.yearsOfExperience,
      timeZone: timeZone ?? this.timeZone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
