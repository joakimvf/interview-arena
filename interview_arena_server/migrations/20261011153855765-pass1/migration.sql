BEGIN;

--
-- CREATE VECTOR EXTENSION IF AVAILABLE
--
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_available_extensions WHERE name = 'vector') THEN
    EXECUTE 'CREATE EXTENSION IF NOT EXISTS vector';
  ELSE
    RAISE EXCEPTION 'Required extension "vector" is not available on this instance. Please install pgvector. For instructions, see https://docs.serverpod.dev/upgrading/upgrade-to-pgvector.';
  END IF;
END
$$;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "answer" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "questionId" bigint NOT NULL,
    "transcript" text NOT NULL,
    "answerDuration" bigint,
    "scores" jsonb,
    "feedback" jsonb,
    "embedding" vector(1024),
    "embeddingModel" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "answer_question_idx" ON "answer" USING btree ("questionId");
CREATE INDEX "answer_user_created_idx" ON "answer" USING btree ("authUserId", "createdAt");
CREATE INDEX "answer_embedding_hnsw_idx" ON "answer" USING hnsw ("embedding" vector_cosine_ops) WITH (m=16, ef_construction=64);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "candidate_profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "displayName" text,
    "targetRole" text,
    "yearsOfExperience" double precision,
    "timeZone" text NOT NULL DEFAULT 'UTC'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "candidate_profile_auth_user_uidx" ON "candidate_profile" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "scheduledFor" timestamp without time zone NOT NULL,
    "title" text NOT NULL,
    "prompt" text NOT NULL,
    "category" text NOT NULL,
    "difficulty" text NOT NULL DEFAULT 'medium'::text,
    "targetSkills" jsonb NOT NULL,
    "rubric" jsonb,
    "timeLimit" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "challenge_scheduled_for_uidx" ON "challenge" USING btree ("scheduledFor");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "interview_session" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "resumeId" bigint,
    "targetRole" text NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "scores" jsonb,
    "overallScore" double precision,
    "questionCount" bigint NOT NULL DEFAULT 0,
    "maxQuestions" bigint NOT NULL DEFAULT 6,
    "summary" text,
    "startedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "interview_session_user_started_idx" ON "interview_session" USING btree ("authUserId", "startedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "question" (
    "id" bigserial PRIMARY KEY,
    "interviewSessionId" bigint NOT NULL,
    "orderIndex" bigint NOT NULL,
    "category" text NOT NULL,
    "prompt" text NOT NULL,
    "targetSkills" jsonb NOT NULL,
    "isFollowUp" boolean NOT NULL DEFAULT false,
    "askedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "question_session_order_uidx" ON "question" USING btree ("interviewSessionId", "orderIndex");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "resume" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "fileName" text NOT NULL,
    "storagePath" text NOT NULL,
    "sizeBytes" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'awaitingUpload'::text,
    "parsedData" jsonb,
    "parseError" text,
    "parseModel" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "parsedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "resume_auth_user_created_idx" ON "resume" USING btree ("authUserId", "createdAt");
CREATE UNIQUE INDEX "resume_storage_path_uidx" ON "resume" USING btree ("storagePath");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "skill_profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "skillGraph" jsonb NOT NULL,
    "weaknesses" jsonb NOT NULL,
    "strengths" jsonb NOT NULL,
    "averageScores" jsonb,
    "sessionsCompleted" bigint NOT NULL DEFAULT 0,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "skill_profile_auth_user_uidx" ON "skill_profile" USING btree ("authUserId");
CREATE INDEX "skill_profile_graph_gin_idx" ON "skill_profile" USING gin ("skillGraph" jsonb_path_ops);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "answer"
    ADD CONSTRAINT "answer_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "answer"
    ADD CONSTRAINT "answer_fk_1"
    FOREIGN KEY("questionId")
    REFERENCES "question"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "candidate_profile"
    ADD CONSTRAINT "candidate_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "interview_session"
    ADD CONSTRAINT "interview_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "interview_session"
    ADD CONSTRAINT "interview_session_fk_1"
    FOREIGN KEY("resumeId")
    REFERENCES "resume"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "question"
    ADD CONSTRAINT "question_fk_0"
    FOREIGN KEY("interviewSessionId")
    REFERENCES "interview_session"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "resume"
    ADD CONSTRAINT "resume_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "skill_profile"
    ADD CONSTRAINT "skill_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR interview_arena
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('interview_arena', '20261011153855765-pass1', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261011153855765-pass1', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
