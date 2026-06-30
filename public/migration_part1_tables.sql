-- ═══════════════════════════════════════════════════════════
-- MGS Panel - Supabase Migration
-- PART 1 of 3: CREATE TABLES
-- Run this FIRST in Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════
SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--



--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--



SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _cleanup_flags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._cleanup_flags (
    key text NOT NULL,
    done_at timestamp without time zone DEFAULT now()
);


--
-- Name: activation_codes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.activation_codes (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    country text NOT NULL,
    whatsapp_number text NOT NULL,
    email text NOT NULL,
    is_used boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: agent_number_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_number_requests (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    user_id character varying,
    range_id character varying,
    quantity integer NOT NULL,
    status text DEFAULT 'pending'::text,
    approved_by character varying,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcements (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    body text DEFAULT ''::text,
    image_url text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: api_connections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_connections (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    api_token text NOT NULL,
    api_url text NOT NULL,
    status text DEFAULT 'offline'::text,
    last_checked_at timestamp without time zone,
    last_error text,
    is_active boolean DEFAULT true,
    auto_fetch boolean DEFAULT false,
    fetch_interval_seconds integer DEFAULT 5,
    last_fetched_at timestamp without time zone,
    last_fetched_record_date text,
    total_fetched integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: api_keys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_keys (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    key text NOT NULL,
    name text NOT NULL,
    user_id character varying,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    last_used_at timestamp without time zone
);


--
-- Name: archived_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.archived_accounts (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    original_user_id character varying NOT NULL,
    username text,
    first_name text NOT NULL,
    second_name text NOT NULL,
    email text NOT NULL,
    role text,
    created_by character varying,
    contact text,
    skype_id text,
    company_name text,
    address text,
    country text,
    is_active boolean DEFAULT false,
    original_created_at timestamp without time zone,
    archived_at timestamp without time zone DEFAULT now()
);


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    actor_user_id character varying,
    actor_username text,
    action text NOT NULL,
    entity_type text NOT NULL,
    entity_id text,
    status text DEFAULT 'success'::text,
    ip_address text,
    user_agent text,
    details text,
    meta text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    username text NOT NULL,
    name text DEFAULT ''::text,
    email text DEFAULT ''::text,
    password text NOT NULL,
    contact text DEFAULT ''::text,
    skype text DEFAULT ''::text,
    company text DEFAULT ''::text,
    address text DEFAULT ''::text,
    country text DEFAULT ''::text,
    balance text DEFAULT '0.00'::text,
    status text DEFAULT 'active'::text,
    agent_id character varying,
    created_at timestamp without time zone DEFAULT now(),
    profile_picture text
);


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.countries (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    code text NOT NULL,
    price text DEFAULT '0'::text,
    available_numbers integer DEFAULT 0
);


--
-- Name: credit_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credit_requests (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    user_id character varying NOT NULL,
    amount text NOT NULL,
    currency text NOT NULL,
    payment_method_id character varying,
    status text DEFAULT 'pending'::text,
    telegram_chat_id text,
    created_at timestamp without time zone DEFAULT now(),
    processed_at timestamp without time zone
);


--
-- Name: dlr_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dlr_messages (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    msgid text DEFAULT ''::text,
    number text DEFAULT ''::text,
    message text DEFAULT ''::text,
    status text DEFAULT 'pending'::text,
    raw_status text DEFAULT ''::text,
    "time" text DEFAULT ''::text,
    sender_ip text DEFAULT ''::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: external_db_connections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.external_db_connections (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    db_type text NOT NULL,
    host text NOT NULL,
    port integer NOT NULL,
    database text NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    ssl_enabled boolean DEFAULT false,
    is_active boolean DEFAULT false,
    status text DEFAULT 'disconnected'::text,
    last_tested_at timestamp without time zone,
    last_sync_at timestamp without time zone,
    sync_interval integer DEFAULT 0,
    sync_type text DEFAULT 'manual'::text,
    table_mappings text DEFAULT '{}'::text,
    created_by character varying,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: external_db_sync_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.external_db_sync_logs (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    connection_id character varying,
    sync_type text NOT NULL,
    status text NOT NULL,
    records_imported integer DEFAULT 0,
    records_failed integer DEFAULT 0,
    error_message text,
    details text,
    started_at timestamp without time zone DEFAULT now(),
    completed_at timestamp without time zone
);


--
-- Name: failed_login_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.failed_login_logs (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    username_attempted text NOT NULL,
    user_id character varying,
    ip_address text,
    user_agent text,
    failure_reason text NOT NULL,
    attempts_count integer DEFAULT 1,
    is_blocked boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: http_endpoints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.http_endpoints (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    method text DEFAULT 'POST'::text,
    content_type text DEFAULT 'application/json'::text,
    auth_type text DEFAULT 'open'::text,
    auth_token text DEFAULT ''::text,
    allowed_ips text DEFAULT ''::text,
    description text DEFAULT ''::text,
    is_active boolean DEFAULT true,
    total_requests integer DEFAULT 0,
    total_success integer DEFAULT 0,
    total_failed integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: http_forwarding_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.http_forwarding_rules (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    agent_id character varying,
    agent_name text,
    url text NOT NULL,
    method text DEFAULT 'POST'::text,
    headers text DEFAULT '{}'::text,
    active boolean DEFAULT true,
    description text,
    created_at timestamp without time zone DEFAULT now(),
    receiver_url text,
    protocol text DEFAULT 'HTTP_POST'::text,
    message_count integer DEFAULT 0
);


--
-- Name: http_incoming_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.http_incoming_logs (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    endpoint_id character varying,
    endpoint_name text DEFAULT ''::text,
    ip_address text DEFAULT ''::text,
    method text DEFAULT ''::text,
    headers text DEFAULT '{}'::text,
    body text DEFAULT ''::text,
    query_params text DEFAULT '{}'::text,
    status text DEFAULT 'SUCCESS'::text,
    status_code integer DEFAULT 200,
    error_message text DEFAULT ''::text,
    response_body text DEFAULT ''::text,
    user_agent text DEFAULT ''::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: http_incoming_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.http_incoming_messages (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    provider_id character varying,
    provider_name text DEFAULT ''::text,
    sender_ip text DEFAULT ''::text,
    cli text DEFAULT ''::text,
    message_content text DEFAULT ''::text,
    unique_id text DEFAULT ''::text,
    is_duplicate boolean DEFAULT false,
    raw_body text DEFAULT ''::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: http_incoming_providers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.http_incoming_providers (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    token text DEFAULT ''::text,
    ip_addresses text DEFAULT ''::text,
    cli_field text DEFAULT 'cli'::text,
    message_field text DEFAULT 'message'::text,
    unique_id_field text DEFAULT 'uuid'::text,
    is_active boolean DEFAULT true,
    total_received integer DEFAULT 0,
    last_ip text DEFAULT ''::text,
    last_received_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: http_smpp_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.http_smpp_messages (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    http_log_id character varying,
    endpoint_id character varying,
    provider_id character varying,
    provider_name text DEFAULT ''::text,
    source_addr text DEFAULT ''::text,
    dest_addr text DEFAULT ''::text,
    message_content text DEFAULT ''::text,
    raw_body text DEFAULT ''::text,
    smpp_status text DEFAULT 'pending'::text,
    smpp_message_id text DEFAULT ''::text,
    smpp_error text DEFAULT ''::text,
    encoding text DEFAULT 'GSM'::text,
    ip_address text DEFAULT ''::text,
    sent_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: inactivity_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inactivity_notifications (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    user_id character varying NOT NULL,
    type text NOT NULL,
    title text NOT NULL,
    message text NOT NULL,
    inactive_days integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: incoming_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.incoming_messages (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    msgid text DEFAULT ''::text,
    number text DEFAULT ''::text,
    message text DEFAULT ''::text,
    status text DEFAULT 'pending'::text,
    raw_status text DEFAULT ''::text,
    "time" text DEFAULT ''::text,
    sender_ip text DEFAULT ''::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: login_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.login_history (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    user_id character varying,
    username text,
    role text,
    ip_address text,
    user_agent text,
    device text,
    browser text,
    os text,
    status text DEFAULT 'success'::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: message_ownership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.message_ownership (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    message_id character varying NOT NULL,
    owner_user_id character varying,
    owner_role text DEFAULT 'AGENT'::text,
    agent_id character varying,
    client_id character varying,
    range_id character varying,
    range_name text,
    number_id character varying,
    payout text DEFAULT '0.00'::text,
    agent_payout text DEFAULT '0.00'::text,
    client_payout text DEFAULT '0.00'::text,
    currency text DEFAULT 'USD'::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: message_reactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.message_reactions (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    message_id character varying NOT NULL,
    user_id character varying NOT NULL,
    emoji text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    "time" timestamp without time zone DEFAULT now(),
    country text NOT NULL,
    number text NOT NULL,
    cllr text NOT NULL,
    content text,
    user_id character varying,
    range text,
    payout text DEFAULT '0.00'::text,
    client_payout text DEFAULT '0.00'::text,
    currency text DEFAULT '$'::text,
    client_name text,
    provider text,
    type text DEFAULT 'General'::text,
    agent_name text,
    manager_name text,
    agent_payout text DEFAULT '0.00'::text,
    cause text DEFAULT 'Success'::text,
    ip text
);


--
-- Name: news; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.news (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    type text NOT NULL,
    url text,
    is_active boolean DEFAULT true,
    created_by character varying,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: number_assignment_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.number_assignment_history (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    user_id character varying NOT NULL,
    number text NOT NULL,
    range_id character varying,
    payout text DEFAULT '0.00'::text,
    is_test boolean DEFAULT false,
    assigned_at timestamp without time zone DEFAULT now(),
    removed_at timestamp without time zone
);


--
-- Name: number_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.number_requests (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    user_id character varying,
    country_id character varying,
    quantity integer NOT NULL,
    site_url text,
    status text DEFAULT 'pending'::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_methods (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    icon text,
    image_url text,
    account_placeholder text DEFAULT 'Enter account details'::text,
    currency text DEFAULT 'EGP'::text,
    sort_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: payment_withdrawals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_withdrawals (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    agent_id character varying NOT NULL,
    agent_name text,
    amount_usd text NOT NULL,
    amount_egp text,
    currency text DEFAULT 'USD'::text,
    exchange_rate text,
    method_id text,
    method_name text,
    account_details text,
    status text DEFAULT 'pending'::text,
    proof_image_url text,
    admin_note text,
    reviewed_by character varying,
    reviewed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: phone_numbers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.phone_numbers (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    number text NOT NULL,
    country_id character varying,
    is_active boolean DEFAULT true,
    user_id character varying,
    client_id character varying,
    payout text DEFAULT '0.00'::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: platform_info; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.platform_info (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    platform_name text DEFAULT 'Express SMS'::text,
    platform_subtitle text DEFAULT 'International SMS Platform'::text,
    contact_email text DEFAULT ''::text,
    contact_email_visible boolean DEFAULT false,
    facebook_url text DEFAULT ''::text,
    facebook_visible boolean DEFAULT false,
    whatsapp_number text DEFAULT ''::text,
    whatsapp_visible boolean DEFAULT false,
    telegram_username text DEFAULT ''::text,
    telegram_visible boolean DEFAULT false,
    sidebar_ticker_text text DEFAULT ''::text,
    sidebar_ticker_enabled boolean DEFAULT false,
    ramadan_mode boolean DEFAULT false,
    login_background_type text DEFAULT 'default'::text,
    login_background_image text DEFAULT ''::text,
    login_gradient_color1 text DEFAULT '#0a1520'::text,
    login_gradient_color2 text DEFAULT '#1a2332'::text,
    custom_exchange_rate text,
    min_withdrawal_usd text DEFAULT '0'::text,
    min_withdrawal_egp text DEFAULT '0'::text,
    withdrawal_window_enabled boolean DEFAULT false,
    withdrawal_window_days text DEFAULT ''::text,
    withdrawal_window_start_hour integer DEFAULT 9,
    withdrawal_window_start_minute integer DEFAULT 0,
    withdrawal_window_end_hour integer DEFAULT 17,
    withdrawal_window_end_minute integer DEFAULT 0,
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


--
-- Name: smpp_dlr_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.smpp_dlr_reports (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    message_id text NOT NULL,
    provider_id character varying,
    source_addr text DEFAULT ''::text,
    dest_addr text DEFAULT ''::text,
    dlr_status text NOT NULL,
    error_code text DEFAULT ''::text,
    submit_date text DEFAULT ''::text,
    done_date text DEFAULT ''::text,
    details text DEFAULT ''::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: smpp_gateway_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.smpp_gateway_groups (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text DEFAULT ''::text,
    max_throughput integer DEFAULT 100,
    default_provider_id character varying,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: smpp_gateway_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.smpp_gateway_users (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    group_id character varying,
    provider_id character varying,
    is_active boolean DEFAULT true,
    max_binds integer DEFAULT 1,
    throughput integer DEFAULT 10,
    allowed_ips text DEFAULT ''::text,
    default_sender_id text DEFAULT ''::text,
    default_encoding text DEFAULT 'GSM'::text,
    total_sent integer DEFAULT 0,
    total_delivered integer DEFAULT 0,
    total_failed integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: smpp_http_api_keys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.smpp_http_api_keys (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    api_key text NOT NULL,
    api_secret text NOT NULL,
    gateway_user_id character varying,
    provider_id character varying,
    is_active boolean DEFAULT true,
    rate_limit integer DEFAULT 10,
    allowed_ips text DEFAULT ''::text,
    total_requests integer DEFAULT 0,
    last_used_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: smpp_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.smpp_logs (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    provider_id character varying,
    event_type text NOT NULL,
    direction text DEFAULT 'outgoing'::text,
    source_addr text DEFAULT ''::text,
    dest_addr text DEFAULT ''::text,
    message_content text DEFAULT ''::text,
    status text DEFAULT ''::text,
    message_id text DEFAULT ''::text,
    dlr_status text DEFAULT ''::text,
    error_code text DEFAULT ''::text,
    details text DEFAULT ''::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: sms_numbers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sms_numbers (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    range_id character varying,
    number text NOT NULL,
    user_id character varying,
    client_id character varying,
    payout text DEFAULT '0.00'::text,
    agent_payout text DEFAULT '0.00'::text,
    client_payout text DEFAULT '0.00'::text,
    is_test boolean DEFAULT false,
    number_msg_limit integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    deleted_at timestamp without time zone
);


--
-- Name: sms_providers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sms_providers (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    provider_name text NOT NULL,
    email text DEFAULT ''::text,
    ip_addresses text DEFAULT ''::text,
    esme_username text DEFAULT ''::text,
    esme_password text DEFAULT ''::text,
    number_field text DEFAULT 'number'::text,
    cli_field text DEFAULT 'cli'::text,
    message_field text DEFAULT 'message'::text,
    unique_id_field text DEFAULT 'uuid'::text,
    return_value text DEFAULT 'OK-#uuid'::text,
    smpp_host text DEFAULT ''::text,
    smpp_port text DEFAULT '2775'::text,
    system_id text DEFAULT ''::text,
    smsc_password text DEFAULT ''::text,
    bind_mode text DEFAULT ''::text,
    connection_allowed_ip text DEFAULT ''::text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    bind_type text DEFAULT 'transceiver'::text,
    system_type text DEFAULT ''::text,
    interface_version text DEFAULT '3.4'::text,
    rate_limit integer DEFAULT 100,
    sender_ids text DEFAULT ''::text,
    message_type text DEFAULT 'OTP'::text,
    encoding text DEFAULT 'GSM'::text,
    dlr_enabled boolean DEFAULT true,
    priority integer DEFAULT 1,
    auto_reconnect boolean DEFAULT true,
    ip_whitelist text DEFAULT ''::text,
    bind_status text DEFAULT 'disconnected'::text,
    failover_order integer DEFAULT 0,
    last_bind_at timestamp without time zone,
    last_error_message text DEFAULT ''::text,
    total_sent integer DEFAULT 0,
    total_delivered integer DEFAULT 0,
    total_failed integer DEFAULT 0
);


--
-- Name: sms_ranges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sms_ranges (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    provider text DEFAULT ''::text,
    prefix text DEFAULT ''::text,
    active boolean DEFAULT true,
    currency text DEFAULT 'USD'::text,
    payterm text DEFAULT '7/1'::text,
    cli_list text DEFAULT ''::text,
    country_id character varying,
    available_count integer DEFAULT 0,
    unavailable_count integer DEFAULT 0,
    payout text DEFAULT '0.00'::text,
    agent_payout text DEFAULT '0.00'::text,
    max_sms_limit_day integer DEFAULT 0,
    max_sms_limit_week integer DEFAULT 0,
    range_msg_limit integer DEFAULT 0,
    test_number text DEFAULT ''::text,
    memo_text text DEFAULT ''::text,
    payout_1_1 text DEFAULT '0'::text,
    payout_7_1 text DEFAULT '0'::text,
    payout_7_7 text DEFAULT '0'::text,
    payout_15_15 text DEFAULT '0'::text,
    payout_15_30 text DEFAULT '0'::text,
    payout_30_15 text DEFAULT '0'::text,
    payout_30_30 text DEFAULT '0'::text,
    payout_30_45 text DEFAULT '0'::text,
    payout_30_60 text DEFAULT '0'::text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: sms_test_numbers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sms_test_numbers (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    country_id character varying,
    country_name text NOT NULL,
    numbers text NOT NULL,
    quantity integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: source_ranges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.source_ranges (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    source_id character varying,
    range_id character varying,
    is_active boolean DEFAULT true,
    delivery_percentage text DEFAULT '100'::text
);


--
-- Name: sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sources (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    image text,
    description text DEFAULT ''::text,
    counter_increment integer DEFAULT 2,
    counter_base integer DEFAULT 0,
    is_counter_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: support_conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.support_conversations (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    user_id character varying NOT NULL,
    subject text NOT NULL,
    status text DEFAULT 'open'::text,
    priority text DEFAULT 'medium'::text,
    assigned_agent_id character varying,
    sla_deadline timestamp without time zone,
    sla_resolution_deadline timestamp without time zone,
    is_muted boolean DEFAULT false,
    muted_until timestamp without time zone,
    is_blocked boolean DEFAULT false,
    archived boolean DEFAULT false,
    unread_count integer DEFAULT 0,
    last_message_at timestamp without time zone DEFAULT now(),
    last_reply_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: support_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.support_messages (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    conversation_id character varying NOT NULL,
    sender_id character varying NOT NULL,
    sender_role text NOT NULL,
    content text NOT NULL,
    message_type text DEFAULT 'text'::text,
    media_url text,
    delivered_at timestamp without time zone,
    read_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: telegram_bot_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telegram_bot_config (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    bot_token text NOT NULL,
    bot_username text NOT NULL,
    admin_telegram_id text,
    additional_admin_ids text[],
    min_amount text DEFAULT '10'::text,
    max_amount text DEFAULT '10000'::text,
    min_amount_usd text DEFAULT '20'::text,
    max_amount_usd text DEFAULT '1000'::text,
    min_amount_egp text DEFAULT '1000'::text,
    max_amount_egp text DEFAULT '10000'::text,
    notifications_enabled boolean DEFAULT true,
    welcome_message text,
    success_message text,
    schedule_enabled boolean DEFAULT false,
    schedule_days text[],
    schedule_start_time text,
    schedule_end_time text,
    schedule_timezone text DEFAULT 'Africa/Cairo'::text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: telegram_bot_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telegram_bot_users (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    chat_id text NOT NULL,
    first_name text,
    username text,
    is_admin boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: test_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test_requests (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    country text NOT NULL,
    number text NOT NULL,
    cllr text NOT NULL,
    sms text,
    user_id character varying,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: ticket_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ticket_attachments (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    ticket_id character varying NOT NULL,
    message_id character varying,
    file_name text NOT NULL,
    file_size integer NOT NULL,
    file_type text NOT NULL,
    url text NOT NULL,
    uploaded_by character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: time_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.time_settings (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    counter_type text NOT NULL,
    reset_hour integer DEFAULT 0 NOT NULL,
    reset_minute integer DEFAULT 0 NOT NULL,
    is_enabled boolean DEFAULT false,
    last_reset_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    first_name text NOT NULL,
    second_name text NOT NULL,
    email text,
    password text NOT NULL,
    activation_code text,
    is_active boolean DEFAULT false,
    role text DEFAULT 'user'::text,
    created_by character varying,
    created_at timestamp without time zone DEFAULT now(),
    username text,
    contact text,
    skype_id text,
    company_name text,
    address text,
    country text,
    scrub_percent integer DEFAULT 0,
    usd_balance text DEFAULT '0'::text,
    eur_balance text DEFAULT '0'::text,
    gbp_balance text DEFAULT '0'::text,
    egp_balance text DEFAULT '0'::text,
    sms_delivery_via text DEFAULT 'HTTP'::text,
    http_delivery_url text,
    email_active boolean DEFAULT true,
    verified boolean DEFAULT false,
    bind_status text DEFAULT 'HTTP'::text,
    manager character varying,
    unique_code text,
    unique_code_generated_at timestamp without time zone,
    last_login timestamp without time zone,
    profile_picture text,
    phone text,
    expires_at timestamp without time zone,
    active_from text,
    active_to text,
    webhook_url text
);


--
-- Name: webhook_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhook_logs (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    user_id character varying NOT NULL,
    event text NOT NULL,
    message_id text,
    number text,
    cli text,
    content text,
    range text,
    provider text,
    received_at text,
    raw_payload text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: withdraw_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.withdraw_logs (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    user_id character varying,
    username text,
    role text,
    client_id character varying,
    client_name text,
    range_id character varying,
    range_name text,
    action text NOT NULL,
    status text DEFAULT 'success'::text NOT NULL,
    failure_reason text,
    ip_address text,
    user_agent text,
    details text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: withdraw_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.withdraw_requests (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    number_id character varying,
    number_text text,
    agent_id character varying NOT NULL,
    client_id character varying,
    client_name text,
    status text DEFAULT 'pending'::text,
    reason text,
    reviewed_by character varying,
    reviewed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: _cleanup_flags _cleanup_flags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

