ALTER TABLE "public"."bean" ADD COLUMN "rating" int4;
ALTER TABLE "public"."bean" ALTER COLUMN "rating" DROP NOT NULL;
