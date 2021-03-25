ALTER TABLE "public"."bean" ADD COLUMN "altitude" jsonb;
ALTER TABLE "public"."bean" ALTER COLUMN "altitude" DROP NOT NULL;
