BEGIN;

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
CREATE TABLE "exercise_record" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "exercisePublicId" text NOT NULL,
    "name" text NOT NULL,
    "muscleGroup" text NOT NULL,
    "position" bigint NOT NULL,
    "workoutId" uuid NOT NULL
);

-- Indexes
CREATE INDEX "exercise_record_workout_id_idx" ON "exercise_record" USING btree ("workoutId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "set_record" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "publicId" text NOT NULL,
    "repetitions" bigint NOT NULL,
    "weightKg" double precision NOT NULL,
    "position" bigint NOT NULL,
    "exerciseRecordId" uuid NOT NULL
);

-- Indexes
CREATE INDEX "set_record_exercise_record_id_idx" ON "set_record" USING btree ("exerciseRecordId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workout_record" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "publicId" text NOT NULL,
    "trainingDayPublicId" text NOT NULL,
    "title" text NOT NULL,
    "startedAt" timestamp without time zone NOT NULL,
    "completedAt" timestamp without time zone NOT NULL,
    "authUserId" uuid NOT NULL
);

-- Indexes
CREATE INDEX "workout_record_auth_user_id_idx" ON "workout_record" USING btree ("authUserId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "exercise_record"
    ADD CONSTRAINT "exercise_record_fk_0"
    FOREIGN KEY("workoutId")
    REFERENCES "workout_record"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "set_record"
    ADD CONSTRAINT "set_record_fk_0"
    FOREIGN KEY("exerciseRecordId")
    REFERENCES "exercise_record"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "workout_record"
    ADD CONSTRAINT "workout_record_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('backend', '20260910180446643-workout-history', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910180446643-workout-history', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();


COMMIT;
