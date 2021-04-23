alter table "public"."recipe" drop constraint "recipe_barista_id_fkey",
          add constraint "recipes_barista_id_fkey"
          foreign key ("barista_id")
          references "public"."barista"
          ("id")
          on update restrict
          on delete restrict;
