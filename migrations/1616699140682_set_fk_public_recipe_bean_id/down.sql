alter table "public"."recipe" drop constraint "recipe_bean_id_fkey",
          add constraint "recipes_bean_id_fkey"
          foreign key ("bean_id")
          references "public"."bean"
          ("id")
          on update restrict
          on delete restrict;
