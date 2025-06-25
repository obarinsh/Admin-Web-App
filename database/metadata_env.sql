--
-- PostgreSQL database dump
--

-- Dumped from database version 14.16 (Homebrew)
-- Dumped by pg_dump version 17.0

-- Started on 2025-06-25 19:57:02 IDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: olga
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO olga;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 41186)
-- Name: pending_changes; Type: TABLE; Schema: public; Owner: olga
--

CREATE TABLE public.pending_changes (
    id integer NOT NULL,
    table_name text,
    change_type text,
    change_data jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    user_id text,
    environment text DEFAULT 'dev'::text,
    status text DEFAULT 'pending'::text,
    reviewed_by text,
    reviewed_at timestamp without time zone,
    CONSTRAINT pending_changes_environment_check CHECK ((environment = ANY (ARRAY['dev'::text, 'test'::text, 'prod'::text]))),
    CONSTRAINT pending_changes_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'approved'::text, 'rejected'::text])))
);


ALTER TABLE public.pending_changes OWNER TO olga;

--
-- TOC entry 213 (class 1259 OID 41185)
-- Name: pending_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE public.pending_changes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pending_changes_id_seq OWNER TO olga;

--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 213
-- Name: pending_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE public.pending_changes_id_seq OWNED BY public.pending_changes.id;


--
-- TOC entry 210 (class 1259 OID 41163)
-- Name: roles; Type: TABLE; Schema: public; Owner: olga
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.roles OWNER TO olga;

--
-- TOC entry 209 (class 1259 OID 41162)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO olga;

--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 209
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 216 (class 1259 OID 41196)
-- Name: snapshots; Type: TABLE; Schema: public; Owner: olga
--

CREATE TABLE public.snapshots (
    id integer NOT NULL,
    snapshot_name text,
    table_name text,
    data jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.snapshots OWNER TO olga;

--
-- TOC entry 215 (class 1259 OID 41195)
-- Name: snapshots_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE public.snapshots_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.snapshots_id_seq OWNER TO olga;

--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 215
-- Name: snapshots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE public.snapshots_id_seq OWNED BY public.snapshots.id;


--
-- TOC entry 212 (class 1259 OID 41172)
-- Name: users; Type: TABLE; Schema: public; Owner: olga
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    role_id integer
);


ALTER TABLE public.users OWNER TO olga;

--
-- TOC entry 211 (class 1259 OID 41171)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO olga;

--
-- TOC entry 3698 (class 0 OID 0)
-- Dependencies: 211
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3533 (class 2604 OID 41189)
-- Name: pending_changes id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.pending_changes ALTER COLUMN id SET DEFAULT nextval('public.pending_changes_id_seq'::regclass);


--
-- TOC entry 3531 (class 2604 OID 41166)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 3537 (class 2604 OID 41199)
-- Name: snapshots id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.snapshots ALTER COLUMN id SET DEFAULT nextval('public.snapshots_id_seq'::regclass);


--
-- TOC entry 3532 (class 2604 OID 41175)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3546 (class 2606 OID 41194)
-- Name: pending_changes pending_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.pending_changes
    ADD CONSTRAINT pending_changes_pkey PRIMARY KEY (id);


--
-- TOC entry 3542 (class 2606 OID 41170)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3548 (class 2606 OID 41204)
-- Name: snapshots snapshots_pkey; Type: CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.snapshots
    ADD CONSTRAINT snapshots_pkey PRIMARY KEY (id);


--
-- TOC entry 3544 (class 2606 OID 41179)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3549 (class 2606 OID 41180)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: olga
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-06-25 19:57:02 IDT

--
-- PostgreSQL database dump complete
--

