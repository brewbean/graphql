alter table "public"."brew_log" add constraint "brew_log_title_barista_id_key" unique ("title", "barista_id");
