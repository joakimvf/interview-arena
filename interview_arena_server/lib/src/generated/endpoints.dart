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
import 'package:interview_arena_server/src/generated/future_calls.dart'
    as _ir1xpria;
import 'package:interview_arena_server/src/generated/interview/inputs/candidate_input.dart'
    as _i299cc71;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../interview/interview_endpoint.dart' as _ihytjpn7;
import '../interview/voice_endpoint.dart' as _iuhx5coh;
import '../profile/profile_endpoint.dart' as _i6ky944g;
import '../resume/resume_endpoint.dart' as _ii1d9ztk;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'interview': _ihytjpn7.InterviewEndpoint()
        ..initialize(
          server,
          'interview',
          null,
        ),
      'voice': _iuhx5coh.VoiceEndpoint()
        ..initialize(
          server,
          'voice',
          null,
        ),
      'profile': _i6ky944g.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'resume': _ii1d9ztk.ResumeEndpoint()
        ..initialize(
          server,
          'resume',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['interview'] = _is.EndpointConnector(
      name: 'interview',
      endpoint: endpoints['interview']!,
      methodConnectors: {
        'start': _is.MethodConnector(
          name: 'start',
          params: {
            'targetRole': _is.ParameterDescription(
              name: 'targetRole',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'resumeId': _is.ParameterDescription(
              name: 'resumeId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['interview'] as _ihytjpn7.InterviewEndpoint).start(
                    session,
                    params['targetRole'],
                    params['resumeId'],
                  ),
        ),
        'getInterview': _is.MethodConnector(
          name: 'getInterview',
          params: {
            'interviewSessionId': _is.ParameterDescription(
              name: 'interviewSessionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['interview'] as _ihytjpn7.InterviewEndpoint)
                  .getInterview(
                    session,
                    params['interviewSessionId'],
                  ),
        ),
        'listInterviews': _is.MethodConnector(
          name: 'listInterviews',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['interview'] as _ihytjpn7.InterviewEndpoint)
                  .listInterviews(session),
        ),
        'conduct': _is.MethodStreamConnector(
          name: 'conduct',
          params: {
            'interviewSessionId': _is.ParameterDescription(
              name: 'interviewSessionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {
            'inputs': _is.StreamParameterDescription<_i299cc71.CandidateInput>(
              name: 'inputs',
              nullable: false,
            ),
          },
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['interview'] as _ihytjpn7.InterviewEndpoint)
                  .conduct(
                    session,
                    params['interviewSessionId'],
                    streamParams['inputs']!.cast<_i299cc71.CandidateInput>(),
                  ),
        ),
      },
    );
    connectors['voice'] = _is.EndpointConnector(
      name: 'voice',
      endpoint: endpoints['voice']!,
      methodConnectors: {
        'questionAudio': _is.MethodConnector(
          name: 'questionAudio',
          params: {
            'questionId': _is.ParameterDescription(
              name: 'questionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['voice'] as _iuhx5coh.VoiceEndpoint).questionAudio(
                    session,
                    params['questionId'],
                  ),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i6ky944g.ProfileEndpoint).me(
                session,
              ),
        ),
        'updateMe': _is.MethodConnector(
          name: 'updateMe',
          params: {
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'targetRole': _is.ParameterDescription(
              name: 'targetRole',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'yearsOfExperience': _is.ParameterDescription(
              name: 'yearsOfExperience',
              type: _is.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['profile'] as _i6ky944g.ProfileEndpoint).updateMe(
                    session,
                    params['displayName'],
                    params['targetRole'],
                    params['yearsOfExperience'],
                  ),
        ),
      },
    );
    connectors['resume'] = _is.EndpointConnector(
      name: 'resume',
      endpoint: endpoints['resume']!,
      methodConnectors: {
        'createUpload': _is.MethodConnector(
          name: 'createUpload',
          params: {
            'fileName': _is.ParameterDescription(
              name: 'fileName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'sizeBytes': _is.ParameterDescription(
              name: 'sizeBytes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['resume'] as _ii1d9ztk.ResumeEndpoint)
                  .createUpload(
                    session,
                    params['fileName'],
                    params['sizeBytes'],
                  ),
        ),
        'completeUpload': _is.MethodConnector(
          name: 'completeUpload',
          params: {
            'resumeId': _is.ParameterDescription(
              name: 'resumeId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['resume'] as _ii1d9ztk.ResumeEndpoint)
                  .completeUpload(
                    session,
                    params['resumeId'],
                  ),
        ),
        'getResume': _is.MethodConnector(
          name: 'getResume',
          params: {
            'resumeId': _is.ParameterDescription(
              name: 'resumeId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['resume'] as _ii1d9ztk.ResumeEndpoint).getResume(
                    session,
                    params['resumeId'],
                  ),
        ),
        'listResumes': _is.MethodConnector(
          name: 'listResumes',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['resume'] as _ii1d9ztk.ResumeEndpoint)
                  .listResumes(session),
        ),
        'deleteResume': _is.MethodConnector(
          name: 'deleteResume',
          params: {
            'resumeId': _is.ParameterDescription(
              name: 'resumeId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['resume'] as _ii1d9ztk.ResumeEndpoint)
                  .deleteResume(
                    session,
                    params['resumeId'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _ir1xpria.FutureCalls();
  }
}
