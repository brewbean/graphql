alter table "public"."bean" drop constraint "bean_name_company_name_key";
alter table "public"."bean" add constraint "bean_name_key" unique ("name");
