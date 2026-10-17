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
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:http/http.dart' as _i85jenna;
import 'package:interview_arena_client/src/protocol/costs/ai_cost_summary.dart'
    as _iu55fj6k;
import 'package:interview_arena_client/src/protocol/interview/events/interview_event.dart'
    as _imk1u46l;
import 'package:interview_arena_client/src/protocol/interview/inputs/candidate_input.dart'
    as _i62x3a2n;
import 'package:interview_arena_client/src/protocol/interview/interview_session.dart'
    as _igfauqzi;
import 'package:interview_arena_client/src/protocol/resume/resume.dart'
    as _imbxkhrz;
import 'package:interview_arena_client/src/protocol/resume/resume_upload_ticket.dart'
    as _izkyf11v;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Sign-up is closed on deployed servers (see [signUpOpen]). Every
  /// registration starts here, so blocking this blocks the whole flow.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// The team's view of what the app spends on AI, from `ai_usage`.
/// Open to the admin scope on deployed servers, and to anyone signed in
/// during development and tests.
/// {@category Endpoint}
class EndpointAiCost extends _isc.EndpointRef {
  EndpointAiCost(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'aiCost';

  /// Whether the signed-in user may see AI costs (shows the menu entry).
  _ida.Future<bool> canView() => caller.callServerEndpoint<bool>(
    'aiCost',
    'canView',
    {},
  );

  /// Spend over the last [days] days, or all time when [days] is 0 or less.
  _ida.Future<_iu55fj6k.AiCostSummary> summary(int days) =>
      caller.callServerEndpoint<_iu55fj6k.AiCostSummary>(
        'aiCost',
        'summary',
        {'days': days},
      );
}

/// {@category Endpoint}
class EndpointInterview extends _isc.EndpointRef {
  EndpointInterview(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'interview';

  _ida.Future<_igfauqzi.InterviewSession> start(
    String targetRole,
    int? resumeId,
  ) => caller.callServerEndpoint<_igfauqzi.InterviewSession>(
    'interview',
    'start',
    {
      'targetRole': targetRole,
      'resumeId': resumeId,
    },
  );

  _ida.Future<_igfauqzi.InterviewSession?> getInterview(
    int interviewSessionId,
  ) => caller.callServerEndpoint<_igfauqzi.InterviewSession?>(
    'interview',
    'getInterview',
    {'interviewSessionId': interviewSessionId},
  );

  _ida.Future<List<_igfauqzi.InterviewSession>> listInterviews() =>
      caller.callServerEndpoint<List<_igfauqzi.InterviewSession>>(
        'interview',
        'listInterviews',
        {},
      );

  /// The live interview. Persist-first: every answer is stored before the slow
  /// evaluation, so a disconnect loses nothing; reconnecting resumes from DB.
  _ida.Stream<_imk1u46l.InterviewEvent> conduct(
    int interviewSessionId,
    _ida.Stream<_i62x3a2n.CandidateInput> inputs,
  ) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_imk1u46l.InterviewEvent>,
        _imk1u46l.InterviewEvent
      >(
        'interview',
        'conduct',
        {'interviewSessionId': interviewSessionId},
        {'inputs': inputs},
      );
}

/// The interviewer's voice: questions read aloud via ElevenLabs.
/// {@category Endpoint}
class EndpointVoice extends _isc.EndpointRef {
  EndpointVoice(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'voice';

  /// MP3 of the question read aloud, or null when no voice is configured.
  _ida.Future<_idt.ByteData?> questionAudio(int questionId) =>
      caller.callServerEndpoint<_idt.ByteData?>(
        'voice',
        'questionAudio',
        {'questionId': questionId},
      );
}

/// Resume PDF: createUpload -> (client FileUploader) -> completeUpload ->
/// parse in the background -> client polls getResume.
/// {@category Endpoint}
class EndpointResume extends _isc.EndpointRef {
  EndpointResume(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'resume';

  _ida.Future<_izkyf11v.ResumeUploadTicket> createUpload(
    String fileName,
    int sizeBytes,
  ) => caller.callServerEndpoint<_izkyf11v.ResumeUploadTicket>(
    'resume',
    'createUpload',
    {
      'fileName': fileName,
      'sizeBytes': sizeBytes,
    },
  );

  _ida.Future<_imbxkhrz.Resume> completeUpload(int resumeId) =>
      caller.callServerEndpoint<_imbxkhrz.Resume>(
        'resume',
        'completeUpload',
        {'resumeId': resumeId},
      );

  _ida.Future<_imbxkhrz.Resume?> getResume(int resumeId) =>
      caller.callServerEndpoint<_imbxkhrz.Resume?>(
        'resume',
        'getResume',
        {'resumeId': resumeId},
      );

  _ida.Future<List<_imbxkhrz.Resume>> listResumes() =>
      caller.callServerEndpoint<List<_imbxkhrz.Resume>>(
        'resume',
        'listResumes',
        {},
      );

  _ida.Future<void> deleteResume(int resumeId) =>
      caller.callServerEndpoint<void>(
        'resume',
        'deleteResume',
        {'resumeId': resumeId},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    aiCost = EndpointAiCost(this);
    interview = EndpointInterview(this);
    voice = EndpointVoice(this);
    resume = EndpointResume(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAiCost aiCost;

  late final EndpointInterview interview;

  late final EndpointVoice voice;

  late final EndpointResume resume;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'aiCost': aiCost,
    'interview': interview,
    'voice': voice,
    'resume': resume,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
