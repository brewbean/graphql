alter table "public"."recipe_review" drop constraint "recipe_reviews_barista_id_fkey",
             add constraint "recipe_review_barista_id_fkey"
             foreign key ("barista_id")
             references "public"."barista"
             ("id") on update restrict on delete cascade;
