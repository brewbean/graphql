CREATE TABLE "public"."cafe"("id" serial NOT NULL, "slug" text NOT NULL, "content" Text NOT NULL, "phone_number" Text NOT NULL, "tags" jsonb NOT NULL DEFAULT jsonb_build_array(), "name" Text NOT NULL, "location" Text NOT NULL, "location_link" text NOT NULL, "hours" jsonb NOT NULL DEFAULT jsonb_build_object(), "pictures" jsonb NOT NULL DEFAULT jsonb_build_array(), "site_text" Text NOT NULL, "site_link" text NOT NULL, PRIMARY KEY ("id") , UNIQUE ("slug"));
