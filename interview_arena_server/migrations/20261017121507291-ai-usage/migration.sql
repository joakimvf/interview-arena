BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ai_usage" (
    "id" bigserial PRIMARY KEY,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "feature" text NOT NULL,
    "model" text NOT NULL,
    "authUserId" uuid,
    "interviewSessionId" bigint,
    "resumeId" bigint,
    "inputTokens" bigint NOT NULL DEFAULT 0,
    "outputTokens" bigint NOT NULL DEFAULT 0,
    "cacheReadTokens" bigint NOT NULL DEFAULT 0,
    "cacheWriteTokens" bigint NOT NULL DEFAULT 0,
    "characters" bigint NOT NULL DEFAULT 0,
    "costUsd" double precision
);

-- Indexes
CREATE INDEX "ai_usage_created_idx" ON "ai_usage" USING btree ("createdAt");
CREATE INDEX "ai_usage_interview_idx" ON "ai_usage" USING btree ("interviewSessionId");


--
-- MIGRATION VERSION FOR interview_arena
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('interview_arena', '20261017121507291-ai-usage', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261017121507291-ai-usage', "timestamp" = now();

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
