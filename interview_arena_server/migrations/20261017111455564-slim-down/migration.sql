BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "skill_profile" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "challenge" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "candidate_profile" CASCADE;

--
-- ACTION ALTER TABLE
--
DROP INDEX "answer_user_created_idx";
DROP INDEX "answer_embedding_hnsw_idx";
ALTER TABLE "answer" DROP CONSTRAINT IF EXISTS "answer_fk_1";
ALTER TABLE "answer" DROP CONSTRAINT IF EXISTS "answer_fk_0";
ALTER TABLE "answer" DROP COLUMN "authUserId";
ALTER TABLE "answer" DROP COLUMN "embedding";
ALTER TABLE "answer" DROP COLUMN "embeddingModel";
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "answer"
    ADD CONSTRAINT "answer_fk_0"
    FOREIGN KEY("questionId")
    REFERENCES "question"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR interview_arena
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('interview_arena', '20261017111455564-slim-down', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261017111455564-slim-down', "timestamp" = now();

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
