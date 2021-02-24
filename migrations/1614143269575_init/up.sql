CREATE TABLE public.barista (
    id integer NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    created_on timestamp with time zone DEFAULT now() NOT NULL,
    display_name text NOT NULL,
    avatar text,
    is_verified boolean DEFAULT false NOT NULL
);
CREATE SEQUENCE public.barista_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.barista_id_seq OWNED BY public.barista.id;
CREATE TABLE public.bean (
    id integer NOT NULL,
    name text NOT NULL,
    company_name text NOT NULL,
    roast_type text NOT NULL,
    country_id integer,
    farm_id integer,
    process text NOT NULL,
    region text NOT NULL,
    varietal text NOT NULL,
    altitude jsonb NOT NULL,
    profile_note jsonb NOT NULL,
    img text,
    about text,
    rating integer,
    price numeric,
    date_added timestamp with time zone DEFAULT statement_timestamp(),
    date_updated timestamp with time zone DEFAULT statement_timestamp()
);
CREATE SEQUENCE public.bean_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.bean_id_seq OWNED BY public.bean.id;
CREATE TABLE public.bean_reviews (
    id integer NOT NULL,
    barista_id integer,
    bean_id integer,
    rating numeric,
    comment text,
    date_added timestamp with time zone DEFAULT statement_timestamp(),
    date_updated timestamp with time zone DEFAULT statement_timestamp()
);
CREATE SEQUENCE public.bean_reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.bean_reviews_id_seq OWNED BY public.bean_reviews.id;
CREATE TABLE public.brew_logs (
    id integer NOT NULL,
    barista_id integer NOT NULL,
    brew_type text NOT NULL,
    stage jsonb,
    bean_weight integer NOT NULL,
    bean_grind text NOT NULL,
    water_amount integer NOT NULL,
    bean_id integer,
    water_temp integer NOT NULL,
    rating jsonb NOT NULL,
    comment text NOT NULL,
    is_private boolean DEFAULT true NOT NULL,
    date_added timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    bean_name_free text,
    date_updated timestamp with time zone DEFAULT statement_timestamp()
);
CREATE TABLE public.password_reset_code (
    code uuid DEFAULT public.gen_random_uuid() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    barista_id integer NOT NULL
);
CREATE SEQUENCE public.recipe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.recipe_id_seq OWNED BY public.brew_logs.id;
CREATE TABLE public.recipe_reviews (
    id integer NOT NULL,
    barista_id integer NOT NULL,
    recipe_id integer NOT NULL,
    rating numeric NOT NULL,
    comment text NOT NULL,
    date_added timestamp with time zone DEFAULT statement_timestamp(),
    date_updated timestamp with time zone DEFAULT statement_timestamp()
);
CREATE SEQUENCE public.recipe_reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.recipe_reviews_id_seq OWNED BY public.recipe_reviews.id;
CREATE TABLE public.recipes (
    id integer NOT NULL,
    barista_id integer NOT NULL,
    brew_type text NOT NULL,
    bean_weight integer NOT NULL,
    bean_grind text NOT NULL,
    water_amount integer NOT NULL,
    bean_id integer,
    water_temp integer DEFAULT 100 NOT NULL,
    is_private boolean DEFAULT true NOT NULL,
    date_added timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    about text,
    name text NOT NULL,
    instructions text,
    date_updated timestamp with time zone DEFAULT statement_timestamp(),
    bean_name_free text,
    device text
);
CREATE SEQUENCE public.recipes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;
CREATE TABLE public.refresh_token (
    token uuid NOT NULL,
    barista_id integer NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE public.stage (
    id integer NOT NULL,
    action text NOT NULL,
    start integer NOT NULL,
    "end" integer NOT NULL,
    recipe_id integer NOT NULL,
    weight integer NOT NULL
);
CREATE SEQUENCE public.stage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.stage_id_seq OWNED BY public.stage.id;
CREATE TABLE public.verification_code (
    code uuid DEFAULT public.gen_random_uuid() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    barista_id integer NOT NULL
);
ALTER TABLE ONLY public.barista ALTER COLUMN id SET DEFAULT nextval('public.barista_id_seq'::regclass);
ALTER TABLE ONLY public.bean ALTER COLUMN id SET DEFAULT nextval('public.bean_id_seq'::regclass);
ALTER TABLE ONLY public.bean_reviews ALTER COLUMN id SET DEFAULT nextval('public.bean_reviews_id_seq'::regclass);
ALTER TABLE ONLY public.brew_logs ALTER COLUMN id SET DEFAULT nextval('public.recipe_id_seq'::regclass);
ALTER TABLE ONLY public.recipe_reviews ALTER COLUMN id SET DEFAULT nextval('public.recipe_reviews_id_seq'::regclass);
ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);
ALTER TABLE ONLY public.stage ALTER COLUMN id SET DEFAULT nextval('public.stage_id_seq'::regclass);
ALTER TABLE ONLY public.barista
    ADD CONSTRAINT barista_display_name_key UNIQUE (display_name);
ALTER TABLE ONLY public.barista
    ADD CONSTRAINT barista_email_key UNIQUE (email);
ALTER TABLE ONLY public.barista
    ADD CONSTRAINT barista_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.bean
    ADD CONSTRAINT bean_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.bean_reviews
    ADD CONSTRAINT bean_reviews_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.password_reset_code
    ADD CONSTRAINT password_reset_code_pkey PRIMARY KEY (code);
ALTER TABLE ONLY public.brew_logs
    ADD CONSTRAINT recipe_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.recipe_reviews
    ADD CONSTRAINT recipe_reviews_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.refresh_token
    ADD CONSTRAINT refresh_token_pkey PRIMARY KEY (token);
ALTER TABLE ONLY public.refresh_token
    ADD CONSTRAINT refresh_token_token_key UNIQUE (token);
ALTER TABLE ONLY public.stage
    ADD CONSTRAINT stage_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.verification_code
    ADD CONSTRAINT verification_code_pkey PRIMARY KEY (code);
ALTER TABLE ONLY public.bean_reviews
    ADD CONSTRAINT bean_reviews_barista_id_fkey FOREIGN KEY (barista_id) REFERENCES public.barista(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.bean_reviews
    ADD CONSTRAINT bean_reviews_bean_id_fkey FOREIGN KEY (bean_id) REFERENCES public.bean(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.password_reset_code
    ADD CONSTRAINT password_reset_code_barista_id_fkey FOREIGN KEY (barista_id) REFERENCES public.barista(id) ON UPDATE RESTRICT ON DELETE CASCADE;
ALTER TABLE ONLY public.brew_logs
    ADD CONSTRAINT recipe_barista_id_fkey FOREIGN KEY (barista_id) REFERENCES public.barista(id) ON UPDATE RESTRICT ON DELETE SET NULL;
ALTER TABLE ONLY public.brew_logs
    ADD CONSTRAINT recipe_bean_id_fkey FOREIGN KEY (bean_id) REFERENCES public.bean(id) ON UPDATE RESTRICT ON DELETE SET NULL;
ALTER TABLE ONLY public.recipe_reviews
    ADD CONSTRAINT recipe_reviews_barista_id_fkey FOREIGN KEY (barista_id) REFERENCES public.barista(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.recipe_reviews
    ADD CONSTRAINT recipe_reviews_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_barista_id_fkey FOREIGN KEY (barista_id) REFERENCES public.barista(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_bean_id_fkey FOREIGN KEY (bean_id) REFERENCES public.bean(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.refresh_token
    ADD CONSTRAINT refetch_token_barista_id_fkey FOREIGN KEY (barista_id) REFERENCES public.barista(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.stage
    ADD CONSTRAINT stage_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.verification_code
    ADD CONSTRAINT verification_code_barista_id_fkey FOREIGN KEY (barista_id) REFERENCES public.barista(id) ON UPDATE RESTRICT ON DELETE CASCADE;
