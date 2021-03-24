alter table "public"."recipe_review" add constraint "recipe_review_barista_id_recipe_id_key" unique ("barista_id", "recipe_id");
