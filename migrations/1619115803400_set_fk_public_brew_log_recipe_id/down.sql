alter table "public"."brew_log" drop constraint "brew_log_recipe_id_fkey",
          add constraint "brew_log_recipe_id_fkey"
          foreign key ("recipe_id")
          references "public"."recipe"
          ("id")
          on update restrict
          on delete cascade;
