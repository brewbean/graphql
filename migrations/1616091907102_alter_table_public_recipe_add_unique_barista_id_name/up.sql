alter table "public"."recipe" add constraint "recipe_barista_id_name_key" unique ("barista_id", "name");
