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
import '../resume/parsed_resume.dart' as _iyylb1hm;
import '../resume/resume_parse_status.dart' as _i4n08ko5;

/// An uploaded resume PDF and its parse result.
abstract class Resume
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Resume._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.fileName,
    required this.storagePath,
    required this.sizeBytes,
    _i4n08ko5.ResumeParseStatus? status,
    this.parsedData,
    this.parseError,
    DateTime? createdAt,
    this.parsedAt,
  }) : status = status ?? _i4n08ko5.ResumeParseStatus.awaitingUpload,
       createdAt = createdAt ?? DateTime.now();

  factory Resume({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required String fileName,
    required String storagePath,
    required int sizeBytes,
    _i4n08ko5.ResumeParseStatus? status,
    _iyylb1hm.ParsedResume? parsedData,
    String? parseError,
    DateTime? createdAt,
    DateTime? parsedAt,
  }) = _ResumeImpl;

  factory Resume.fromJson(Map<String, dynamic> jsonSerialization) {
    return Resume(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      fileName: jsonSerialization['fileName'] as String,
      storagePath: jsonSerialization['storagePath'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      status: jsonSerialization['status'] == null
          ? null
          : _i4n08ko5.ResumeParseStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      parsedData: jsonSerialization['parsedData'] == null
          ? null
          : _i8wnw200.Protocol().deserialize<_iyylb1hm.ParsedResume>(
              jsonSerialization['parsedData'],
            ),
      parseError: jsonSerialization['parseError'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      parsedAt: jsonSerialization['parsedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['parsedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  _iacc.AuthUser? authUser;

  String fileName;

  /// Path inside the 'private' cloud storage. Derived server-side.
  String storagePath;

  int sizeBytes;

  _i4n08ko5.ResumeParseStatus status;

  _iyylb1hm.ParsedResume? parsedData;

  String? parseError;

  DateTime createdAt;

  DateTime? parsedAt;

  /// Returns a shallow copy of this [Resume]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Resume copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    String? fileName,
    String? storagePath,
    int? sizeBytes,
    _i4n08ko5.ResumeParseStatus? status,
    _iyylb1hm.ParsedResume? parsedData,
    String? parseError,
    DateTime? createdAt,
    DateTime? parsedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Resume',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fileName': fileName,
      'storagePath': storagePath,
      'sizeBytes': sizeBytes,
      'status': status.toJson(),
      if (parsedData != null) 'parsedData': parsedData?.toJson(),
      if (parseError != null) 'parseError': parseError,
      'createdAt': createdAt.toJson(),
      if (parsedAt != null) 'parsedAt': parsedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Resume',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fileName': fileName,
      'storagePath': storagePath,
      'sizeBytes': sizeBytes,
      'status': status.toJson(),
      if (parsedData != null) 'parsedData': parsedData?.toJsonForProtocol(),
      if (parseError != null) 'parseError': parseError,
      'createdAt': createdAt.toJson(),
      if (parsedAt != null) 'parsedAt': parsedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ResumeImpl extends Resume {
  _ResumeImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required String fileName,
    required String storagePath,
    required int sizeBytes,
    _i4n08ko5.ResumeParseStatus? status,
    _iyylb1hm.ParsedResume? parsedData,
    String? parseError,
    DateTime? createdAt,
    DateTime? parsedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         fileName: fileName,
         storagePath: storagePath,
         sizeBytes: sizeBytes,
         status: status,
         parsedData: parsedData,
         parseError: parseError,
         createdAt: createdAt,
         parsedAt: parsedAt,
       );

  /// Returns a shallow copy of this [Resume]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Resume copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? fileName,
    String? storagePath,
    int? sizeBytes,
    _i4n08ko5.ResumeParseStatus? status,
    Object? parsedData = _Undefined,
    Object? parseError = _Undefined,
    DateTime? createdAt,
    Object? parsedAt = _Undefined,
  }) {
    return Resume(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      fileName: fileName ?? this.fileName,
      storagePath: storagePath ?? this.storagePath,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      status: status ?? this.status,
      parsedData: parsedData is _iyylb1hm.ParsedResume?
          ? parsedData
          : this.parsedData?.copyWith(),
      parseError: parseError is String? ? parseError : this.parseError,
      createdAt: createdAt ?? this.createdAt,
      parsedAt: parsedAt is DateTime? ? parsedAt : this.parsedAt,
    );
  }
}
