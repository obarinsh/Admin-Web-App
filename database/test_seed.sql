--
-- PostgreSQL database dump
--

-- Dumped from database version 14.16 (Homebrew)
-- Dumped by pg_dump version 17.0

-- Started on 2025-06-25 19:56:28 IDT

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
-- TOC entry 3669 (class 0 OID 41145)
-- Dependencies: 212
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: olga
--

INSERT INTO public.products VALUES (1, 'Sample Product A', 0.00);
INSERT INTO public.products VALUES (2, 'Sample Product B', 1.00);


--
-- TOC entry 3667 (class 0 OID 41134)
-- Dependencies: 210
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: olga
--

INSERT INTO public.users VALUES (1, 'TestUser1', 'user1@test.com');
INSERT INTO public.users VALUES (2, 'TestUser2', 'user2@test.com');


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 211
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('public.products_id_seq', 2, true);


--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 209
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


-- Completed on 2025-06-25 19:56:29 IDT

--
-- PostgreSQL database dump complete
--

