-- ═══════════════════════════════════════════════════════════
-- MGS Panel - Supabase Migration
-- PART 2 of 3: INSERT DATA (Users, Settings, etc.)
-- Run this SECOND after Part 1 completes
-- ═══════════════════════════════════════════════════════════
SET client_encoding = 'UTF8';
SET row_security = off;

--
-- PostgreSQL database dump
--


-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: _cleanup_flags; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public._cleanup_flags VALUES ('stats_reset_v2', '2026-03-29 02:11:23.96056');


--
-- Data for Name: activation_codes; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: sms_ranges; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES ('35f40ac5-8b22-4cdf-b8c1-10a143fa3626', 'Tester', 'Account', 'tester@expresssms.com', '$2b$10$UaexnngM.Uni5RF9j/06Qu5Ej0CAfUjyNdUcNSLqY1/ExxrekOuK6', NULL, true, 'tester', NULL, '2026-03-28 15:56:03.928142', 'tester', NULL, NULL, NULL, NULL, NULL, 0, '0', '0', '0', '0', 'HTTP', NULL, true, false, 'HTTP', NULL, 'TESTER001', '2026-03-28 15:56:03.927', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES ('e1f0ac88-8281-4788-beeb-0d7ef7054672', '', '', NULL, '$2b$10$8N2cHjGX/nEzmEUGm0mOVO4/O1tR112EACpuEG7ByFLu73jYdiNRu', NULL, true, 'agent', '9df05e38-e174-48ec-a09f-ec2327cb02b1', '2026-03-28 21:29:15.74492', 'Alexey303020', '', '', '', '', 'Afghanistan', 0, '0', '0', '0', '0', 'HTTP', '', true, false, 'HTTP', 'None', 'TKN--jGK0eT7SVxfZGnp8w2C7uZ-YfJdJrPT', '2026-03-28 22:11:39.793', '2026-03-29 03:17:53.922', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO public.users VALUES ('9df05e38-e174-48ec-a09f-ec2327cb02b1', 'Admin', 'User', 'admin@expresssms.com', '$2b$10$U/Ezn.UvqwFJaDHujuSgeuD6WzAizkrvaKpJecl7J.vSxm8JNJJUK', NULL, true, 'admin', NULL, '2026-03-28 15:56:03.830635', 'admin', NULL, NULL, NULL, NULL, NULL, 0, '0', '0', '0', '0', 'HTTP', NULL, true, false, 'HTTP', NULL, 'ADMIN001', '2026-03-28 15:56:03.829', '2026-03-29 03:21:51.115', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.users VALUES ('2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f', '', '', NULL, '$2b$10$d8yoFYwrBjaZT7Ccl4MTaOTt.iCc6EJYX8fsYHZpGF6qmKC4BYc.e', NULL, true, 'agent', '9df05e38-e174-48ec-a09f-ec2327cb02b1', '2026-03-29 03:22:33.710808', 'Team_X', '', '', '', '', 'Afghanistan', 0, '0', '0', '0', '0', 'HTTP', '', true, false, 'HTTP', 'None', 'AGT-8W3K37OX', '2026-03-29 03:22:33.709', '2026-03-29 03:22:48.326', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO public.users VALUES ('002b9a59-adef-4e9c-9c0d-e3d3c91b7678', '', '', NULL, '$2b$10$0vEc7uwIvm5C.9/Vp52hcec5IHvb8DrMVLlOPLZavtgTNzRcmh2L.', NULL, true, 'agent', '9df05e38-e174-48ec-a09f-ec2327cb02b1', '2026-03-29 02:15:55.773821', 'Ajememe', '', '', 'Ejej', '', 'Afghanistan', 0, '0', '0', '0', '0', 'HTTP', 'https://6a6b5212-b320-4867-b112-0e4fab5b8b1e-00-2q446o1n994vk.kirk.replit.dev/http/incoming/incoming-mnb4mriu', true, false, 'HTTP', 'None', 'AGT-3NFCDB4W', '2026-03-29 02:15:55.772', NULL, NULL, NULL, NULL, NULL, NULL, '');


--
-- Data for Name: agent_number_requests; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: announcements; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: api_connections; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: api_keys; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: archived_accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.archived_accounts VALUES ('4b52dc07-2b7a-47b3-a72b-81ee61af0a17', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'Admin', 'User', 'admin@expresssms.com', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, true, '2026-03-28 15:56:03.83', '2026-03-28 15:56:18.227625');
INSERT INTO public.archived_accounts VALUES ('cb1b99cd-8a36-4698-a66b-1fdfe964a371', '35f40ac5-8b22-4cdf-b8c1-10a143fa3626', 'tester', 'Tester', 'Account', 'tester@expresssms.com', 'tester', NULL, NULL, NULL, NULL, NULL, NULL, true, '2026-03-28 15:56:03.928', '2026-03-28 15:56:18.227625');
INSERT INTO public.archived_accounts VALUES ('b1aee36f-ef35-4e81-b293-38e6d21f2f5b', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', '', '', '', 'agent', '9df05e38-e174-48ec-a09f-ec2327cb02b1', '', '', '', '', 'Afghanistan', true, '2026-03-28 21:29:15.744', '2026-03-28 21:31:45.967996');
INSERT INTO public.archived_accounts VALUES ('d52e1d52-c815-4d71-aa73-edb38393cbf3', '002b9a59-adef-4e9c-9c0d-e3d3c91b7678', 'Ajememe', '', '', '', 'agent', '9df05e38-e174-48ec-a09f-ec2327cb02b1', '', '', 'Ejej', '', 'Afghanistan', true, '2026-03-29 02:15:55.773', '2026-03-29 02:20:31.712204');
INSERT INTO public.archived_accounts VALUES ('f40b08ac-18af-47b4-a850-53d5f0bc0405', '2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f', 'Team_X', '', '', '', 'agent', '9df05e38-e174-48ec-a09f-ec2327cb02b1', '', '', '', '', 'Afghanistan', true, '2026-03-29 03:22:33.71', '2026-03-29 15:51:20.390001');


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.clients VALUES ('9c3f7e06-26d1-4b9d-9380-5b19e3a23fc6', 'Alexey303020', '', '', '$2b$10$/2bOnFLMrKxZ2MFxNSQbZulRz4oNBbfklQ1JX88mPOwyIeHEAMxQi', '', '', '', '', '', '0.00', 'active', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', '2026-03-29 02:49:33.728651', NULL);
INSERT INTO public.clients VALUES ('73457994-ddc9-40e9-80fb-ef47d5d40db3', 'sysadmin', '', '', '$2b$10$tIJvxSmtfYo5yxcjF3uCbutbW/1zWrHR55AToax1ReUAA07pkg2nO', '', '', '', '', '', '0.00', 'active', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', '2026-03-29 02:50:56.849384', NULL);


--
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: credit_requests; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: dlr_messages; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: external_db_connections; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: external_db_sync_logs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: failed_login_logs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.failed_login_logs VALUES ('c29eaea0-31cc-4f91-9e03-6e0008a19b5e', 'Alexey303020', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', '127.0.0.1', 'curl/8.14.1', 'Password Incorrect', 1, false, '2026-03-29 03:17:01.508156');
INSERT INTO public.failed_login_logs VALUES ('b21ca3e8-5dec-4c0a-9662-25d006a10c59', 'Wrong password for user: Alexey303020', NULL, '127.0.0.1', 'curl/8.14.1', 'Invalid credentials', 1, false, '2026-03-29 03:17:01.529221');
INSERT INTO public.failed_login_logs VALUES ('ccfc00fc-bdca-49b2-9acd-2191e4efe8a8', 'admin', '9df05e38-e174-48ec-a09f-ec2327cb02b1', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Password Incorrect', 1, false, '2026-03-29 03:18:41.229747');
INSERT INTO public.failed_login_logs VALUES ('d24b2d01-a67b-46e4-ae21-f265ac77f7c1', 'Wrong password for user: admin', NULL, '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Invalid credentials', 1, false, '2026-03-29 03:18:41.233367');
INSERT INTO public.failed_login_logs VALUES ('b6b75e1b-b4fd-487a-b7dc-b682a6fb2dc2', 'Alexey303020', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Password Incorrect', 2, false, '2026-03-29 03:20:33.262542');
INSERT INTO public.failed_login_logs VALUES ('a822c185-1bb8-49f1-baf2-8271f0bb088f', 'Wrong password for user: Alexey303020', NULL, '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Invalid credentials', 1, false, '2026-03-29 03:20:33.265467');
INSERT INTO public.failed_login_logs VALUES ('1e9fdd90-ef13-463f-a348-d36fa7674b47', 'Alexey303020', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Password Incorrect', 3, false, '2026-03-29 03:20:35.562435');
INSERT INTO public.failed_login_logs VALUES ('37e29339-74a1-4465-a73b-691bf718ea03', 'Wrong password for user: Alexey303020', NULL, '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Invalid credentials', 1, false, '2026-03-29 03:20:35.565913');
INSERT INTO public.failed_login_logs VALUES ('3e401a80-5c87-44f0-8fd5-a4e64d2beb51', 'Ajememe', '002b9a59-adef-4e9c-9c0d-e3d3c91b7678', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Password Incorrect', 1, false, '2026-03-29 03:21:37.045844');
INSERT INTO public.failed_login_logs VALUES ('bfeed126-11e5-4d24-bbee-ae72b84e968c', 'Wrong password for user: Ajememe', NULL, '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Invalid credentials', 1, false, '2026-03-29 03:21:37.052073');


--
-- Data for Name: http_endpoints; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.http_endpoints VALUES ('0f2b58b3-0e83-494e-ab40-f47bf1e1032e', 'HTTP Incoming Gateway', 'incoming-mnb4mriu', 'ANY', 'application/json', 'open', '', '', 'Auto-generated HTTP incoming endpoint - receives data via msg field', true, 1, 1, 0, '2026-03-29 02:15:13.056393');


--
-- Data for Name: http_forwarding_rules; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.http_forwarding_rules VALUES ('c6fa1b0a-c389-4398-82c3-df710bdbf14a', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'Admin User', 'https://6a6b5212-b320-4867-b112-0e4fab5b8b1e-00-2q446o1n994vk.kirk.replit.dev/http/incoming/incoming-mnb4mriu', 'POST', '{}', true, 'https://6a6b5212-b320-4867-b112-0e4fab5b8b1e-00-2q446o1n994vk.kirk.replit.dev/incoming-messages', '2026-03-29 02:38:44.045653', 'https://6a6b5212-b320-4867-b112-0e4fab5b8b1e-00-2q446o1n994vk.kirk.replit.dev/http/incoming/incoming-mnb4mriu', 'HTTP_POST', 0);


--
-- Data for Name: http_incoming_logs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.http_incoming_logs VALUES ('712a6617-a31f-48ce-b4de-39fa5fb55d0a', '0f2b58b3-0e83-494e-ab40-f47bf1e1032e', 'HTTP Incoming Gateway', '34.83.161.87', 'POST', '{"host":"6a6b5212-b320-4867-b112-0e4fab5b8b1e-00-2q446o1n994vk.kirk.replit.dev","user-agent":"node","content-length":"73","accept":"*/*","accept-encoding":"br, gzip, deflate","accept-language":"*","content-type":"application/json","sec-fetch-mode":"cors","traceparent":"00-69c890a400000000290ff0f34e54bb3b-3f16008187974cbe-00","tracestate":"dd=s:0;p:3f16008187974cbe;t.tid:69c890a400000000","x-datadog-parent-id":"4545821430202715326","x-datadog-sampling-priority":"0","x-datadog-tags":"_dd.p.tid=69c890a400000000","x-datadog-trace-id":"2958848407987600187","x-forwarded-for":"34.83.161.87, 10.82.10.94, 127.0.0.1","x-forwarded-proto":"https","x-mgs-test":"true","x-replit-user-bio":"","x-replit-user-id":"","x-replit-user-name":"","x-replit-user-profile-image":"","x-replit-user-roles":"","x-replit-user-teams":"","x-replit-user-url":""}', '{"test":true,"source":"mgs-panel","timestamp":"2026-03-29T02:38:28.806Z"}', '{}', 'SUCCESS', 200, '', '{"status":"OK","message":"Received","msg":"mgs-panel","num":null,"cli":"mgs-panel","dt":"2026-03-29T02:38:28.806Z","timestamp":"2026-03-29T02:38:28.816Z"}', 'node', '2026-03-29 02:38:28.816937');


--
-- Data for Name: http_incoming_providers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: http_incoming_messages; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: sms_providers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: http_smpp_messages; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: inactivity_notifications; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: incoming_messages; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.login_history VALUES ('8ba98810-974e-47ab-9726-19c2a0c8038f', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.207.153', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 'Desktop', 'Chrome/144', 'Windows NT 10.0', 'success', '2026-03-28 16:05:52.713516');
INSERT INTO public.login_history VALUES ('93a33933-1e9b-4c05-a263-7dee61c0f9f7', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.207.153', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 'Desktop', 'Chrome/144', 'Windows NT 10.0', 'success', '2026-03-28 16:06:47.879134');
INSERT INTO public.login_history VALUES ('af258f0d-7050-4a27-ac75-da1780c0ebcb', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'success', '2026-03-28 20:46:50.684639');
INSERT INTO public.login_history VALUES ('725e1738-f803-4aaf-8029-f6a19f1de5eb', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'logout', '2026-03-28 20:49:06.935954');
INSERT INTO public.login_history VALUES ('fc476d79-b74a-4499-85f1-935ba4b1ca62', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'success', '2026-03-28 20:53:17.816369');
INSERT INTO public.login_history VALUES ('9553f86f-8c77-408e-b6f1-c5cc890394e0', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 21:28:48.520012');
INSERT INTO public.login_history VALUES ('e972258c-31bb-4229-a0a5-2e5145b048f1', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'logout', '2026-03-28 21:29:23.159765');
INSERT INTO public.login_history VALUES ('98e23a55-4f5a-44c4-b775-d702217a4f4b', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 21:29:34.269182');
INSERT INTO public.login_history VALUES ('9ecab490-33b5-4f82-a5be-f0c2773fc494', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'logout', '2026-03-28 21:29:47.057808');
INSERT INTO public.login_history VALUES ('b08b53f5-77f1-4acc-98ff-838ea69a0c1e', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 21:40:28.496982');
INSERT INTO public.login_history VALUES ('f5c71a4e-2cf5-4530-878e-596163ae91df', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'logout', '2026-03-28 21:41:04.849651');
INSERT INTO public.login_history VALUES ('ae2d059d-5389-4cd4-8012-3397b94eb483', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 21:41:19.167589');
INSERT INTO public.login_history VALUES ('1ed80203-2fe9-4c91-af1e-f9dc9bb9db20', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'logout', '2026-03-28 21:41:35.209335');
INSERT INTO public.login_history VALUES ('eb7bafcd-7014-4c6f-bb71-60872f6d6717', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 21:49:42.011705');
INSERT INTO public.login_history VALUES ('ce67c923-f5a2-4107-807b-049268ce9682', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'logout', '2026-03-28 21:55:15.1728');
INSERT INTO public.login_history VALUES ('d55a20cd-07f9-4d7b-9825-871e6732da8f', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 21:55:44.630904');
INSERT INTO public.login_history VALUES ('a8b987ee-6372-46cb-bc20-7fe5d4bf61d1', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'logout', '2026-03-28 22:05:19.773459');
INSERT INTO public.login_history VALUES ('8c6f8d7d-53b0-4ec5-8788-e7ed39983ce9', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 22:05:35.415406');
INSERT INTO public.login_history VALUES ('6773758d-f245-41a4-ad52-ed30d4a11c8e', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'logout', '2026-03-28 22:06:28.428342');
INSERT INTO public.login_history VALUES ('33699a27-43c8-480e-8992-f4ae70e5a983', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 22:06:36.982521');
INSERT INTO public.login_history VALUES ('6531211d-6dc3-47af-92ef-e7c880e389ae', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 22:08:03.504844');
INSERT INTO public.login_history VALUES ('1c88dca0-8d38-4137-aedd-678b8fed30a6', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'logout', '2026-03-28 22:08:20.842123');
INSERT INTO public.login_history VALUES ('9e70ae2d-4f89-4c53-b165-844f0a62d44a', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 22:08:36.228303');
INSERT INTO public.login_history VALUES ('6a67e5ba-b728-4591-99b1-8582417636a4', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'logout', '2026-03-28 22:08:57.064971');
INSERT INTO public.login_history VALUES ('ddc8e93a-a015-44ab-aa01-88eabe4e6712', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.207.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome/146', 'Linux', 'success', '2026-03-28 22:09:06.222259');
INSERT INTO public.login_history VALUES ('8b05a70d-ef04-4366-970f-d4f670ae6eee', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '127.0.0.1', 'curl/8.14.1', 'Desktop', 'Unknown', 'Unknown', 'success', '2026-03-29 02:11:43.837195');
INSERT INTO public.login_history VALUES ('c9688beb-3eed-44b7-a920-3a61870e5f9e', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'success', '2026-03-29 02:14:13.234477');
INSERT INTO public.login_history VALUES ('221624e0-8792-413b-8cb8-e344b0783ef1', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '127.0.0.1', 'curl/8.14.1', 'Desktop', 'Unknown', 'Unknown', 'success', '2026-03-29 02:23:05.636238');
INSERT INTO public.login_history VALUES ('5063fe0b-1875-428f-b7d1-dd6d35a2abee', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '127.0.0.1', 'curl/8.14.1', 'Desktop', 'Unknown', 'Unknown', 'success', '2026-03-29 02:26:25.650869');
INSERT INTO public.login_history VALUES ('5bd08b74-9d81-43ad-a542-044d6c1cb2f7', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '127.0.0.1', 'curl/8.14.1', 'Desktop', 'Unknown', 'Unknown', 'success', '2026-03-29 02:27:15.87478');
INSERT INTO public.login_history VALUES ('aa3ea8b7-eca7-4ea9-88db-81197ade33c5', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '127.0.0.1', 'curl/8.14.1', 'Desktop', 'Unknown', 'Unknown', 'success', '2026-03-29 02:33:39.664265');
INSERT INTO public.login_history VALUES ('c224e8ba-42c1-449b-921c-a002f37f9ce8', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'logout', '2026-03-29 02:44:35.490205');
INSERT INTO public.login_history VALUES ('af573dc8-e40e-4f24-88f8-7a3839bc233b', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'success', '2026-03-29 02:44:43.694346');
INSERT INTO public.login_history VALUES ('9127e185-633a-49d5-bcb4-14378a996bc3', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'logout', '2026-03-29 02:49:42.380184');
INSERT INTO public.login_history VALUES ('083876ce-a714-4f96-a260-bcc8798b155b', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'success', '2026-03-29 02:49:50.200627');
INSERT INTO public.login_history VALUES ('d7f1abdf-1b2b-4775-8a21-ce342186ba67', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'logout', '2026-03-29 02:51:04.485748');
INSERT INTO public.login_history VALUES ('846c0ca3-c844-474b-b414-5305059cd879', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '127.0.0.1', 'curl/8.14.1', 'Desktop', 'Unknown', 'Unknown', 'success', '2026-03-29 02:56:11.55753');
INSERT INTO public.login_history VALUES ('8ba4f13f-778f-4cee-8e5f-b11201a821d6', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '127.0.0.1', 'curl/8.14.1', 'Desktop', 'Unknown', 'Unknown', 'success', '2026-03-29 02:59:54.876192');
INSERT INTO public.login_history VALUES ('4fbc4633-826e-4ea6-8411-fd205d13fdb0', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'success', '2026-03-29 03:01:44.091041');
INSERT INTO public.login_history VALUES ('63f2dd54-f0d8-4ca3-a328-6c180458be8f', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '127.0.0.1', 'curl/8.14.1', 'Desktop', 'Unknown', 'Unknown', 'success', '2026-03-29 03:16:59.636519');
INSERT INTO public.login_history VALUES ('2d2ec7b7-807f-4269-bf47-8f0f82daabab', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '127.0.0.1', 'curl/8.14.1', 'Desktop', 'Unknown', 'Unknown', 'failed', '2026-03-29 03:17:01.504345');
INSERT INTO public.login_history VALUES ('cb95df63-9eee-46d9-bb7e-8f233ca99ccc', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '127.0.0.1', 'curl/8.14.1', 'Desktop', 'Unknown', 'Unknown', 'success', '2026-03-29 03:17:53.928934');
INSERT INTO public.login_history VALUES ('6771e5a1-e06d-409c-a831-526c54cb6467', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'logout', '2026-03-29 03:18:24.888262');
INSERT INTO public.login_history VALUES ('1344db4a-f31d-47e9-8c47-ddbf6811e253', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'failed', '2026-03-29 03:18:41.217846');
INSERT INTO public.login_history VALUES ('f3b91bbd-e505-4329-acc2-a5564addee0b', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'success', '2026-03-29 03:18:49.757363');
INSERT INTO public.login_history VALUES ('f39642d4-63ef-4e36-bf45-cf58f7477a50', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'logout', '2026-03-29 03:20:26.100522');
INSERT INTO public.login_history VALUES ('6a3a76ac-d240-4f57-af44-bd625d1d3430', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'failed', '2026-03-29 03:20:33.258554');
INSERT INTO public.login_history VALUES ('664cdf19-7d2b-4593-86db-30c43534805d', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Alexey303020', 'agent', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'failed', '2026-03-29 03:20:35.55912');
INSERT INTO public.login_history VALUES ('ad1d5635-bec1-4374-bc0c-5fd5ba714640', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'success', '2026-03-29 03:20:49.265752');
INSERT INTO public.login_history VALUES ('5db4c0f4-4623-4899-a00a-66dd94d4ae71', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'logout', '2026-03-29 03:21:29.82373');
INSERT INTO public.login_history VALUES ('ac375360-1f66-40fa-8cda-a8942def054d', '002b9a59-adef-4e9c-9c0d-e3d3c91b7678', 'Ajememe', 'agent', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'failed', '2026-03-29 03:21:37.040724');
INSERT INTO public.login_history VALUES ('49e4b6a6-a624-4f57-a702-f3d209a9a4d6', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'success', '2026-03-29 03:21:51.121739');
INSERT INTO public.login_history VALUES ('a82b7bf0-ce22-453e-bc3d-7e2fa899ebfe', '9df05e38-e174-48ec-a09f-ec2327cb02b1', 'admin', 'admin', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'logout', '2026-03-29 03:22:39.230977');
INSERT INTO public.login_history VALUES ('e38ec1e2-bbf0-4d6a-8513-57eaeaa75c5d', '2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f', 'Team_X', 'agent', '197.192.205.148', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome/146', 'Linux', 'success', '2026-03-29 03:22:48.332621');


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.messages VALUES ('e37087a5-99e9-4503-92a4-aabb6b204ebc', '2026-03-29 02:38:28.826409', 'HTTP', '34.83.161.87', 'HTTP Incoming Gateway', 'mgs-panel', NULL, NULL, '0.00', '0.00', '$', NULL, 'HTTP Incoming', 'HTTP', NULL, NULL, '0.00', 'Success', '34.83.161.87');


--
-- Data for Name: message_ownership; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.message_ownership VALUES ('cf8d513c-b8da-49b7-9196-29018dc6d62e', 'e37087a5-99e9-4503-92a4-aabb6b204ebc', NULL, 'HTTP', NULL, NULL, NULL, NULL, NULL, '0.00', '0.00', '0.00', 'USD', '2026-03-29 02:38:28.829339');


--
-- Data for Name: support_conversations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.support_conversations VALUES ('7795ef7d-023c-4bf7-89f3-c10a43634843', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'Technical Support', 'open', 'medium', NULL, '2026-03-29 02:06:20.627', '2026-03-29 22:06:20.627', false, NULL, false, false, 1, '2026-03-28 22:06:20.9', '2026-03-28 22:06:20.9', '2026-03-28 22:06:20.9', '2026-03-28 22:06:20.628479');
INSERT INTO public.support_conversations VALUES ('0ad0ae05-b411-471e-a9b4-649f02789a4e', '2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f', 'Technical Support', 'open', 'medium', NULL, '2026-03-29 07:23:33.418', '2026-03-30 03:23:33.418', false, NULL, false, false, 1, '2026-03-29 03:23:33.682', '2026-03-29 03:23:33.682', '2026-03-29 03:23:33.682', '2026-03-29 03:23:33.419765');


--
-- Data for Name: support_messages; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.support_messages VALUES ('12062ea5-5246-48c1-94e3-50c7b321539e', '7795ef7d-023c-4bf7-89f3-c10a43634843', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'agent', 'مج', 'text', NULL, '2026-03-28 22:06:20.9', NULL, '2026-03-28 22:06:20.900666');
INSERT INTO public.support_messages VALUES ('d168e857-071e-414f-b0db-ecfe70a24082', '0ad0ae05-b411-471e-a9b4-649f02789a4e', '2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f', 'agent', 'J', 'text', NULL, '2026-03-29 03:23:33.682', NULL, '2026-03-29 03:23:33.682472');


--
-- Data for Name: message_reactions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: number_assignment_history; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: number_requests; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: payment_withdrawals; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: phone_numbers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: platform_info; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.session VALUES ('ERmKGHXt7mtjKt1Akl7wigrUndcHHgSq', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:33:39.679Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}', '2026-04-05 02:34:49');
INSERT INTO public.session VALUES ('zFUAy3VGgGsoftpEkz8wI3pkvBC-vfuU', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:59:54.879Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}', '2026-04-05 02:59:55');
INSERT INTO public.session VALUES ('woTKLwdz-ArdQBvAQ-bLpmgQbCVRfrNT', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T03:09:35.496Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"e1f0ac88-8281-4788-beeb-0d7ef7054672"}', '2026-04-05 03:09:36');
INSERT INTO public.session VALUES ('aKriKwvsXbKVcm9X2hzJUgE4w5TTCgV9', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:23:05.639Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}', '2026-04-05 02:23:44');
INSERT INTO public.session VALUES ('3rQyiWAl8DDQCkvynPk_k6Y71RbJTlzr', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:11:43.842Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}', '2026-04-05 02:12:49');
INSERT INTO public.session VALUES ('3TUBKsUjQ4bHpkO26zs2-SPHk9rZU_OG', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:26:25.654Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}', '2026-04-05 02:26:26');
INSERT INTO public.session VALUES ('xu0NuIgtz3atxVGuUpQgF0foNw--z9jP', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:27:15.879Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}', '2026-04-05 02:27:27');
INSERT INTO public.session VALUES ('CpPX8wOuvh0_Ni-aLaRPBv77abpfdFKP', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T03:16:59.642Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}', '2026-04-05 03:18:31');
INSERT INTO public.session VALUES ('QxV8tX7v1zk0dwPxJO7ZavX_wva7dFLF', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T03:17:53.932Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"e1f0ac88-8281-4788-beeb-0d7ef7054672","userRole":"agent"}', '2026-04-05 03:18:31');
INSERT INTO public.session VALUES ('EJQcyuWARdo0YOJ8FDkf46z-FDh7DL_S', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T03:22:48.335Z","secure":true,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f","userRole":"agent"}', '2026-04-05 03:24:14');
INSERT INTO public.session VALUES ('KPSajhjFS7cvd-lpNtiC8K4ZrNCp47Fm', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:56:11.560Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}', '2026-04-05 02:57:32');
INSERT INTO public.session VALUES ('o-XGr5JGPYNZ2-MbDDKW7mwPEA9sR8jZ', '{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T03:10:19.553Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"e1f0ac88-8281-4788-beeb-0d7ef7054672"}', '2026-04-05 03:10:20');


--
-- Data for Name: smpp_dlr_reports; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: smpp_gateway_groups; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: smpp_gateway_users; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: smpp_http_api_keys; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: smpp_logs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: sms_numbers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: sms_test_numbers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: sources; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: source_ranges; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: telegram_bot_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: telegram_bot_users; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: test_requests; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: ticket_attachments; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: time_settings; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: webhook_logs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.webhook_logs VALUES ('63a08dca-a926-4371-b1d3-2041fa98d857', 'e1f0ac88-8281-4788-beeb-0d7ef7054672', 'unknown', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{"number":"+123456","content":"test","from":"test"}', '2026-03-29 03:10:19.61904');


--
-- Data for Name: withdraw_logs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: withdraw_requests; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- PostgreSQL database dump complete
--


