ALTER TABLE "public"."bean" ADD COLUMN "profile_note" jsonb;
ALTER TABLE "public"."bean" ALTER COLUMN "profile_note" DROP NOT NULL;
