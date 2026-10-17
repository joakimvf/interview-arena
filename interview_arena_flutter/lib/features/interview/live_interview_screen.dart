import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_arena_client/interview_arena_client.dart';

import '../../core/client_providers.dart';
import 'interview_feedback.dart';
import 'interview_voice.dart';
import 'live_interview_controller.dart';
import 'score_widgets.dart';

class LiveInterviewScreen extends ConsumerStatefulWidget {
  const LiveInterviewScreen({super.key, required this.interviewSessionId});
  final int interviewSessionId;

  @override
  ConsumerState<LiveInterviewScreen> createState() =>
      _LiveInterviewScreenState();
}

class _LiveInterviewScreenState extends ConsumerState<LiveInterviewScreen> {
  final _answer = TextEditingController();
  late final InterviewVoice _voice;

  /// Speaking (default) or typing answers.
  var _voiceMode = true;

  /// The candidate tapped "Start"; that tap also lets the browser play audio.
  var _begun = false;
  var _shownAt = DateTime.now();
  var _lastPartialAt = DateTime.fromMillisecondsSinceEpoch(0);

  /// The server scores a partial answer at most every 15 s; sending more
  /// often than this only adds traffic it throws away.
  static const _partialEvery = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _voice = InterviewVoice(
      ref.read(clientProvider),
      onTranscript: (t) {
        _answer.text = t;
        _onTyped(t);
      },
    )..addListener(_onVoiceChanged);
  }

  @override
  void dispose() {
    _voice
      ..removeListener(_onVoiceChanged)
      ..dispose();
    _answer.dispose();
    super.dispose();
  }

  void _onVoiceChanged() {
    if (!mounted) return;
    if (_voiceMode && !_voice.micAvailable) {
      _voiceMode = false;
      _controller.setVoiceMode(enabled: false);
      _snack('Microphone unavailable here, so you can type your answers.');
    }
    setState(() {});
  }

  LiveInterviewController get _controller =>
      ref.read(liveInterviewProvider(widget.interviewSessionId).notifier);

  LiveInterviewState get _state =>
      ref.read(liveInterviewProvider(widget.interviewSessionId));

  void _onTyped(String text) {
    final now = DateTime.now();
    if (now.difference(_lastPartialAt) < _partialEvery) return;
    _lastPartialAt = now;
    _controller.partial(text);
  }

  void _begin({required bool voice}) {
    setState(() {
      _begun = true;
      _voiceMode = voice;
    });
    _controller.setVoiceMode(enabled: voice);
    final q = _state.question;
    if (voice && q != null && !_state.awaitingNext) _voice.ask(q.questionId);
  }

  Future<void> _doneSpeaking() async {
    final text = await _voice.finishAnswer();
    if (text.isEmpty) {
      _snack('I didn\'t catch an answer. Keep talking, or switch to typing.');
      await _voice.keepListening();
      return;
    }
    _controller.submit(text, DateTime.now().difference(_shownAt));
  }

  void _submitTyped() {
    final ok = _controller.submit(
      _answer.text,
      DateTime.now().difference(_shownAt),
    );
    if (!ok && _answer.text.trim().isEmpty) {
      _snack('Write an answer first.');
    }
  }

  Future<void> _toTyping() async {
    await _voice.stop();
    setState(() => _voiceMode = false);
    _controller.setVoiceMode(enabled: false);
  }

  void _toVoice() {
    setState(() => _voiceMode = true);
    _controller.setVoiceMode(enabled: true);
    if (!_state.awaitingNext) _voice.listenFrom(_answer.text);
  }

  Future<void> _confirmEnd() async {
    final end = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End the interview?'),
        content: const Text(
          'You will get your feedback for the answers given so far.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep going'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('End interview'),
          ),
        ],
      ),
    );
    if (end ?? false) {
      await _voice.stop();
      _controller.end();
    }
  }

  void _snack(String message) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));

  static String _noticeText(InterviewNotice n) => switch (n.code) {
    'partial_score_failed' => 'Live scoring is briefly unavailable.',
    'evaluation_failed' =>
      'That answer could not be scored. The interview continues.',
    'stale_question' => 'That answer was for an earlier question.',
    _ => 'Something went wrong, but the interview continues.',
  };

  @override
  Widget build(BuildContext context) {
    final provider = liveInterviewProvider(widget.interviewSessionId);
    final s = ref.watch(provider);
    // Recognize answers in the interview language (from the CV).
    _voice.localeId = s.language;

    ref.listen(provider.select((s) => s.question?.questionId), (prev, next) {
      if (next == null || next == prev) return;
      _answer.clear();
      _shownAt = DateTime.now();
      if (_begun && _voiceMode) _voice.ask(next);
    });
    ref.listen(provider.select((s) => s.status), (prev, next) {
      if (next == LiveStatus.finished || next == LiveStatus.failed) {
        _voice.stop();
      }
    });
    ref.listen(provider.select((s) => s.notice), (prev, next) {
      if (next != null && !identical(prev, next)) _snack(_noticeText(next));
    });

    final q = s.question;
    final max = s.maxQuestions;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Leave (you can resume later)',
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/'),
        ),
        title: Text(s.targetRole ?? 'Interview'),
        actions: [
          if (s.status == LiveStatus.live)
            TextButton(onPressed: _confirmEnd, child: const Text('End')),
        ],
        bottom: q != null && max != null && s.status == LiveStatus.live
            ? PreferredSize(
                preferredSize: const Size.fromHeight(3),
                child: LinearProgressIndicator(
                  value: ((q.orderIndex + 1) / max).clamp(0, 1),
                  minHeight: 3,
                ),
              )
            : null,
      ),
      body: switch (s.status) {
        LiveStatus.connecting => const _Centered(
          icon: null,
          message: 'Connecting to your interviewer…',
        ),
        LiveStatus.failed => _Centered(
          icon: Icons.wifi_off,
          message: s.resumable
              ? 'The connection dropped. Your answers so far are saved.'
              : 'This interview can\'t be opened.',
          actions: [
            if (s.resumable)
              FilledButton(
                onPressed: _controller.reconnect,
                child: const Text('Reconnect'),
              ),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('Back to home'),
            ),
          ],
        ),
        LiveStatus.finished => _ResultsView(
          state: s,
          interviewSessionId: widget.interviewSessionId,
        ),
        LiveStatus.live when !_begun => _ReadyGate(
          onVoice: () => _begin(voice: true),
          onType: () => _begin(voice: false),
        ),
        LiveStatus.live => LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 900;
            final column = _voiceMode
                ? _VoiceStage(
                    state: s,
                    voice: _voice,
                    showStrip: !wide,
                    onDone: _doneSpeaking,
                    onReplay: () {
                      if (s.question case final q?) _voice.replay(q.questionId);
                    },
                    onType: _toTyping,
                  )
                : _TypingStage(
                    state: s,
                    showStrip: !wide,
                    answer: _answer,
                    onTyped: _onTyped,
                    onVoice: _voice.micAvailable ? _toVoice : null,
                    onSubmit: _submitTyped,
                  );
            if (!wide) return column;
            return Row(
              children: [
                Expanded(child: column),
                const VerticalDivider(width: 1),
                SizedBox(width: 380, child: _ScoresPanel(state: s)),
              ],
            );
          },
        ),
      },
    );
  }
}

class _Centered extends StatelessWidget {
  const _Centered({required this.icon, required this.message, this.actions});
  final IconData? icon;
  final String message;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon == null)
              const CircularProgressIndicator()
            else
              Icon(icon, size: 48),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            if (actions != null) ...[
              const SizedBox(height: 16),
              Wrap(spacing: 8, children: actions!),
            ],
          ],
        ),
      ),
    );
  }
}

/// One tap before the interview starts: browsers only play audio and ask for
/// the microphone after a user gesture.
class _ReadyGate extends StatelessWidget {
  const _ReadyGate({required this.onVoice, required this.onType});
  final VoidCallback onVoice;
  final VoidCallback onType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.record_voice_over_outlined,
                size: 56,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Ready for your interview?',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your interviewer will ask each question out loud. Answer by '
                'speaking, then tap "Done answering". You\'ll get full '
                'feedback when the interview ends.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
                onPressed: onVoice,
                icon: const Icon(Icons.mic),
                label: const Text('Start speaking'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: onType,
                child: const Text('Type my answers instead'),
              ),
              const SizedBox(height: 8),
              Text(
                'Your browser will ask for microphone access.',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionHeader extends StatelessWidget {
  const _QuestionHeader({required this.question, required this.max});
  final QuestionAsked question;
  final int? max;

  @override
  Widget build(BuildContext context) {
    final q = question;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Chip(
          avatar: Icon(Icons.support_agent, size: 18),
          label: Text('Interviewer'),
          visualDensity: VisualDensity.compact,
        ),
        Chip(
          label: Text(categoryLabel(q.category)),
          visualDensity: VisualDensity.compact,
        ),
        if (q.isFollowUp)
          const Chip(
            label: Text('Follow-up'),
            visualDensity: VisualDensity.compact,
          ),
        Text(
          max == null
              ? 'Question ${q.orderIndex + 1}'
              : 'Question ${q.orderIndex + 1} of $max',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}

/// Live scores (compact) and the collapsed last-answer feedback, shared by
/// both answer modes.
class _LiveExtras extends StatelessWidget {
  const _LiveExtras({required this.state, required this.showStrip});
  final LiveInterviewState state;
  final bool showStrip;

  @override
  Widget build(BuildContext context) {
    final stripScores = state.partialScores ?? state.scores;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showStrip && stripScores != null) ...[
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.partialScores != null
                        ? 'Live estimate'
                        : 'Average so far',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  ScoreStrip(scores: stripScores),
                ],
              ),
            ),
          ),
        ],
        if (state.lastFeedback case final f?) ...[
          const SizedBox(height: 16),
          _FeedbackCard(feedback: f, question: state.lastFeedbackQuestion),
        ],
      ],
    );
  }
}

/// Spoken interview: the orb shows who is talking, the question is the
/// caption, and the live transcript shows what was heard.
class _VoiceStage extends StatelessWidget {
  const _VoiceStage({
    required this.state,
    required this.voice,
    required this.showStrip,
    required this.onDone,
    required this.onReplay,
    required this.onType,
  });

  final LiveInterviewState state;
  final InterviewVoice voice;
  final bool showStrip;
  final VoidCallback onDone;
  final VoidCallback onReplay;
  final VoidCallback onType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final q = state.question;
    final phase = state.awaitingNext ? VoicePhase.waiting : voice.phase;
    final status = switch (phase) {
      VoicePhase.preparing => 'Your interviewer is about to ask…',
      VoicePhase.speaking => 'Interviewer is speaking…',
      VoicePhase.listening => 'Listening… tap "Done answering" when finished',
      VoicePhase.waiting => 'Thinking about your answer…',
      VoicePhase.off => '',
    };
    final listening = phase == VoicePhase.listening;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
            children: [
              if (q != null)
                _QuestionHeader(question: q, max: state.maxQuestions),
              const SizedBox(height: 32),
              Center(child: _VoiceOrb(phase: phase)),
              const SizedBox(height: 12),
              Text(
                status,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              if (q != null)
                Text(
                  q.prompt,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
              if (voice.transcript.isNotEmpty) ...[
                const SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('You', style: theme.textTheme.labelMedium),
                        const SizedBox(height: 4),
                        Text(
                          voice.transcript,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (!voice.interviewerVoiceAvailable) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.volume_off, size: 18, color: scheme.outline),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'The interviewer\'s voice is off (no ElevenLabs key on '
                        'the server), so questions are shown as text.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ],
              _LiveExtras(state: state, showStrip: showStrip),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.outlined(
                      tooltip: 'Hear the question again',
                      onPressed:
                          voice.interviewerVoiceAvailable &&
                              !state.awaitingNext &&
                              voice.phase != VoicePhase.preparing
                          ? onReplay
                          : null,
                      icon: const Icon(Icons.replay),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(220, 52),
                      ),
                      onPressed: listening ? onDone : null,
                      icon: const Icon(Icons.check),
                      label: const Text('Done answering'),
                    ),
                    const SizedBox(width: 12),
                    IconButton.outlined(
                      tooltip: 'Type instead',
                      onPressed: onType,
                      icon: const Icon(Icons.keyboard_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Scores and feedback are AI-generated and can be wrong.',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Pulsing circle: interviewer talking (wave), listening (mic), or busy.
class _VoiceOrb extends StatefulWidget {
  const _VoiceOrb({required this.phase});
  final VoicePhase phase;

  @override
  State<_VoiceOrb> createState() => _VoiceOrbState();
}

class _VoiceOrbState extends State<_VoiceOrb>
    with SingleTickerProviderStateMixin {
  late final _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
    lowerBound: 0.94,
    upperBound: 1.08,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (color, onColor, child) = switch (widget.phase) {
      VoicePhase.speaking => (
        scheme.primary,
        scheme.onPrimary,
        const Icon(Icons.graphic_eq, size: 48) as Widget,
      ),
      VoicePhase.listening => (
        scheme.error,
        scheme.onError,
        const Icon(Icons.mic, size: 48) as Widget,
      ),
      _ => (
        scheme.surfaceContainerHighest,
        scheme.onSurfaceVariant,
        const SizedBox.square(
              dimension: 36,
              child: CircularProgressIndicator(strokeWidth: 3),
            )
            as Widget,
      ),
    };
    final active =
        widget.phase == VoicePhase.speaking ||
        widget.phase == VoicePhase.listening;
    final orb = Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          if (active)
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 32,
              spreadRadius: 4,
            ),
        ],
      ),
      child: IconTheme(
        data: IconThemeData(color: onColor),
        child: Center(child: child),
      ),
    );
    return active ? ScaleTransition(scale: _pulse, child: orb) : orb;
  }
}

/// Typing fallback: question on top, answer box docked at the bottom.
class _TypingStage extends StatelessWidget {
  const _TypingStage({
    required this.state,
    required this.showStrip,
    required this.answer,
    required this.onTyped,
    required this.onVoice,
    required this.onSubmit,
  });

  final LiveInterviewState state;
  final bool showStrip;
  final TextEditingController answer;
  final ValueChanged<String> onTyped;
  final VoidCallback? onVoice;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final q = state.question;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
            children: [
              if (q != null) ...[
                _QuestionHeader(question: q, max: state.maxQuestions),
                const SizedBox(height: 20),
                Text(
                  q.prompt,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
              ],
              if (state.awaitingNext) ...[
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Answer received. Preparing what comes next…',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
              _LiveExtras(state: state, showStrip: showStrip),
            ],
          ),
        ),
        _Composer(
          controller: answer,
          enabled:
              state.status == LiveStatus.live &&
              q != null &&
              !state.awaitingNext,
          onChanged: onTyped,
          onVoice: onVoice,
          onSubmit: onSubmit,
        ),
      ],
    );
  }
}

/// Bottom-docked answer box (Fitbit Coach / Mindvalley).
class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.enabled,
    required this.onChanged,
    required this.onVoice,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String> onChanged;
  final VoidCallback? onVoice;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CallbackShortcuts(
                        bindings: {
                          const SingleActivator(
                            LogicalKeyboardKey.enter,
                            meta: true,
                          ): onSubmit,
                          const SingleActivator(
                            LogicalKeyboardKey.enter,
                            control: true,
                          ): onSubmit,
                        },
                        child: TextField(
                          controller: controller,
                          enabled: enabled,
                          onChanged: onChanged,
                          minLines: 1,
                          maxLines: 6,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: enabled
                                ? 'Type your answer'
                                : 'Waiting for the interviewer…',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Answer by voice',
                      onPressed: enabled ? onVoice : null,
                      icon: const Icon(Icons.mic_none),
                    ),
                    const SizedBox(width: 4),
                    IconButton.filled(
                      tooltip: 'Submit answer (⌘/Ctrl + Enter)',
                      onPressed: enabled ? onSubmit : null,
                      icon: const Icon(Icons.arrow_upward),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Scores and feedback are AI-generated and can be wrong.',
              style: theme.textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Last answer's feedback, collapsed until tapped; the full feedback comes
/// at the end.
class _FeedbackCard extends StatelessWidget {
  const _FeedbackCard({required this.feedback, this.question});
  final AnswerFeedback feedback;
  final String? question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: const Icon(Icons.lightbulb_outline),
        title: const Text('Feedback on your last answer'),
        subtitle: question == null
            ? null
            : Text(question!, maxLines: 1, overflow: TextOverflow.ellipsis),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(feedback.summary, style: theme.textTheme.bodyMedium),
          for (final s in feedback.strengths)
            Bullet(
              icon: Icons.check_circle,
              color: Colors.green.shade600,
              text: s,
            ),
          for (final s in feedback.improvements)
            Bullet(
              icon: Icons.trending_up,
              color: Colors.amber.shade800,
              text: s,
            ),
        ],
      ),
    );
  }
}

class _ScoresPanel extends StatelessWidget {
  const _ScoresPanel({required this.state});
  final LiveInterviewState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scores = state.partialScores ?? state.scores;
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          state.partialScores != null ? 'Live estimate' : 'Average so far',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          state.partialScores != null
              ? 'Updates while you answer.'
              : 'Across your evaluated answers.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        if (scores == null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Text(
              'Scores appear once you start answering.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          )
        else ...[
          SizedBox(height: 260, child: ScoreRadar(scores: scores)),
          const SizedBox(height: 16),
          ScoreBars(scores: scores),
        ],
      ],
    );
  }
}

/// End of interview: score, verdict, highlights, whole-interview feedback,
/// then a collapsed question-by-question breakdown.
class _ResultsView extends StatelessWidget {
  const _ResultsView({required this.state, required this.interviewSessionId});
  final LiveInterviewState state;
  final int interviewSessionId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final f = state.finished!;
    final scores = f.scores;
    final overall = f.overallScore;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: overall == null
                  ? const Icon(Icons.hourglass_empty, size: 64)
                  : ScoreGauge(score: overall),
            ),
            const SizedBox(height: 16),
            Text(
              overall == null ? 'No score this time' : verdictFor(overall),
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            if (state.targetRole case final role?)
              Text(
                role,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            if (scores != null) ...[
              const SizedBox(height: 24),
              _Highlights(scores: scores),
            ],
            const SizedBox(height: 16),
            if (f.report case final report?)
              ReportSections(report: report)
            else
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(f.summary, style: theme.textTheme.bodyMedium),
                ),
              ),
            if (scores != null) ...[
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Score breakdown',
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 260, child: ScoreRadar(scores: scores)),
                      ScoreBars(scores: scores),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            QuestionBreakdown(interviewSessionId: interviewSessionId),
            const SizedBox(height: 24),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: () => context.go('/'),
              child: const Text('Back to home'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Strongest metric and growth area side by side (Ahead-style highlights).
class _Highlights extends StatelessWidget {
  const _Highlights({required this.scores});
  final InterviewScores scores;

  @override
  Widget build(BuildContext context) {
    final values = metricValues(scores);
    var best = 0, worst = 0;
    for (var i = 1; i < values.length; i++) {
      if (values[i] > values[best]) best = i;
      if (values[i] < values[worst]) worst = i;
    }
    final text = Theme.of(context).textTheme;
    Widget tile(String title, int i) => Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: text.labelLarge),
              const SizedBox(height: 8),
              Text(metricLabels[i], style: text.titleMedium),
              const SizedBox(height: 8),
              ScoreBadge(score: values[i]),
            ],
          ),
        ),
      ),
    );
    return Row(
      children: [tile('Strongest', best), tile('Growth area', worst)],
    );
  }
}
