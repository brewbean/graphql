alter table "public"."recipe" drop constraint "recipes_bean_id_fkey",
             add constraint "recipe_bean_id_fkey"
             foreign key ("bean_id")
             references "public"."bean"
             ("id") on update cascade on delete set null;
