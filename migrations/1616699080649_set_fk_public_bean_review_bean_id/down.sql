alter table "public"."bean_review" drop constraint "bean_review_bean_id_fkey",
          add constraint "bean_reviews_bean_id_fkey"
          foreign key ("bean_id")
          references "public"."bean"
          ("id")
          on update restrict
          on delete restrict;
