/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:interview_arena_client/src/protocol/interview/interview_session.dart'
    as _igfauqzi;
import 'package:interview_arena_client/src/protocol/resume/resume.dart'
    as _imbxkhrz;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'auth/sign_up_closed_exception.dart' as _i8uejmxn;
import 'challenges/challenge.dart' as _iylq4q0i;
import 'challenges/challenge_difficulty.dart' as _igs032ca;
import 'interview/answer.dart' as _ilptq4di;
import 'interview/answer_feedback.dart' as _iq8f7lpk;
import 'interview/events/interview_event.dart' as _i9r9cihw;
import 'interview/inputs/candidate_input.dart' as _ipbu4009;
import 'interview/interview_exception.dart' as _ix0gec48;
import 'interview/interview_report.dart' as _ihpfwdr6;
import 'interview/interview_scores.dart' as _i0s2zm9r;
import 'interview/interview_session.dart' as _illbuy7a;
import 'interview/interview_status.dart' as _ifyqp54v;
import 'interview/question.dart' as _ihpdvrxq;
import 'interview/question_category.dart' as _i8405n7p;
import 'profile/candidate_profile.dart' as _i4trz3o8;
import 'resume/extracted_skill.dart' as _izdd6kyx;
import 'resume/parsed_resume.dart' as _ivs53uxk;
import 'resume/resume.dart' as _ipkmgecw;
import 'resume/resume_exception.dart' as _iqo5w92k;
import 'resume/resume_parse_status.dart' as _imejjlr6;
import 'resume/resume_upload_ticket.dart' as _ieef7w2g;
import 'resume/work_experience.dart' as _iq8k1g78;
import 'skills/skill_node.dart' as _ifilxtcy;
import 'skills/skill_profile.dart' as _ioq46cla;
import 'skills/weakness.dart' as _i7w5oxf5;
export 'auth/sign_up_closed_exception.dart';
export 'challenges/challenge.dart';
export 'challenges/challenge_difficulty.dart';
export 'interview/answer.dart';
export 'interview/answer_feedback.dart';
export 'interview/events/interview_event.dart';
export 'interview/inputs/candidate_input.dart';
export 'interview/interview_exception.dart';
export 'interview/interview_report.dart';
export 'interview/interview_scores.dart';
export 'interview/interview_session.dart';
export 'interview/interview_status.dart';
export 'interview/question.dart';
export 'interview/question_category.dart';
export 'profile/candidate_profile.dart';
export 'resume/extracted_skill.dart';
export 'resume/parsed_resume.dart';
export 'resume/resume.dart';
export 'resume/resume_exception.dart';
export 'resume/resume_parse_status.dart';
export 'resume/resume_upload_ticket.dart';
export 'resume/work_experience.dart';
export 'skills/skill_node.dart';
export 'skills/skill_profile.dart';
export 'skills/weakness.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i8uejmxn.SignUpClosedException) {
      return _i8uejmxn.SignUpClosedException.fromJson(data) as T;
    }
    if (t == _iylq4q0i.Challenge) {
      return _iylq4q0i.Challenge.fromJson(data) as T;
    }
    if (t == _igs032ca.ChallengeDifficulty) {
      return _igs032ca.ChallengeDifficulty.fromJson(data) as T;
    }
    if (t == _ilptq4di.Answer) {
      return _ilptq4di.Answer.fromJson(data) as T;
    }
    if (t == _iq8f7lpk.AnswerFeedback) {
      return _iq8f7lpk.AnswerFeedback.fromJson(data) as T;
    }
    if (t == _i9r9cihw.AnswerEvaluated) {
      return _i9r9cihw.AnswerEvaluated.fromJson(data) as T;
    }
    if (t == _i9r9cihw.AnswerReceived) {
      return _i9r9cihw.AnswerReceived.fromJson(data) as T;
    }
    if (t == _i9r9cihw.InterviewFinished) {
      return _i9r9cihw.InterviewFinished.fromJson(data) as T;
    }
    if (t == _i9r9cihw.InterviewNotice) {
      return _i9r9cihw.InterviewNotice.fromJson(data) as T;
    }
    if (t == _i9r9cihw.QuestionAsked) {
      return _i9r9cihw.QuestionAsked.fromJson(data) as T;
    }
    if (t == _i9r9cihw.ScoreUpdate) {
      return _i9r9cihw.ScoreUpdate.fromJson(data) as T;
    }
    if (t == _ipbu4009.AnswerChunk) {
      return _ipbu4009.AnswerChunk.fromJson(data) as T;
    }
    if (t == _ipbu4009.AnswerSubmitted) {
      return _ipbu4009.AnswerSubmitted.fromJson(data) as T;
    }
    if (t == _ipbu4009.EndInterview) {
      return _ipbu4009.EndInterview.fromJson(data) as T;
    }
    if (t == _ix0gec48.InterviewAccessException) {
      return _ix0gec48.InterviewAccessException.fromJson(data) as T;
    }
    if (t == _ihpfwdr6.InterviewReport) {
      return _ihpfwdr6.InterviewReport.fromJson(data) as T;
    }
    if (t == _i0s2zm9r.InterviewScores) {
      return _i0s2zm9r.InterviewScores.fromJson(data) as T;
    }
    if (t == _illbuy7a.InterviewSession) {
      return _illbuy7a.InterviewSession.fromJson(data) as T;
    }
    if (t == _ifyqp54v.InterviewStatus) {
      return _ifyqp54v.InterviewStatus.fromJson(data) as T;
    }
    if (t == _ihpdvrxq.Question) {
      return _ihpdvrxq.Question.fromJson(data) as T;
    }
    if (t == _i8405n7p.QuestionCategory) {
      return _i8405n7p.QuestionCategory.fromJson(data) as T;
    }
    if (t == _i4trz3o8.CandidateProfile) {
      return _i4trz3o8.CandidateProfile.fromJson(data) as T;
    }
    if (t == _izdd6kyx.ExtractedSkill) {
      return _izdd6kyx.ExtractedSkill.fromJson(data) as T;
    }
    if (t == _ivs53uxk.ParsedResume) {
      return _ivs53uxk.ParsedResume.fromJson(data) as T;
    }
    if (t == _ipkmgecw.Resume) {
      return _ipkmgecw.Resume.fromJson(data) as T;
    }
    if (t == _iqo5w92k.ResumeException) {
      return _iqo5w92k.ResumeException.fromJson(data) as T;
    }
    if (t == _imejjlr6.ResumeParseStatus) {
      return _imejjlr6.ResumeParseStatus.fromJson(data) as T;
    }
    if (t == _ieef7w2g.ResumeUploadTicket) {
      return _ieef7w2g.ResumeUploadTicket.fromJson(data) as T;
    }
    if (t == _iq8k1g78.WorkExperience) {
      return _iq8k1g78.WorkExperience.fromJson(data) as T;
    }
    if (t == _ifilxtcy.SkillNode) {
      return _ifilxtcy.SkillNode.fromJson(data) as T;
    }
    if (t == _ioq46cla.SkillProfile) {
      return _ioq46cla.SkillProfile.fromJson(data) as T;
    }
    if (t == _i7w5oxf5.Weakness) {
      return _i7w5oxf5.Weakness.fromJson(data) as T;
    }
    if (t == _isc.getType<_i8uejmxn.SignUpClosedException?>()) {
      return (data != null
              ? _i8uejmxn.SignUpClosedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iylq4q0i.Challenge?>()) {
      return (data != null ? _iylq4q0i.Challenge.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igs032ca.ChallengeDifficulty?>()) {
      return (data != null
              ? _igs032ca.ChallengeDifficulty.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ilptq4di.Answer?>()) {
      return (data != null ? _ilptq4di.Answer.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iq8f7lpk.AnswerFeedback?>()) {
      return (data != null ? _iq8f7lpk.AnswerFeedback.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9r9cihw.AnswerEvaluated?>()) {
      return (data != null ? _i9r9cihw.AnswerEvaluated.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9r9cihw.AnswerReceived?>()) {
      return (data != null ? _i9r9cihw.AnswerReceived.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9r9cihw.InterviewFinished?>()) {
      return (data != null ? _i9r9cihw.InterviewFinished.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9r9cihw.InterviewNotice?>()) {
      return (data != null ? _i9r9cihw.InterviewNotice.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9r9cihw.QuestionAsked?>()) {
      return (data != null ? _i9r9cihw.QuestionAsked.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9r9cihw.ScoreUpdate?>()) {
      return (data != null ? _i9r9cihw.ScoreUpdate.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ipbu4009.AnswerChunk?>()) {
      return (data != null ? _ipbu4009.AnswerChunk.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ipbu4009.AnswerSubmitted?>()) {
      return (data != null ? _ipbu4009.AnswerSubmitted.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipbu4009.EndInterview?>()) {
      return (data != null ? _ipbu4009.EndInterview.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ix0gec48.InterviewAccessException?>()) {
      return (data != null
              ? _ix0gec48.InterviewAccessException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ihpfwdr6.InterviewReport?>()) {
      return (data != null ? _ihpfwdr6.InterviewReport.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i0s2zm9r.InterviewScores?>()) {
      return (data != null ? _i0s2zm9r.InterviewScores.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_illbuy7a.InterviewSession?>()) {
      return (data != null ? _illbuy7a.InterviewSession.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ifyqp54v.InterviewStatus?>()) {
      return (data != null ? _ifyqp54v.InterviewStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ihpdvrxq.Question?>()) {
      return (data != null ? _ihpdvrxq.Question.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8405n7p.QuestionCategory?>()) {
      return (data != null ? _i8405n7p.QuestionCategory.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i4trz3o8.CandidateProfile?>()) {
      return (data != null ? _i4trz3o8.CandidateProfile.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izdd6kyx.ExtractedSkill?>()) {
      return (data != null ? _izdd6kyx.ExtractedSkill.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivs53uxk.ParsedResume?>()) {
      return (data != null ? _ivs53uxk.ParsedResume.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ipkmgecw.Resume?>()) {
      return (data != null ? _ipkmgecw.Resume.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqo5w92k.ResumeException?>()) {
      return (data != null ? _iqo5w92k.ResumeException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_imejjlr6.ResumeParseStatus?>()) {
      return (data != null ? _imejjlr6.ResumeParseStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ieef7w2g.ResumeUploadTicket?>()) {
      return (data != null ? _ieef7w2g.ResumeUploadTicket.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iq8k1g78.WorkExperience?>()) {
      return (data != null ? _iq8k1g78.WorkExperience.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ifilxtcy.SkillNode?>()) {
      return (data != null ? _ifilxtcy.SkillNode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ioq46cla.SkillProfile?>()) {
      return (data != null ? _ioq46cla.SkillProfile.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7w5oxf5.Weakness?>()) {
      return (data != null ? _i7w5oxf5.Weakness.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<double>(v)),
          )
          as T;
    }
    if (t == List<_ihpdvrxq.Question>) {
      return (data as List)
              .map((e) => deserialize<_ihpdvrxq.Question>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ihpdvrxq.Question>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ihpdvrxq.Question>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ilptq4di.Answer>) {
      return (data as List)
              .map((e) => deserialize<_ilptq4di.Answer>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ilptq4di.Answer>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ilptq4di.Answer>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_izdd6kyx.ExtractedSkill>) {
      return (data as List)
              .map((e) => deserialize<_izdd6kyx.ExtractedSkill>(e))
              .toList()
          as T;
    }
    if (t == List<_iq8k1g78.WorkExperience>) {
      return (data as List)
              .map((e) => deserialize<_iq8k1g78.WorkExperience>(e))
              .toList()
          as T;
    }
    if (t == Map<String, _ifilxtcy.SkillNode>) {
      return (data as Map).map(
            (k, v) => MapEntry(
              deserialize<String>(k),
              deserialize<_ifilxtcy.SkillNode>(v),
            ),
          )
          as T;
    }
    if (t == List<_i7w5oxf5.Weakness>) {
      return (data as List)
              .map((e) => deserialize<_i7w5oxf5.Weakness>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_igfauqzi.InterviewSession>) {
      return (data as List)
              .map((e) => deserialize<_igfauqzi.InterviewSession>(e))
              .toList()
          as T;
    }
    if (t == List<_imbxkhrz.Resume>) {
      return (data as List)
              .map((e) => deserialize<_imbxkhrz.Resume>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i8uejmxn.SignUpClosedException => 'SignUpClosedException',
      _iylq4q0i.Challenge => 'Challenge',
      _igs032ca.ChallengeDifficulty => 'ChallengeDifficulty',
      _ilptq4di.Answer => 'Answer',
      _iq8f7lpk.AnswerFeedback => 'AnswerFeedback',
      _i9r9cihw.AnswerEvaluated => 'AnswerEvaluated',
      _i9r9cihw.AnswerReceived => 'AnswerReceived',
      _i9r9cihw.InterviewFinished => 'InterviewFinished',
      _i9r9cihw.InterviewNotice => 'InterviewNotice',
      _i9r9cihw.QuestionAsked => 'QuestionAsked',
      _i9r9cihw.ScoreUpdate => 'ScoreUpdate',
      _ipbu4009.AnswerChunk => 'AnswerChunk',
      _ipbu4009.AnswerSubmitted => 'AnswerSubmitted',
      _ipbu4009.EndInterview => 'EndInterview',
      _ix0gec48.InterviewAccessException => 'InterviewAccessException',
      _ihpfwdr6.InterviewReport => 'InterviewReport',
      _i0s2zm9r.InterviewScores => 'InterviewScores',
      _illbuy7a.InterviewSession => 'InterviewSession',
      _ifyqp54v.InterviewStatus => 'InterviewStatus',
      _ihpdvrxq.Question => 'Question',
      _i8405n7p.QuestionCategory => 'QuestionCategory',
      _i4trz3o8.CandidateProfile => 'CandidateProfile',
      _izdd6kyx.ExtractedSkill => 'ExtractedSkill',
      _ivs53uxk.ParsedResume => 'ParsedResume',
      _ipkmgecw.Resume => 'Resume',
      _iqo5w92k.ResumeException => 'ResumeException',
      _imejjlr6.ResumeParseStatus => 'ResumeParseStatus',
      _ieef7w2g.ResumeUploadTicket => 'ResumeUploadTicket',
      _iq8k1g78.WorkExperience => 'WorkExperience',
      _ifilxtcy.SkillNode => 'SkillNode',
      _ioq46cla.SkillProfile => 'SkillProfile',
      _i7w5oxf5.Weakness => 'Weakness',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'interview_arena.',
        '',
      );
    }

    switch (data) {
      case _i8uejmxn.SignUpClosedException():
        return 'SignUpClosedException';
      case _iylq4q0i.Challenge():
        return 'Challenge';
      case _igs032ca.ChallengeDifficulty():
        return 'ChallengeDifficulty';
      case _ilptq4di.Answer():
        return 'Answer';
      case _iq8f7lpk.AnswerFeedback():
        return 'AnswerFeedback';
      case _i9r9cihw.AnswerEvaluated():
        return 'AnswerEvaluated';
      case _i9r9cihw.AnswerReceived():
        return 'AnswerReceived';
      case _i9r9cihw.InterviewFinished():
        return 'InterviewFinished';
      case _i9r9cihw.InterviewNotice():
        return 'InterviewNotice';
      case _i9r9cihw.QuestionAsked():
        return 'QuestionAsked';
      case _i9r9cihw.ScoreUpdate():
        return 'ScoreUpdate';
      case _ipbu4009.AnswerChunk():
        return 'AnswerChunk';
      case _ipbu4009.AnswerSubmitted():
        return 'AnswerSubmitted';
      case _ipbu4009.EndInterview():
        return 'EndInterview';
      case _ix0gec48.InterviewAccessException():
        return 'InterviewAccessException';
      case _ihpfwdr6.InterviewReport():
        return 'InterviewReport';
      case _i0s2zm9r.InterviewScores():
        return 'InterviewScores';
      case _illbuy7a.InterviewSession():
        return 'InterviewSession';
      case _ifyqp54v.InterviewStatus():
        return 'InterviewStatus';
      case _ihpdvrxq.Question():
        return 'Question';
      case _i8405n7p.QuestionCategory():
        return 'QuestionCategory';
      case _i4trz3o8.CandidateProfile():
        return 'CandidateProfile';
      case _izdd6kyx.ExtractedSkill():
        return 'ExtractedSkill';
      case _ivs53uxk.ParsedResume():
        return 'ParsedResume';
      case _ipkmgecw.Resume():
        return 'Resume';
      case _iqo5w92k.ResumeException():
        return 'ResumeException';
      case _imejjlr6.ResumeParseStatus():
        return 'ResumeParseStatus';
      case _ieef7w2g.ResumeUploadTicket():
        return 'ResumeUploadTicket';
      case _iq8k1g78.WorkExperience():
        return 'WorkExperience';
      case _ifilxtcy.SkillNode():
        return 'SkillNode';
      case _ioq46cla.SkillProfile():
        return 'SkillProfile';
      case _i7w5oxf5.Weakness():
        return 'Weakness';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'SignUpClosedException') {
      return deserialize<_i8uejmxn.SignUpClosedException>(data['data']);
    }
    if (dataClassName == 'Challenge') {
      return deserialize<_iylq4q0i.Challenge>(data['data']);
    }
    if (dataClassName == 'ChallengeDifficulty') {
      return deserialize<_igs032ca.ChallengeDifficulty>(data['data']);
    }
    if (dataClassName == 'Answer') {
      return deserialize<_ilptq4di.Answer>(data['data']);
    }
    if (dataClassName == 'AnswerFeedback') {
      return deserialize<_iq8f7lpk.AnswerFeedback>(data['data']);
    }
    if (dataClassName == 'AnswerEvaluated') {
      return deserialize<_i9r9cihw.AnswerEvaluated>(data['data']);
    }
    if (dataClassName == 'AnswerReceived') {
      return deserialize<_i9r9cihw.AnswerReceived>(data['data']);
    }
    if (dataClassName == 'InterviewFinished') {
      return deserialize<_i9r9cihw.InterviewFinished>(data['data']);
    }
    if (dataClassName == 'InterviewNotice') {
      return deserialize<_i9r9cihw.InterviewNotice>(data['data']);
    }
    if (dataClassName == 'QuestionAsked') {
      return deserialize<_i9r9cihw.QuestionAsked>(data['data']);
    }
    if (dataClassName == 'ScoreUpdate') {
      return deserialize<_i9r9cihw.ScoreUpdate>(data['data']);
    }
    if (dataClassName == 'AnswerChunk') {
      return deserialize<_ipbu4009.AnswerChunk>(data['data']);
    }
    if (dataClassName == 'AnswerSubmitted') {
      return deserialize<_ipbu4009.AnswerSubmitted>(data['data']);
    }
    if (dataClassName == 'EndInterview') {
      return deserialize<_ipbu4009.EndInterview>(data['data']);
    }
    if (dataClassName == 'InterviewAccessException') {
      return deserialize<_ix0gec48.InterviewAccessException>(data['data']);
    }
    if (dataClassName == 'InterviewReport') {
      return deserialize<_ihpfwdr6.InterviewReport>(data['data']);
    }
    if (dataClassName == 'InterviewScores') {
      return deserialize<_i0s2zm9r.InterviewScores>(data['data']);
    }
    if (dataClassName == 'InterviewSession') {
      return deserialize<_illbuy7a.InterviewSession>(data['data']);
    }
    if (dataClassName == 'InterviewStatus') {
      return deserialize<_ifyqp54v.InterviewStatus>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_ihpdvrxq.Question>(data['data']);
    }
    if (dataClassName == 'QuestionCategory') {
      return deserialize<_i8405n7p.QuestionCategory>(data['data']);
    }
    if (dataClassName == 'CandidateProfile') {
      return deserialize<_i4trz3o8.CandidateProfile>(data['data']);
    }
    if (dataClassName == 'ExtractedSkill') {
      return deserialize<_izdd6kyx.ExtractedSkill>(data['data']);
    }
    if (dataClassName == 'ParsedResume') {
      return deserialize<_ivs53uxk.ParsedResume>(data['data']);
    }
    if (dataClassName == 'Resume') {
      return deserialize<_ipkmgecw.Resume>(data['data']);
    }
    if (dataClassName == 'ResumeException') {
      return deserialize<_iqo5w92k.ResumeException>(data['data']);
    }
    if (dataClassName == 'ResumeParseStatus') {
      return deserialize<_imejjlr6.ResumeParseStatus>(data['data']);
    }
    if (dataClassName == 'ResumeUploadTicket') {
      return deserialize<_ieef7w2g.ResumeUploadTicket>(data['data']);
    }
    if (dataClassName == 'WorkExperience') {
      return deserialize<_iq8k1g78.WorkExperience>(data['data']);
    }
    if (dataClassName == 'SkillNode') {
      return deserialize<_ifilxtcy.SkillNode>(data['data']);
    }
    if (dataClassName == 'SkillProfile') {
      return deserialize<_ioq46cla.SkillProfile>(data['data']);
    }
    if (dataClassName == 'Weakness') {
      return deserialize<_i7w5oxf5.Weakness>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('interview_arena', this);
    _iacc.Protocol().registerHostProtocol('interview_arena', this);
  }

  @override
  String getModuleName() => 'interview_arena';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
