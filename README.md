# Interview Arena

An AI interview coach you actually talk to. The interviewer asks questions out loud, follows up on your CV and on what you just said, scores you while you're answering, and gives you honest feedback when the interview is over.

Built with Flutter and Serverpod 4 for the Serverpod hackathon.

## Try it

1. Go to https://interview-arena.serverpod.space
2. Log in with `jury@interview-arena.app`
3. The password is in the project description on BuilderBase

Sign-up is closed on the live app on purpose. Every interview calls Claude and ElevenLabs, and we don't want random people draining the API credits.

Use Chrome, Edge or Safari (speech recognition doesn't work in Firefox) and allow the microphone when the browser asks. No CV handy? There's a made-up one in [`samples/sample-cv.pdf`](samples/sample-cv.pdf).

## The problem

Preparing for interviews on your own is hard. Most tools are either question banks or a chatbot you type to, and neither feels like a real interview. You also rarely find out what you're actually weak at.

We wanted something closer to the real thing: someone asks you questions out loud, digs into your answers, and tells you how it went.

## How it works

Upload your CV and Claude pulls out your skills and experience. Pick the role you're interviewing for and start.

The interviewer reads each question out loud. You answer by talking, and you can see your transcript and five scores (communication, confidence, technical depth, completeness, structure) update while you're still answering. Questions adapt to your CV and to what you already said, so a vague answer gets a follow-up.

When it's over you get an overall score, what went well, what to improve and topics to study next, plus a breakdown of every question with your answer and its feedback.

### Multiple languages

The interview follows the language of your CV. Claude detects it when it parses the CV and runs the whole interview in that language, ElevenLabs speaks the questions in it, and speech-to-text listens in it too, so your answers come out in the right language. The feedback and suggested roles follow along. We've tried it with English, Swedish and Spanish. Other languages should work as long as your browser's speech recognition and ElevenLabs support them, but we haven't tested them.

## How we use Serverpod

The whole backend is Serverpod 4, hosted on Serverpod Cloud.

- **Streaming methods.** The interview is one bidirectional stream (`InterviewEndpoint.conduct`). The app streams answer chunks and "done answering" up, and the server streams questions, live scores, evaluations and the final report down. Both directions are sealed classes defined in `.spy.yaml`, so each side switches over typed events. If the connection drops, reconnecting picks up where you left off.
- **Models and ORM.** Four tables (resumes, interview sessions, questions, answers) with relations and cascading deletes. Parsed CVs, scores and feedback are stored as jsonb.
- **Auth.** Email auth from `serverpod_auth_idp`. On deployed servers sign-up is blocked in the endpoint, and the admin and jury accounts are created at startup from Serverpod Cloud passwords, so no credentials live in the repo.
- **File uploads.** CV PDFs go to private cloud storage through upload descriptions. The server checks the upload and parses the CV in the background, since that can take longer than a normal request; the app polls until it's done.
- **Web server.** The server also serves the Flutter web app, plus a small route that tells the app which API URL to use.
- **Serverpod Cloud.** Hosting, managed Postgres and passwords for the API keys.
- **Tests.** Integration tests with `serverpod_test` against the embedded Postgres, including an end-to-end test that drives the real generated client over the websocket.

## AI we use

- **Claude**, with a model sized to each job:
  - `claude-sonnet-5-5` asks the questions, evaluates each answer and writes the final feedback.
  - `claude-haiku-5-5` gives the live scores while you answer (cheap and fast, since it runs every few seconds) and parses the CV.
- **ElevenLabs** (`eleven_v4_turbo`) is the interviewer's voice. The server calls it, so the key never reaches the app, and only in voice mode.
- **Speech-to-text** runs in the browser/OS through the `speech_to_text` package.
- **Claude Code** helped us build it, as our AI coding assistant.

## Run it yourself

You need Flutter 3.44+ and the Serverpod CLI 4.0.4 (`dart install serverpod_cli`).

```bash
git clone https://github.com/joakimvf/interview-arena.git
cd interview-arena/interview_arena_server
cp config/passwords.example.yaml config/passwords.yaml
```

Fill in `config/passwords.yaml`: any random strings for the secrets, your own Anthropic key, and an ElevenLabs key if you want the voice. Then:

```bash
serverpod start
```

That starts the server, a local Postgres (no Docker needed) and the app in your browser. Locally sign-up is open, and the verification code shows up in the server log.

Run the tests with `dart test` in `interview_arena_server`.

We've mainly tested it in Chrome on desktop. The app also has the iOS and macOS permissions set up, but we haven't run it on those yet.

## Project layout

- `interview_arena_server`: the Serverpod server (endpoints, models, Claude/ElevenLabs clients)
- `interview_arena_client`: the generated client
- `interview_arena_flutter`: the Flutter app
