alter table "public"."bean"
           add constraint "bean_creator_id_fkey"
           foreign key ("creator_id")
           references "public"."barista"
           ("id") on update cascade on delete set null;
