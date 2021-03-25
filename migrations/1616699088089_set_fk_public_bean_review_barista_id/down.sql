alter table "public"."bean_review" drop constraint "bean_review_barista_id_fkey",
          add constraint "bean_reviews_barista_id_fkey"
          foreign key ("barista_id")
          references "public"."barista"
          ("id")
          on update restrict
          on delete restrict;
