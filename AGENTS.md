# Flutter & Serverpod project

This project is a Flutter app (frontend) backed by a Serverpod server (backend). Always build the app's backend with Serverpod.
Build for multiple users, use Serverpod's built-in authentication, which is already set up in `lib/server.dart`.

The user starts the server and Flutter app with `serverpod start`. There is no need to check if the server is running: make the changes and call the `serverpod` MCP tools as needed. If the server is not running, an informative error message will be received from the MCP server. Then STOP and ask the user to start it. NEVER start the server yourself. The Flutter app is started along with it, or can be launched from the MCP tool `spawn_flutter_app`.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload both the server and the Flutter app.

Calling `serverpod generate` directly is not needed, but might be useful to troubleshoot when an incremental generation fails.

ALWAYS use the MCP server instead of the command line. Use the MCP server to:

- `create_migration` and `apply_migrations` for database (after you change data models).
- `create_repair_migration` if the database has drifted out of sync with the migrations.
- `tail_server_logs` to read logs from the server.
- `tail_flutter_logs` to read the raw stdout/stderr of the Flutter app.
- `hot_reload` / `hot_restart` to reload or restart the server and the Flutter app. ALWAYS call `hot_restart` after doing changes in the Flutter app that may not work with normal hot reload (which is automatically applied).
- `spawn_flutter_app` to start a Flutter app declared under `serverpod: flutter_apps:` in the server `pubspec.yaml`.
- `get_flutter_app_dtd` (Dart tooling daemon) for connecting to the app through the `dart` MCP.

NEVER edit generated code. The server's `lib/src/generated/` directory and the whole `interview_arena_client` package are rewritten by the code generator. Change the `.spy.yaml` models, the endpoints, or `lib/server.dart` instead.

Migrations are a narrow exception: the `migration.sql` of a generated migration MAY be edited by hand when the generated SQL would lose data — to add a data transformation, or to reach a destructive change through non-destructive steps. Never touch the other files in the migration directory, and keep the schema the SQL ends up with identical to `definition.sql` — new databases are created from that file and never run `migration.sql`.

Only when the server cannot be started at all, fall back to the CLI in the server package:

- `serverpod generate` to regenerate the client and the generated server code.
- `serverpod create-migration` after changing a model with a `table` (add `--force` for destructive changes). It only writes the migration; `serverpod start` applies pending migrations when it boots the server.

Tests need no Docker. `config/test.yaml` sets `database.dataPath`, so Serverpod starts and manages the test database (an embedded PostgreSQL) itself, and the project's `docker-compose.yaml` is not used for it. Just run `dart test` in the server package.

Checklist after doing changes, in this order:

- `dart analyze` (CLI)
- `dart format` (CLI)
- `create_migration` and `apply_migrations` (MCP - only if necessary)
- Do `serverpod` MCP `hot_restart` if required (hot reload is done automatically). Will also hot restart Flutter app
- Run tests, if applicable (`dart test` in the server package)
- Check `serverpod` MCP `tail_server_logs` and `tail_flutter_logs` for any issues.

If the user asks you to test the app:

1. Use `get_flutter_app_dtd` (`serverpod` MCP) to get the Flutter app's DTD
2. Pass the DTD to `connect_dart_tooling_daemon` (`dart` MCP) to connect to the app
3. Use `flutter_driver` (`dart` MCP) to navigate through the app

The app is launched from `interview_arena_flutter/lib/driver.dart`, which starts the Flutter driver extension with text entry emulation turned off so the app stays usable by hand. To let the driver type, set `enableTextEntryEmulation: true` there and `hot_restart` the app.

## About this app: Interview Arena (proof of concept)

An AI interview-prep app. A user signs up (email IdP), uploads a resume PDF that Claude parses, then runs a live mock interview: Claude asks adaptive questions and scores answers on five metrics (communication, confidence, technical depth, completeness, structure) while the candidate types or speaks.

Server (`interview_arena_server/lib/src/`), one folder per feature:

- `resume/`: upload (`createUpload` -> `FileUploader` -> `completeUpload`), then `ResumeEndpoint.parse` parses the PDF in the background (`runInBackground` in `background.dart`: in-process, its own session). Clients poll `getResume`, because a parse can take longer than the 20 s client call timeout. The app has no future calls; `futureCall.enabled` is false in every config.
- `interview/`: `InterviewEndpoint.conduct` is one bidirectional stream. The client sends a sealed `CandidateInput` (`AnswerChunk`, `AnswerSubmitted`, `EndInterview`); the server sends a sealed `InterviewEvent` (`QuestionAsked`, `AnswerReceived`, `ScoreUpdate`, `AnswerEvaluated`, `InterviewNotice`, `InterviewFinished`). The next question is generated in parallel with evaluating the previous answer. Partial answers are scored at most every 15 s and only after 120 new characters.
- Voice: `interview/voice_endpoint.dart` (`questionAudio`) returns each question as MP3 from ElevenLabs (`ai/tts.dart`, model `eleven_v4_turbo`); in voice mode (the client asked for the previous question's audio) the stream prefetches the next question's audio, so typed interviews spend no voice credits. Speech-to-text runs on the device (`speech_to_text`); `features/interview/interview_voice.dart` handles turn-taking.
- End-of-interview feedback: `InterviewReport` (summary, strengths, improvements, focus areas) is written by `InterviewAi.report`, stored on `InterviewSession.report` and sent in `InterviewFinished`.
- `ai/`: raw-HTTP Claude client (`anthropic_client.dart`, non-streaming, with retries; Dart has no official Anthropic SDK) and the routes and prompts (`interview_ai.dart`). Each `ClaudeRoute` picks its own model: `claude-haiku-5-5` for live partial scores and resume parsing, `claude-sonnet-5-5` for questions, answer evaluation and the final report. Haiku routes send no server-side `fallbacks` (Haiku 5.5 has none). Every response's token usage is logged as `claude <route> model=... in=... out=... cacheRead=... cacheWrite=...`. `interviewAiFactory` and `speechSynthesizerFactory` are test seams.

Secrets go in the gitignored `config/passwords.yaml`: `anthropicApiKey` is required for AI features. Sign-up is closed outside the development and test run modes (`lib/src/auth/sign_up_policy.dart`); on deployed servers the `admin` and `jury` accounts are created (or their passwords reset) at every start from the `<name>Email` and `<name>Password` passwords. `elevenLabsApiKey` enables the interviewer's voice (optional `elevenLabsVoiceId`; otherwise the first premade voice is used). Never print secret values.

Flutter (`interview_arena_flutter/lib/`): Riverpod 3 + go_router (pinned below 18). `app/router.dart` guards routes on auth state. Features: `features/auth`, `features/home` (resume card, start interview, history), `features/interview` (live screen, controller owning the stream subscription, score widgets), `features/resume`.

Tests: `dart test` in the server package (unit tests for the Claude request shape; integration tests use `FakeInterviewAi`; `e2e_test.dart` drives the real generated client). `dart run tool/smoke_claude.dart [resume.pdf]` with `ANTHROPIC_API_KEY` set calls every Claude route for real and costs a few cents.
