/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: depend_on_referenced_packages

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:clock/clock.dart' as _io0w16m8;
import 'package:serverpod/serverpod.dart' as _is;
import '../interview/answer_embedding_future_call.dart' as _iizy6vdy;
import '../resume/resume_parse_future_call.dart' as _it0ii81k;
import 'future_calls_generated_models/answer_embedding_future_call_embed_model.dart'
    as _ir28uvix;
import 'future_calls_generated_models/resume_parse_future_call_parse_model.dart'
    as _ifd0qwzd;

/// Invokes a future call.
typedef _InvokeFutureCall =
    Future<void> Function(String name, _is.SerializableModel? object);

extension ServerpodFutureCallsGetter on _is.Serverpod {
  /// Generated future calls.
  FutureCalls get futureCalls => FutureCalls();
}

class FutureCalls extends _is.FutureCallDispatch<_FutureCallRef> {
  FutureCalls._();

  factory FutureCalls() {
    return _instance;
  }

  static final FutureCalls _instance = FutureCalls._();

  _is.FutureCallManager? _futureCallManager;

  String? _serverId;

  String get _effectiveServerId {
    if (_serverId == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _serverId!;
  }

  _is.FutureCallManager get _effectiveFutureCallManager {
    if (_futureCallManager == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _futureCallManager!;
  }

  @override
  void initialize(
    _is.FutureCallManager futureCallManager,
    String serverId,
  ) {
    var registeredFutureCalls = <String, _is.InvokableFutureCall>{
      'AnswerEmbeddingEmbedFutureCall': AnswerEmbeddingEmbedFutureCall(),
      'ResumeParseParseFutureCall': ResumeParseParseFutureCall(),
    };
    _futureCallManager = futureCallManager;
    _serverId = serverId;
    for (final entry in registeredFutureCalls.entries) {
      _futureCallManager?.registerFutureCall(entry.value, entry.key);
    }
  }

  @override
  _FutureCallRef callAtTime(
    DateTime time, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          time,
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _FutureCallRef callWithDelay(
    Duration delay, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          DateTime.now().toUtc().add(delay),
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _is.RecurringFutureCallDispatch<_FutureCallRef> callRecurring({
    String? identifier,
  }) {
    return _RecurringFutureCallDispatchImpl(
      _effectiveFutureCallManager,
      _effectiveServerId,
      identifier,
    );
  }

  @override
  Future<void> cancel(String identifier) async {
    await _effectiveFutureCallManager.cancelFutureCall(identifier);
  }
}

class _RecurringFutureCallDispatchImpl
    extends _is.RecurringFutureCallDispatch<_FutureCallRef> {
  _RecurringFutureCallDispatchImpl(
    this._futureCallManager,
    this._serverId,
    this._identifier,
  );

  final _is.FutureCallManager _futureCallManager;

  final String _serverId;

  final String? _identifier;

  @override
  _FutureCallRef cron(String cronExpression) {
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          _is.Cron.parse(cronExpression).nextTime(),
          _serverId,
          _identifier,
          scheduling: _is.CronFutureCallScheduling(cron: cronExpression),
        );
      },
    );
  }

  @override
  _FutureCallRef every(
    Duration interval, {
    DateTime? start,
  }) {
    final now = _io0w16m8.clock.now().toUtc();
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          start ?? now.add(interval),
          _serverId,
          _identifier,
          scheduling: _is.IntervalFutureCallScheduling(
            interval: interval,
            start: start,
          ),
        );
      },
    );
  }
}

class _FutureCallRef {
  _FutureCallRef(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  late final answerEmbedding = _AnswerEmbeddingFutureCallDispatcher(
    _invokeFutureCall,
  );

  late final resumeParse = _ResumeParseFutureCallDispatcher(_invokeFutureCall);
}

class _AnswerEmbeddingFutureCallDispatcher {
  _AnswerEmbeddingFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> embed(int answerId) {
    var object = _ir28uvix.AnswerEmbeddingFutureCallEmbedModel(
      answerId: answerId,
    );
    return _invokeFutureCall(
      'AnswerEmbeddingEmbedFutureCall',
      object,
    );
  }
}

class _ResumeParseFutureCallDispatcher {
  _ResumeParseFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> parse(int resumeId) {
    var object = _ifd0qwzd.ResumeParseFutureCallParseModel(resumeId: resumeId);
    return _invokeFutureCall(
      'ResumeParseParseFutureCall',
      object,
    );
  }
}

class AnswerEmbeddingEmbedFutureCall
    extends _is.FutureCall<_ir28uvix.AnswerEmbeddingFutureCallEmbedModel>
    implements
        _is.InvokableFutureCall<_ir28uvix.AnswerEmbeddingFutureCallEmbedModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _ir28uvix.AnswerEmbeddingFutureCallEmbedModel? object,
  ) async {
    if (object != null) {
      await _iizy6vdy.AnswerEmbeddingFutureCall().embed(
        session,
        object.answerId,
      );
    }
  }
}

class ResumeParseParseFutureCall
    extends _is.FutureCall<_ifd0qwzd.ResumeParseFutureCallParseModel>
    implements
        _is.InvokableFutureCall<_ifd0qwzd.ResumeParseFutureCallParseModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _ifd0qwzd.ResumeParseFutureCallParseModel? object,
  ) async {
    if (object != null) {
      await _it0ii81k.ResumeParseFutureCall().parse(
        session,
        object.resumeId,
      );
    }
  }
}
