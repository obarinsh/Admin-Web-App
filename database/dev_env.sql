--
-- PostgreSQL database dump
--

-- Dumped from database version 14.16 (Homebrew)
-- Dumped by pg_dump version 17.0

-- Started on 2025-06-25 19:43:33 IDT

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
-- TOC entry 212 (class 1259 OID 41124)
-- Name: products; Type: TABLE; Schema: public; Owner: olga
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text NOT NULL,
    price numeric NOT NULL
);


ALTER TABLE public.products OWNER TO olga;

--
-- TOC entry 211 (class 1259 OID 41123)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO olga;

--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 211
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 210 (class 1259 OID 41113)
-- Name: users; Type: TABLE; Schema: public; Owner: olga
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL
);


ALTER TABLE public.users OWNER TO olga;

--
-- TOC entry 209 (class 1259 OID 41112)
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
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 209
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3522 (class 2604 OID 41127)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 3521 (class 2604 OID 41116)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3528 (class 2606 OID 41131)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 3524 (class 2606 OID 41122)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3526 (class 2606 OID 41120)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: olga
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-06-25 19:43:33 IDT

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.16 (Homebrew)
-- Dumped by pg_dump version 17.0
