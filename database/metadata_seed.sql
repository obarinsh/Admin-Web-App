--
-- PostgreSQL database dump
--

-- Dumped from database version 14.16 (Homebrew)
-- Dumped by pg_dump version 17.0

-- Started on 2025-06-25 19:57:39 IDT

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
-- TOC entry 3684 (class 0 OID 41186)
-- Dependencies: 214
-- Data for Name: pending_changes; Type: TABLE DATA; Schema: public; Owner: olga
--

INSERT INTO public.pending_changes VALUES (1, 'products', 'UPDATE', '{"id": 1, "price": 42.99}', '2025-06-24 12:59:22.768165', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (2, 'employees', 'DELETE', '{"id": 2}', '2025-06-24 12:59:22.768165', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (3, 'users', 'UPDATE', '{"env": "dev", "column": "username", "row_id": "123", "user_id": 1, "new_value": "admin_olga", "old_value": "admin"}', '2025-06-25 12:22:47.93229', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (4, 'products', 'UPDATE', '{"env": "dev", "column": "name", "row_id": "1", "user_id": 7, "new_value": "T-shirtgfgf", "old_value": "T-shirt", "table_name": "products"}', '2025-06-25 17:45:01.530184', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (5, 'products', 'UPDATE', '{"env": "dev", "column": "name", "row_id": "3", "user_id": 7, "new_value": "Sticker Packv", "old_value": "Sticker Pack", "table_name": "products"}', '2025-06-25 17:46:46.730698', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (6, 'products', 'UPDATE', '{"env": "dev", "column": "name", "row_id": "1", "user_id": 7, "new_value": "T-shirt", "old_value": "T-shirtgfgf", "table_name": "products"}', '2025-06-25 17:46:50.975904', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (7, 'products', 'UPDATE', '{"env": "dev", "column": "id", "row_id": "4", "user_id": 7, "new_value": "4", "old_value": "", "table_name": "products"}', '2025-06-25 18:17:56.302146', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (8, 'products', 'UPDATE', '{"env": "dev", "column": "name", "row_id": "4", "user_id": 7, "new_value": "Napkins", "old_value": "Mug", "table_name": "products"}', '2025-06-25 18:18:08.859895', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (9, 'products', 'UPDATE', '{"env": "dev", "column": "price", "row_id": "4", "user_id": 7, "new_value": "2.2", "old_value": "", "table_name": "products"}', '2025-06-25 18:18:12.098594', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (10, 'products', 'UPDATE', '{"env": "dev", "column": "id", "row_id": "5", "user_id": 7, "new_value": "5", "old_value": "", "table_name": "products"}', '2025-06-25 18:22:58.114759', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (11, 'products', 'UPDATE', '{"env": "dev", "column": "name", "row_id": "5", "user_id": 7, "new_value": "Phone", "old_value": "", "table_name": "products"}', '2025-06-25 18:23:01.949206', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (12, 'products', 'UPDATE', '{"env": "dev", "column": "price", "row_id": "5", "user_id": 7, "new_value": "39.6", "old_value": "", "table_name": "products"}', '2025-06-25 18:23:07.963412', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (13, 'products', 'UPDATE', '{"env": "dev", "column": "id", "row_id": "12", "user_id": 7, "new_value": "12", "old_value": "", "table_name": "products"}', '2025-06-25 18:56:15.778974', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (14, 'products', 'UPDATE', '{"env": "dev", "column": "name", "row_id": "12", "user_id": 7, "new_value": "hello", "old_value": "", "table_name": "products"}', '2025-06-25 18:56:20.302413', NULL, 'dev', 'pending', NULL, NULL);
INSERT INTO public.pending_changes VALUES (15, 'products', 'UPDATE', '{"env": "dev", "column": "price", "row_id": "12", "user_id": 7, "new_value": "3.4", "old_value": "", "table_name": "products"}', '2025-06-25 18:56:24.984531', NULL, 'dev', 'pending', NULL, NULL);


--
-- TOC entry 3680 (class 0 OID 41163)
-- Dependencies: 210
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: olga
--

INSERT INTO public.roles VALUES (1, 'Administrator');
INSERT INTO public.roles VALUES (2, 'Data Analyst');
INSERT INTO public.roles VALUES (3, 'Viewer');


--
-- TOC entry 3686 (class 0 OID 41196)
-- Dependencies: 216
-- Data for Name: snapshots; Type: TABLE DATA; Schema: public; Owner: olga
--

INSERT INTO public.snapshots VALUES (1, 'init_products', 'products', '[{"id": 1, "name": "Widget", "price": 19.99}]', '2025-06-24 12:59:37.216624');


--
-- TOC entry 3682 (class 0 OID 41172)
-- Dependencies: 212
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: olga
--

INSERT INTO public.users VALUES (7, 'admin', 'admin123', 1);
INSERT INTO public.users VALUES (8, 'data_user', 'pass456', 2);
INSERT INTO public.users VALUES (9, 'viewer', 'view789', 3);


--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 213
-- Name: pending_changes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('public.pending_changes_id_seq', 15, true);


--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 209
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 215
-- Name: snapshots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('public.snapshots_id_seq', 1, true);


--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 211
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


-- Completed on 2025-06-25 19:57:39 IDT

--
-- PostgreSQL database dump complete
--

