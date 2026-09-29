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
CREATE TABLE "friend_invite" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "code" text NOT NULL,
    "creatorId" uuid NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "friend_invite_code_idx" ON "friend_invite" USING btree ("code");
CREATE INDEX "friend_invite_creator_idx" ON "friend_invite" USING btree ("creatorId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "friendship" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userAId" uuid NOT NULL,
    "userBId" uuid NOT NULL,
    "requestedById" uuid NOT NULL,
    "status" text NOT NULL,
    "aSharesStats" boolean NOT NULL,
    "aSharesHistory" boolean NOT NULL,
    "bSharesStats" boolean NOT NULL,
    "bSharesHistory" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "friendship_pair_idx" ON "friendship" USING btree ("userAId", "userBId");
CREATE INDEX "friendship_user_b_idx" ON "friendship" USING btree ("userBId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "friend_invite"
    ADD CONSTRAINT "friend_invite_fk_0"
    FOREIGN KEY("creatorId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "friendship"
    ADD CONSTRAINT "friendship_fk_0"
    FOREIGN KEY("userAId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "friendship"
    ADD CONSTRAINT "friendship_fk_1"
    FOREIGN KEY("userBId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('backend', '20260929214715165-friends', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260929214715165-friends', "timestamp" = now();

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
