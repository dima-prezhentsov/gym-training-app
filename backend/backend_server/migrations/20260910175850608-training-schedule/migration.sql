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
CREATE TABLE "exercise" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "publicId" text NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "muscleGroup" text NOT NULL,
    "position" bigint NOT NULL,
    "trainingDayId" uuid NOT NULL
);

-- Indexes
CREATE INDEX "exercise_training_day_id_idx" ON "exercise" USING btree ("trainingDayId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "training_day" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "publicId" text NOT NULL,
    "name" text NOT NULL,
    "weekday" bigint NOT NULL,
    "estimatedDurationMinutes" bigint NOT NULL,
    "position" bigint NOT NULL,
    "scheduleId" uuid NOT NULL
);

-- Indexes
CREATE INDEX "training_day_schedule_id_idx" ON "training_day" USING btree ("scheduleId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "training_schedule" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "publicId" text NOT NULL,
    "name" text NOT NULL,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "training_schedule_auth_user_id_idx" ON "training_schedule" USING btree ("authUserId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "exercise"
    ADD CONSTRAINT "exercise_fk_0"
    FOREIGN KEY("trainingDayId")
    REFERENCES "training_day"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "training_day"
    ADD CONSTRAINT "training_day_fk_0"
    FOREIGN KEY("scheduleId")
    REFERENCES "training_schedule"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "training_schedule"
    ADD CONSTRAINT "training_schedule_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('backend', '20260910175850608-training-schedule', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910175850608-training-schedule', "timestamp" = now();

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
