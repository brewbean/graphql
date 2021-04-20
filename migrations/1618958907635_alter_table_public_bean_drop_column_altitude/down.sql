ALTER TABLE "public"."bean" ADD COLUMN "altitude" int4;
ALTER TABLE "public"."bean" ALTER COLUMN "altitude" DROP NOT NULL;
