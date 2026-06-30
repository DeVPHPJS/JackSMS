-- MGS Panel - Migration to Supabase
-- Run this entire script in Supabase SQL Editor

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
-- Data for Name: _cleanup_flags; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._cleanup_flags (key, done_at) FROM stdin;
stats_reset_v2	2026-03-29 02:11:23.96056
\.


--
-- Data for Name: activation_codes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.activation_codes (id, code, name, country, whatsapp_number, email, is_used, created_at) FROM stdin;
\.


--
-- Data for Name: agent_number_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.agent_number_requests (id, user_id, range_id, quantity, status, approved_by, created_at) FROM stdin;
\.


--
-- Data for Name: announcements; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.announcements (id, title, body, image_url, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: api_connections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.api_connections (id, name, api_token, api_url, status, last_checked_at, last_error, is_active, auto_fetch, fetch_interval_seconds, last_fetched_at, last_fetched_record_date, total_fetched, created_at) FROM stdin;
\.


--
-- Data for Name: api_keys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.api_keys (id, key, name, user_id, is_active, created_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: archived_accounts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.archived_accounts (id, original_user_id, username, first_name, second_name, email, role, created_by, contact, skype_id, company_name, address, country, is_active, original_created_at, archived_at) FROM stdin;
4b52dc07-2b7a-47b3-a72b-81ee61af0a17	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	Admin	User	admin@expresssms.com	admin	\N	\N	\N	\N	\N	\N	t	2026-03-28 15:56:03.83	2026-03-28 15:56:18.227625
cb1b99cd-8a36-4698-a66b-1fdfe964a371	35f40ac5-8b22-4cdf-b8c1-10a143fa3626	tester	Tester	Account	tester@expresssms.com	tester	\N	\N	\N	\N	\N	\N	t	2026-03-28 15:56:03.928	2026-03-28 15:56:18.227625
b1aee36f-ef35-4e81-b293-38e6d21f2f5b	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020				agent	9df05e38-e174-48ec-a09f-ec2327cb02b1					Afghanistan	t	2026-03-28 21:29:15.744	2026-03-28 21:31:45.967996
d52e1d52-c815-4d71-aa73-edb38393cbf3	002b9a59-adef-4e9c-9c0d-e3d3c91b7678	Ajememe				agent	9df05e38-e174-48ec-a09f-ec2327cb02b1			Ejej		Afghanistan	t	2026-03-29 02:15:55.773	2026-03-29 02:20:31.712204
f40b08ac-18af-47b4-a850-53d5f0bc0405	2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f	Team_X				agent	9df05e38-e174-48ec-a09f-ec2327cb02b1					Afghanistan	t	2026-03-29 03:22:33.71	2026-03-29 15:51:20.390001
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audit_logs (id, actor_user_id, actor_username, action, entity_type, entity_id, status, ip_address, user_agent, details, meta, created_at) FROM stdin;
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.clients (id, username, name, email, password, contact, skype, company, address, country, balance, status, agent_id, created_at, profile_picture) FROM stdin;
9c3f7e06-26d1-4b9d-9380-5b19e3a23fc6	Alexey303020			$2b$10$/2bOnFLMrKxZ2MFxNSQbZulRz4oNBbfklQ1JX88mPOwyIeHEAMxQi						0.00	active	e1f0ac88-8281-4788-beeb-0d7ef7054672	2026-03-29 02:49:33.728651	\N
73457994-ddc9-40e9-80fb-ef47d5d40db3	sysadmin			$2b$10$tIJvxSmtfYo5yxcjF3uCbutbW/1zWrHR55AToax1ReUAA07pkg2nO						0.00	active	e1f0ac88-8281-4788-beeb-0d7ef7054672	2026-03-29 02:50:56.849384	\N
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.countries (id, name, code, price, available_numbers) FROM stdin;
\.


--
-- Data for Name: credit_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credit_requests (id, user_id, amount, currency, payment_method_id, status, telegram_chat_id, created_at, processed_at) FROM stdin;
\.


--
-- Data for Name: dlr_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dlr_messages (id, msgid, number, message, status, raw_status, "time", sender_ip, created_at) FROM stdin;
\.


--
-- Data for Name: external_db_connections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.external_db_connections (id, name, db_type, host, port, database, username, password, ssl_enabled, is_active, status, last_tested_at, last_sync_at, sync_interval, sync_type, table_mappings, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: external_db_sync_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.external_db_sync_logs (id, connection_id, sync_type, status, records_imported, records_failed, error_message, details, started_at, completed_at) FROM stdin;
\.


--
-- Data for Name: failed_login_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.failed_login_logs (id, username_attempted, user_id, ip_address, user_agent, failure_reason, attempts_count, is_blocked, created_at) FROM stdin;
c29eaea0-31cc-4f91-9e03-6e0008a19b5e	Alexey303020	e1f0ac88-8281-4788-beeb-0d7ef7054672	127.0.0.1	curl/8.14.1	Password Incorrect	1	f	2026-03-29 03:17:01.508156
b21ca3e8-5dec-4c0a-9662-25d006a10c59	Wrong password for user: Alexey303020	\N	127.0.0.1	curl/8.14.1	Invalid credentials	1	f	2026-03-29 03:17:01.529221
ccfc00fc-bdca-49b2-9acd-2191e4efe8a8	admin	9df05e38-e174-48ec-a09f-ec2327cb02b1	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Password Incorrect	1	f	2026-03-29 03:18:41.229747
d24b2d01-a67b-46e4-ae21-f265ac77f7c1	Wrong password for user: admin	\N	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Invalid credentials	1	f	2026-03-29 03:18:41.233367
b6b75e1b-b4fd-487a-b7dc-b682a6fb2dc2	Alexey303020	e1f0ac88-8281-4788-beeb-0d7ef7054672	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Password Incorrect	2	f	2026-03-29 03:20:33.262542
a822c185-1bb8-49f1-baf2-8271f0bb088f	Wrong password for user: Alexey303020	\N	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Invalid credentials	1	f	2026-03-29 03:20:33.265467
1e9fdd90-ef13-463f-a348-d36fa7674b47	Alexey303020	e1f0ac88-8281-4788-beeb-0d7ef7054672	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Password Incorrect	3	f	2026-03-29 03:20:35.562435
37e29339-74a1-4465-a73b-691bf718ea03	Wrong password for user: Alexey303020	\N	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Invalid credentials	1	f	2026-03-29 03:20:35.565913
3e401a80-5c87-44f0-8fd5-a4e64d2beb51	Ajememe	002b9a59-adef-4e9c-9c0d-e3d3c91b7678	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Password Incorrect	1	f	2026-03-29 03:21:37.045844
bfeed126-11e5-4d24-bbee-ae72b84e968c	Wrong password for user: Ajememe	\N	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Invalid credentials	1	f	2026-03-29 03:21:37.052073
\.


--
-- Data for Name: http_endpoints; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.http_endpoints (id, name, slug, method, content_type, auth_type, auth_token, allowed_ips, description, is_active, total_requests, total_success, total_failed, created_at) FROM stdin;
0f2b58b3-0e83-494e-ab40-f47bf1e1032e	HTTP Incoming Gateway	incoming-mnb4mriu	ANY	application/json	open			Auto-generated HTTP incoming endpoint - receives data via msg field	t	1	1	0	2026-03-29 02:15:13.056393
\.


--
-- Data for Name: http_forwarding_rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.http_forwarding_rules (id, agent_id, agent_name, url, method, headers, active, description, created_at, receiver_url, protocol, message_count) FROM stdin;
c6fa1b0a-c389-4398-82c3-df710bdbf14a	9df05e38-e174-48ec-a09f-ec2327cb02b1	Admin User	https://6a6b5212-b320-4867-b112-0e4fab5b8b1e-00-2q446o1n994vk.kirk.replit.dev/http/incoming/incoming-mnb4mriu	POST	{}	t	https://6a6b5212-b320-4867-b112-0e4fab5b8b1e-00-2q446o1n994vk.kirk.replit.dev/incoming-messages	2026-03-29 02:38:44.045653	https://6a6b5212-b320-4867-b112-0e4fab5b8b1e-00-2q446o1n994vk.kirk.replit.dev/http/incoming/incoming-mnb4mriu	HTTP_POST	0
\.


--
-- Data for Name: http_incoming_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.http_incoming_logs (id, endpoint_id, endpoint_name, ip_address, method, headers, body, query_params, status, status_code, error_message, response_body, user_agent, created_at) FROM stdin;
712a6617-a31f-48ce-b4de-39fa5fb55d0a	0f2b58b3-0e83-494e-ab40-f47bf1e1032e	HTTP Incoming Gateway	34.83.161.87	POST	{"host":"6a6b5212-b320-4867-b112-0e4fab5b8b1e-00-2q446o1n994vk.kirk.replit.dev","user-agent":"node","content-length":"73","accept":"*/*","accept-encoding":"br, gzip, deflate","accept-language":"*","content-type":"application/json","sec-fetch-mode":"cors","traceparent":"00-69c890a400000000290ff0f34e54bb3b-3f16008187974cbe-00","tracestate":"dd=s:0;p:3f16008187974cbe;t.tid:69c890a400000000","x-datadog-parent-id":"4545821430202715326","x-datadog-sampling-priority":"0","x-datadog-tags":"_dd.p.tid=69c890a400000000","x-datadog-trace-id":"2958848407987600187","x-forwarded-for":"34.83.161.87, 10.82.10.94, 127.0.0.1","x-forwarded-proto":"https","x-mgs-test":"true","x-replit-user-bio":"","x-replit-user-id":"","x-replit-user-name":"","x-replit-user-profile-image":"","x-replit-user-roles":"","x-replit-user-teams":"","x-replit-user-url":""}	{"test":true,"source":"mgs-panel","timestamp":"2026-03-29T02:38:28.806Z"}	{}	SUCCESS	200		{"status":"OK","message":"Received","msg":"mgs-panel","num":null,"cli":"mgs-panel","dt":"2026-03-29T02:38:28.806Z","timestamp":"2026-03-29T02:38:28.816Z"}	node	2026-03-29 02:38:28.816937
\.


--
-- Data for Name: http_incoming_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.http_incoming_messages (id, provider_id, provider_name, sender_ip, cli, message_content, unique_id, is_duplicate, raw_body, created_at) FROM stdin;
\.


--
-- Data for Name: http_incoming_providers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.http_incoming_providers (id, name, slug, token, ip_addresses, cli_field, message_field, unique_id_field, is_active, total_received, last_ip, last_received_at, created_at) FROM stdin;
\.


--
-- Data for Name: http_smpp_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.http_smpp_messages (id, http_log_id, endpoint_id, provider_id, provider_name, source_addr, dest_addr, message_content, raw_body, smpp_status, smpp_message_id, smpp_error, encoding, ip_address, sent_at, created_at) FROM stdin;
\.


--
-- Data for Name: inactivity_notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inactivity_notifications (id, user_id, type, title, message, inactive_days, created_at) FROM stdin;
\.


--
-- Data for Name: incoming_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.incoming_messages (id, msgid, number, message, status, raw_status, "time", sender_ip, created_at) FROM stdin;
\.


--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.login_history (id, user_id, username, role, ip_address, user_agent, device, browser, os, status, created_at) FROM stdin;
8ba98810-974e-47ab-9726-19c2a0c8038f	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.207.153	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0	Desktop	Chrome/144	Windows NT 10.0	success	2026-03-28 16:05:52.713516
93a33933-1e9b-4c05-a263-7dee61c0f9f7	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.207.153	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0	Desktop	Chrome/144	Windows NT 10.0	success	2026-03-28 16:06:47.879134
af258f0d-7050-4a27-ac75-da1780c0ebcb	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	success	2026-03-28 20:46:50.684639
725e1738-f803-4aaf-8029-f6a19f1de5eb	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	logout	2026-03-28 20:49:06.935954
fc476d79-b74a-4499-85f1-935ba4b1ca62	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	success	2026-03-28 20:53:17.816369
9553f86f-8c77-408e-b6f1-c5cc890394e0	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 21:28:48.520012
e972258c-31bb-4229-a0a5-2e5145b048f1	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	logout	2026-03-28 21:29:23.159765
98e23a55-4f5a-44c4-b775-d702217a4f4b	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 21:29:34.269182
9ecab490-33b5-4f82-a5be-f0c2773fc494	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	logout	2026-03-28 21:29:47.057808
b08b53f5-77f1-4acc-98ff-838ea69a0c1e	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 21:40:28.496982
f5c71a4e-2cf5-4530-878e-596163ae91df	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	logout	2026-03-28 21:41:04.849651
ae2d059d-5389-4cd4-8012-3397b94eb483	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 21:41:19.167589
1ed80203-2fe9-4c91-af1e-f9dc9bb9db20	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	logout	2026-03-28 21:41:35.209335
eb7bafcd-7014-4c6f-bb71-60872f6d6717	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 21:49:42.011705
ce67c923-f5a2-4107-807b-049268ce9682	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	logout	2026-03-28 21:55:15.1728
d55a20cd-07f9-4d7b-9825-871e6732da8f	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 21:55:44.630904
a8b987ee-6372-46cb-bc20-7fe5d4bf61d1	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	logout	2026-03-28 22:05:19.773459
8c6f8d7d-53b0-4ec5-8788-e7ed39983ce9	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 22:05:35.415406
6773758d-f245-41a4-ad52-ed30d4a11c8e	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	logout	2026-03-28 22:06:28.428342
33699a27-43c8-480e-8992-f4ae70e5a983	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 22:06:36.982521
6531211d-6dc3-47af-92ef-e7c880e389ae	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 22:08:03.504844
1c88dca0-8d38-4137-aedd-678b8fed30a6	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	logout	2026-03-28 22:08:20.842123
9e70ae2d-4f89-4c53-b165-844f0a62d44a	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 22:08:36.228303
6a67e5ba-b728-4591-99b1-8582417636a4	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	logout	2026-03-28 22:08:57.064971
ddc8e93a-a015-44ab-aa01-88eabe4e6712	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.207.153	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Desktop	Chrome/146	Linux	success	2026-03-28 22:09:06.222259
8b05a70d-ef04-4366-970f-d4f670ae6eee	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	127.0.0.1	curl/8.14.1	Desktop	Unknown	Unknown	success	2026-03-29 02:11:43.837195
c9688beb-3eed-44b7-a920-3a61870e5f9e	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	success	2026-03-29 02:14:13.234477
221624e0-8792-413b-8cb8-e344b0783ef1	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	127.0.0.1	curl/8.14.1	Desktop	Unknown	Unknown	success	2026-03-29 02:23:05.636238
5063fe0b-1875-428f-b7d1-dd6d35a2abee	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	127.0.0.1	curl/8.14.1	Desktop	Unknown	Unknown	success	2026-03-29 02:26:25.650869
5bd08b74-9d81-43ad-a542-044d6c1cb2f7	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	127.0.0.1	curl/8.14.1	Desktop	Unknown	Unknown	success	2026-03-29 02:27:15.87478
aa3ea8b7-eca7-4ea9-88db-81197ade33c5	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	127.0.0.1	curl/8.14.1	Desktop	Unknown	Unknown	success	2026-03-29 02:33:39.664265
c224e8ba-42c1-449b-921c-a002f37f9ce8	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	logout	2026-03-29 02:44:35.490205
af573dc8-e40e-4f24-88f8-7a3839bc233b	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	success	2026-03-29 02:44:43.694346
9127e185-633a-49d5-bcb4-14378a996bc3	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	logout	2026-03-29 02:49:42.380184
083876ce-a714-4f96-a260-bcc8798b155b	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	success	2026-03-29 02:49:50.200627
d7f1abdf-1b2b-4775-8a21-ce342186ba67	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	logout	2026-03-29 02:51:04.485748
846c0ca3-c844-474b-b414-5305059cd879	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	127.0.0.1	curl/8.14.1	Desktop	Unknown	Unknown	success	2026-03-29 02:56:11.55753
8ba4f13f-778f-4cee-8e5f-b11201a821d6	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	127.0.0.1	curl/8.14.1	Desktop	Unknown	Unknown	success	2026-03-29 02:59:54.876192
4fbc4633-826e-4ea6-8411-fd205d13fdb0	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	success	2026-03-29 03:01:44.091041
63f2dd54-f0d8-4ca3-a328-6c180458be8f	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	127.0.0.1	curl/8.14.1	Desktop	Unknown	Unknown	success	2026-03-29 03:16:59.636519
2d2ec7b7-807f-4269-bf47-8f0f82daabab	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	127.0.0.1	curl/8.14.1	Desktop	Unknown	Unknown	failed	2026-03-29 03:17:01.504345
cb95df63-9eee-46d9-bb7e-8f233ca99ccc	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	127.0.0.1	curl/8.14.1	Desktop	Unknown	Unknown	success	2026-03-29 03:17:53.928934
6771e5a1-e06d-409c-a831-526c54cb6467	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	logout	2026-03-29 03:18:24.888262
1344db4a-f31d-47e9-8c47-ddbf6811e253	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	failed	2026-03-29 03:18:41.217846
f3b91bbd-e505-4329-acc2-a5564addee0b	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	success	2026-03-29 03:18:49.757363
f39642d4-63ef-4e36-bf45-cf58f7477a50	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	logout	2026-03-29 03:20:26.100522
6a3a76ac-d240-4f57-af44-bd625d1d3430	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	failed	2026-03-29 03:20:33.258554
664cdf19-7d2b-4593-86db-30c43534805d	e1f0ac88-8281-4788-beeb-0d7ef7054672	Alexey303020	agent	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	failed	2026-03-29 03:20:35.55912
ad1d5635-bec1-4374-bc0c-5fd5ba714640	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	success	2026-03-29 03:20:49.265752
5db4c0f4-4623-4899-a00a-66dd94d4ae71	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	logout	2026-03-29 03:21:29.82373
ac375360-1f66-40fa-8cda-a8942def054d	002b9a59-adef-4e9c-9c0d-e3d3c91b7678	Ajememe	agent	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	failed	2026-03-29 03:21:37.040724
49e4b6a6-a624-4f57-a702-f3d209a9a4d6	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	success	2026-03-29 03:21:51.121739
a82b7bf0-ce22-453e-bc3d-7e2fa899ebfe	9df05e38-e174-48ec-a09f-ec2327cb02b1	admin	admin	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	logout	2026-03-29 03:22:39.230977
e38ec1e2-bbf0-4d6a-8513-57eaeaa75c5d	2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f	Team_X	agent	197.192.205.148	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	Mobile	Chrome/146	Linux	success	2026-03-29 03:22:48.332621
\.


--
-- Data for Name: message_ownership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.message_ownership (id, message_id, owner_user_id, owner_role, agent_id, client_id, range_id, range_name, number_id, payout, agent_payout, client_payout, currency, created_at) FROM stdin;
cf8d513c-b8da-49b7-9196-29018dc6d62e	e37087a5-99e9-4503-92a4-aabb6b204ebc	\N	HTTP	\N	\N	\N	\N	\N	0.00	0.00	0.00	USD	2026-03-29 02:38:28.829339
\.


--
-- Data for Name: message_reactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.message_reactions (id, message_id, user_id, emoji, created_at) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.messages (id, "time", country, number, cllr, content, user_id, range, payout, client_payout, currency, client_name, provider, type, agent_name, manager_name, agent_payout, cause, ip) FROM stdin;
e37087a5-99e9-4503-92a4-aabb6b204ebc	2026-03-29 02:38:28.826409	HTTP	34.83.161.87	HTTP Incoming Gateway	mgs-panel	\N	\N	0.00	0.00	$	\N	HTTP Incoming	HTTP	\N	\N	0.00	Success	34.83.161.87
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.news (id, title, content, type, url, is_active, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: number_assignment_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.number_assignment_history (id, user_id, number, range_id, payout, is_test, assigned_at, removed_at) FROM stdin;
\.


--
-- Data for Name: number_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.number_requests (id, user_id, country_id, quantity, site_url, status, created_at) FROM stdin;
\.


--
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_methods (id, name, description, icon, image_url, account_placeholder, currency, sort_order, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: payment_withdrawals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_withdrawals (id, agent_id, agent_name, amount_usd, amount_egp, currency, exchange_rate, method_id, method_name, account_details, status, proof_image_url, admin_note, reviewed_by, reviewed_at, created_at) FROM stdin;
\.


--
-- Data for Name: phone_numbers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.phone_numbers (id, number, country_id, is_active, user_id, client_id, payout, created_at) FROM stdin;
\.


--
-- Data for Name: platform_info; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.platform_info (id, platform_name, platform_subtitle, contact_email, contact_email_visible, facebook_url, facebook_visible, whatsapp_number, whatsapp_visible, telegram_username, telegram_visible, sidebar_ticker_text, sidebar_ticker_enabled, ramadan_mode, login_background_type, login_background_image, login_gradient_color1, login_gradient_color2, custom_exchange_rate, min_withdrawal_usd, min_withdrawal_egp, withdrawal_window_enabled, withdrawal_window_days, withdrawal_window_start_hour, withdrawal_window_start_minute, withdrawal_window_end_hour, withdrawal_window_end_minute, updated_at) FROM stdin;
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.session (sid, sess, expire) FROM stdin;
ERmKGHXt7mtjKt1Akl7wigrUndcHHgSq	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:33:39.679Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}	2026-04-05 02:34:49
zFUAy3VGgGsoftpEkz8wI3pkvBC-vfuU	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:59:54.879Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}	2026-04-05 02:59:55
woTKLwdz-ArdQBvAQ-bLpmgQbCVRfrNT	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T03:09:35.496Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"e1f0ac88-8281-4788-beeb-0d7ef7054672"}	2026-04-05 03:09:36
aKriKwvsXbKVcm9X2hzJUgE4w5TTCgV9	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:23:05.639Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}	2026-04-05 02:23:44
3rQyiWAl8DDQCkvynPk_k6Y71RbJTlzr	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:11:43.842Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}	2026-04-05 02:12:49
3TUBKsUjQ4bHpkO26zs2-SPHk9rZU_OG	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:26:25.654Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}	2026-04-05 02:26:26
xu0NuIgtz3atxVGuUpQgF0foNw--z9jP	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:27:15.879Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}	2026-04-05 02:27:27
CpPX8wOuvh0_Ni-aLaRPBv77abpfdFKP	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T03:16:59.642Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}	2026-04-05 03:18:31
QxV8tX7v1zk0dwPxJO7ZavX_wva7dFLF	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T03:17:53.932Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"e1f0ac88-8281-4788-beeb-0d7ef7054672","userRole":"agent"}	2026-04-05 03:18:31
EJQcyuWARdo0YOJ8FDkf46z-FDh7DL_S	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T03:22:48.335Z","secure":true,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f","userRole":"agent"}	2026-04-05 03:24:14
KPSajhjFS7cvd-lpNtiC8K4ZrNCp47Fm	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T02:56:11.560Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"9df05e38-e174-48ec-a09f-ec2327cb02b1","userRole":"admin"}	2026-04-05 02:57:32
o-XGr5JGPYNZ2-MbDDKW7mwPEA9sR8jZ	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T03:10:19.553Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"e1f0ac88-8281-4788-beeb-0d7ef7054672"}	2026-04-05 03:10:20
\.


--
-- Data for Name: smpp_dlr_reports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.smpp_dlr_reports (id, message_id, provider_id, source_addr, dest_addr, dlr_status, error_code, submit_date, done_date, details, created_at) FROM stdin;
\.


--
-- Data for Name: smpp_gateway_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.smpp_gateway_groups (id, name, description, max_throughput, default_provider_id, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: smpp_gateway_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.smpp_gateway_users (id, username, password, group_id, provider_id, is_active, max_binds, throughput, allowed_ips, default_sender_id, default_encoding, total_sent, total_delivered, total_failed, created_at) FROM stdin;
\.


--
-- Data for Name: smpp_http_api_keys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.smpp_http_api_keys (id, name, api_key, api_secret, gateway_user_id, provider_id, is_active, rate_limit, allowed_ips, total_requests, last_used_at, created_at) FROM stdin;
\.


--
-- Data for Name: smpp_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.smpp_logs (id, provider_id, event_type, direction, source_addr, dest_addr, message_content, status, message_id, dlr_status, error_code, details, created_at) FROM stdin;
\.


--
-- Data for Name: sms_numbers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sms_numbers (id, range_id, number, user_id, client_id, payout, agent_payout, client_payout, is_test, number_msg_limit, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: sms_providers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sms_providers (id, provider_name, email, ip_addresses, esme_username, esme_password, number_field, cli_field, message_field, unique_id_field, return_value, smpp_host, smpp_port, system_id, smsc_password, bind_mode, connection_allowed_ip, is_active, created_at, bind_type, system_type, interface_version, rate_limit, sender_ids, message_type, encoding, dlr_enabled, priority, auto_reconnect, ip_whitelist, bind_status, failover_order, last_bind_at, last_error_message, total_sent, total_delivered, total_failed) FROM stdin;
\.


--
-- Data for Name: sms_ranges; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sms_ranges (id, name, provider, prefix, active, currency, payterm, cli_list, country_id, available_count, unavailable_count, payout, agent_payout, max_sms_limit_day, max_sms_limit_week, range_msg_limit, test_number, memo_text, payout_1_1, payout_7_1, payout_7_7, payout_15_15, payout_15_30, payout_30_15, payout_30_30, payout_30_45, payout_30_60, created_at) FROM stdin;
\.


--
-- Data for Name: sms_test_numbers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sms_test_numbers (id, country_id, country_name, numbers, quantity, created_at) FROM stdin;
\.


--
-- Data for Name: source_ranges; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.source_ranges (id, source_id, range_id, is_active, delivery_percentage) FROM stdin;
\.


--
-- Data for Name: sources; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sources (id, name, image, description, counter_increment, counter_base, is_counter_active, created_at) FROM stdin;
\.


--
-- Data for Name: support_conversations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.support_conversations (id, user_id, subject, status, priority, assigned_agent_id, sla_deadline, sla_resolution_deadline, is_muted, muted_until, is_blocked, archived, unread_count, last_message_at, last_reply_at, updated_at, created_at) FROM stdin;
7795ef7d-023c-4bf7-89f3-c10a43634843	e1f0ac88-8281-4788-beeb-0d7ef7054672	Technical Support	open	medium	\N	2026-03-29 02:06:20.627	2026-03-29 22:06:20.627	f	\N	f	f	1	2026-03-28 22:06:20.9	2026-03-28 22:06:20.9	2026-03-28 22:06:20.9	2026-03-28 22:06:20.628479
0ad0ae05-b411-471e-a9b4-649f02789a4e	2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f	Technical Support	open	medium	\N	2026-03-29 07:23:33.418	2026-03-30 03:23:33.418	f	\N	f	f	1	2026-03-29 03:23:33.682	2026-03-29 03:23:33.682	2026-03-29 03:23:33.682	2026-03-29 03:23:33.419765
\.


--
-- Data for Name: support_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.support_messages (id, conversation_id, sender_id, sender_role, content, message_type, media_url, delivered_at, read_at, created_at) FROM stdin;
12062ea5-5246-48c1-94e3-50c7b321539e	7795ef7d-023c-4bf7-89f3-c10a43634843	e1f0ac88-8281-4788-beeb-0d7ef7054672	agent	مج	text	\N	2026-03-28 22:06:20.9	\N	2026-03-28 22:06:20.900666
d168e857-071e-414f-b0db-ecfe70a24082	0ad0ae05-b411-471e-a9b4-649f02789a4e	2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f	agent	J	text	\N	2026-03-29 03:23:33.682	\N	2026-03-29 03:23:33.682472
\.


--
-- Data for Name: telegram_bot_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telegram_bot_config (id, bot_token, bot_username, admin_telegram_id, additional_admin_ids, min_amount, max_amount, min_amount_usd, max_amount_usd, min_amount_egp, max_amount_egp, notifications_enabled, welcome_message, success_message, schedule_enabled, schedule_days, schedule_start_time, schedule_end_time, schedule_timezone, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: telegram_bot_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telegram_bot_users (id, chat_id, first_name, username, is_admin, created_at) FROM stdin;
\.


--
-- Data for Name: test_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.test_requests (id, country, number, cllr, sms, user_id, created_at) FROM stdin;
\.


--
-- Data for Name: ticket_attachments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ticket_attachments (id, ticket_id, message_id, file_name, file_size, file_type, url, uploaded_by, created_at) FROM stdin;
\.


--
-- Data for Name: time_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.time_settings (id, counter_type, reset_hour, reset_minute, is_enabled, last_reset_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, first_name, second_name, email, password, activation_code, is_active, role, created_by, created_at, username, contact, skype_id, company_name, address, country, scrub_percent, usd_balance, eur_balance, gbp_balance, egp_balance, sms_delivery_via, http_delivery_url, email_active, verified, bind_status, manager, unique_code, unique_code_generated_at, last_login, profile_picture, phone, expires_at, active_from, active_to, webhook_url) FROM stdin;
35f40ac5-8b22-4cdf-b8c1-10a143fa3626	Tester	Account	tester@expresssms.com	$2b$10$UaexnngM.Uni5RF9j/06Qu5Ej0CAfUjyNdUcNSLqY1/ExxrekOuK6	\N	t	tester	\N	2026-03-28 15:56:03.928142	tester	\N	\N	\N	\N	\N	0	0	0	0	0	HTTP	\N	t	f	HTTP	\N	TESTER001	2026-03-28 15:56:03.927	\N	\N	\N	\N	\N	\N	\N
e1f0ac88-8281-4788-beeb-0d7ef7054672			\N	$2b$10$8N2cHjGX/nEzmEUGm0mOVO4/O1tR112EACpuEG7ByFLu73jYdiNRu	\N	t	agent	9df05e38-e174-48ec-a09f-ec2327cb02b1	2026-03-28 21:29:15.74492	Alexey303020					Afghanistan	0	0	0	0	0	HTTP		t	f	HTTP	None	TKN--jGK0eT7SVxfZGnp8w2C7uZ-YfJdJrPT	2026-03-28 22:11:39.793	2026-03-29 03:17:53.922	\N	\N	\N	\N	\N	
9df05e38-e174-48ec-a09f-ec2327cb02b1	Admin	User	admin@expresssms.com	$2b$10$U/Ezn.UvqwFJaDHujuSgeuD6WzAizkrvaKpJecl7J.vSxm8JNJJUK	\N	t	admin	\N	2026-03-28 15:56:03.830635	admin	\N	\N	\N	\N	\N	0	0	0	0	0	HTTP	\N	t	f	HTTP	\N	ADMIN001	2026-03-28 15:56:03.829	2026-03-29 03:21:51.115	\N	\N	\N	\N	\N	\N
2ffd0ac6-fffc-4dc8-b917-4d6e3b65d41f			\N	$2b$10$d8yoFYwrBjaZT7Ccl4MTaOTt.iCc6EJYX8fsYHZpGF6qmKC4BYc.e	\N	t	agent	9df05e38-e174-48ec-a09f-ec2327cb02b1	2026-03-29 03:22:33.710808	Team_X					Afghanistan	0	0	0	0	0	HTTP		t	f	HTTP	None	AGT-8W3K37OX	2026-03-29 03:22:33.709	2026-03-29 03:22:48.326	\N	\N	\N	\N	\N	
002b9a59-adef-4e9c-9c0d-e3d3c91b7678			\N	$2b$10$0vEc7uwIvm5C.9/Vp52hcec5IHvb8DrMVLlOPLZavtgTNzRcmh2L.	\N	t	agent	9df05e38-e174-48ec-a09f-ec2327cb02b1	2026-03-29 02:15:55.773821	Ajememe			Ejej		Afghanistan	0	0	0	0	0	HTTP	https://6a6b5212-b320-4867-b112-0e4fab5b8b1e-00-2q446o1n994vk.kirk.replit.dev/http/incoming/incoming-mnb4mriu	t	f	HTTP	None	AGT-3NFCDB4W	2026-03-29 02:15:55.772	\N	\N	\N	\N	\N	\N	
\.


--
-- Data for Name: webhook_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.webhook_logs (id, user_id, event, message_id, number, cli, content, range, provider, received_at, raw_payload, created_at) FROM stdin;
63a08dca-a926-4371-b1d3-2041fa98d857	e1f0ac88-8281-4788-beeb-0d7ef7054672	unknown	\N	\N	\N	\N	\N	\N	\N	{"number":"+123456","content":"test","from":"test"}	2026-03-29 03:10:19.61904
\.


--
-- Data for Name: withdraw_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.withdraw_logs (id, user_id, username, role, client_id, client_name, range_id, range_name, action, status, failure_reason, ip_address, user_agent, details, created_at) FROM stdin;
\.


--
-- Data for Name: withdraw_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.withdraw_requests (id, number_id, number_text, agent_id, client_id, client_name, status, reason, reviewed_by, reviewed_at, created_at) FROM stdin;
\.


--
-- Name: _cleanup_flags _cleanup_flags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._cleanup_flags
    ADD CONSTRAINT _cleanup_flags_pkey PRIMARY KEY (key);


--
-- Name: activation_codes activation_codes_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activation_codes
    ADD CONSTRAINT activation_codes_code_unique UNIQUE (code);


--
-- Name: activation_codes activation_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activation_codes
    ADD CONSTRAINT activation_codes_pkey PRIMARY KEY (id);


--
-- Name: agent_number_requests agent_number_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_number_requests
    ADD CONSTRAINT agent_number_requests_pkey PRIMARY KEY (id);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: api_connections api_connections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_connections
    ADD CONSTRAINT api_connections_pkey PRIMARY KEY (id);


--
-- Name: api_keys api_keys_key_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_key_unique UNIQUE (key);


--
-- Name: api_keys api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);


--
-- Name: archived_accounts archived_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.archived_accounts
    ADD CONSTRAINT archived_accounts_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: clients clients_username_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_username_unique UNIQUE (username);


--
-- Name: countries countries_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_code_unique UNIQUE (code);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: credit_requests credit_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credit_requests
    ADD CONSTRAINT credit_requests_pkey PRIMARY KEY (id);


--
-- Name: dlr_messages dlr_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dlr_messages
    ADD CONSTRAINT dlr_messages_pkey PRIMARY KEY (id);


--
-- Name: external_db_connections external_db_connections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.external_db_connections
    ADD CONSTRAINT external_db_connections_pkey PRIMARY KEY (id);


--
-- Name: external_db_sync_logs external_db_sync_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.external_db_sync_logs
    ADD CONSTRAINT external_db_sync_logs_pkey PRIMARY KEY (id);


--
-- Name: failed_login_logs failed_login_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_login_logs
    ADD CONSTRAINT failed_login_logs_pkey PRIMARY KEY (id);


--
-- Name: http_endpoints http_endpoints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_endpoints
    ADD CONSTRAINT http_endpoints_pkey PRIMARY KEY (id);


--
-- Name: http_endpoints http_endpoints_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_endpoints
    ADD CONSTRAINT http_endpoints_slug_unique UNIQUE (slug);


--
-- Name: http_forwarding_rules http_forwarding_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_forwarding_rules
    ADD CONSTRAINT http_forwarding_rules_pkey PRIMARY KEY (id);


--
-- Name: http_incoming_logs http_incoming_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_incoming_logs
    ADD CONSTRAINT http_incoming_logs_pkey PRIMARY KEY (id);


--
-- Name: http_incoming_messages http_incoming_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_incoming_messages
    ADD CONSTRAINT http_incoming_messages_pkey PRIMARY KEY (id);


--
-- Name: http_incoming_providers http_incoming_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_incoming_providers
    ADD CONSTRAINT http_incoming_providers_pkey PRIMARY KEY (id);


--
-- Name: http_incoming_providers http_incoming_providers_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_incoming_providers
    ADD CONSTRAINT http_incoming_providers_slug_unique UNIQUE (slug);


--
-- Name: http_smpp_messages http_smpp_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_smpp_messages
    ADD CONSTRAINT http_smpp_messages_pkey PRIMARY KEY (id);


--
-- Name: inactivity_notifications inactivity_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inactivity_notifications
    ADD CONSTRAINT inactivity_notifications_pkey PRIMARY KEY (id);


--
-- Name: incoming_messages incoming_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incoming_messages
    ADD CONSTRAINT incoming_messages_pkey PRIMARY KEY (id);


--
-- Name: login_history login_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_pkey PRIMARY KEY (id);


--
-- Name: message_ownership message_ownership_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_ownership
    ADD CONSTRAINT message_ownership_pkey PRIMARY KEY (id);


--
-- Name: message_reactions message_reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT message_reactions_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: number_assignment_history number_assignment_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.number_assignment_history
    ADD CONSTRAINT number_assignment_history_pkey PRIMARY KEY (id);


--
-- Name: number_requests number_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.number_requests
    ADD CONSTRAINT number_requests_pkey PRIMARY KEY (id);


--
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (id);


--
-- Name: payment_withdrawals payment_withdrawals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_withdrawals
    ADD CONSTRAINT payment_withdrawals_pkey PRIMARY KEY (id);


--
-- Name: phone_numbers phone_numbers_number_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_numbers
    ADD CONSTRAINT phone_numbers_number_unique UNIQUE (number);


--
-- Name: phone_numbers phone_numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_numbers
    ADD CONSTRAINT phone_numbers_pkey PRIMARY KEY (id);


--
-- Name: platform_info platform_info_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform_info
    ADD CONSTRAINT platform_info_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: smpp_dlr_reports smpp_dlr_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_dlr_reports
    ADD CONSTRAINT smpp_dlr_reports_pkey PRIMARY KEY (id);


--
-- Name: smpp_gateway_groups smpp_gateway_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_gateway_groups
    ADD CONSTRAINT smpp_gateway_groups_pkey PRIMARY KEY (id);


--
-- Name: smpp_gateway_users smpp_gateway_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_gateway_users
    ADD CONSTRAINT smpp_gateway_users_pkey PRIMARY KEY (id);


--
-- Name: smpp_http_api_keys smpp_http_api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_http_api_keys
    ADD CONSTRAINT smpp_http_api_keys_pkey PRIMARY KEY (id);


--
-- Name: smpp_logs smpp_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_logs
    ADD CONSTRAINT smpp_logs_pkey PRIMARY KEY (id);


--
-- Name: sms_numbers sms_numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_numbers
    ADD CONSTRAINT sms_numbers_pkey PRIMARY KEY (id);


--
-- Name: sms_providers sms_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_providers
    ADD CONSTRAINT sms_providers_pkey PRIMARY KEY (id);


--
-- Name: sms_ranges sms_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_ranges
    ADD CONSTRAINT sms_ranges_pkey PRIMARY KEY (id);


--
-- Name: sms_test_numbers sms_test_numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_test_numbers
    ADD CONSTRAINT sms_test_numbers_pkey PRIMARY KEY (id);


--
-- Name: source_ranges source_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.source_ranges
    ADD CONSTRAINT source_ranges_pkey PRIMARY KEY (id);


--
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: support_conversations support_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.support_conversations
    ADD CONSTRAINT support_conversations_pkey PRIMARY KEY (id);


--
-- Name: support_messages support_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.support_messages
    ADD CONSTRAINT support_messages_pkey PRIMARY KEY (id);


--
-- Name: telegram_bot_config telegram_bot_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_config
    ADD CONSTRAINT telegram_bot_config_pkey PRIMARY KEY (id);


--
-- Name: telegram_bot_users telegram_bot_users_chat_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_users
    ADD CONSTRAINT telegram_bot_users_chat_id_unique UNIQUE (chat_id);


--
-- Name: telegram_bot_users telegram_bot_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_users
    ADD CONSTRAINT telegram_bot_users_pkey PRIMARY KEY (id);


--
-- Name: test_requests test_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_requests
    ADD CONSTRAINT test_requests_pkey PRIMARY KEY (id);


--
-- Name: ticket_attachments ticket_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_attachments
    ADD CONSTRAINT ticket_attachments_pkey PRIMARY KEY (id);


--
-- Name: time_settings time_settings_counter_type_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_settings
    ADD CONSTRAINT time_settings_counter_type_unique UNIQUE (counter_type);


--
-- Name: time_settings time_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_settings
    ADD CONSTRAINT time_settings_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_unique_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_unique_code_unique UNIQUE (unique_code);


--
-- Name: webhook_logs webhook_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhook_logs
    ADD CONSTRAINT webhook_logs_pkey PRIMARY KEY (id);


--
-- Name: withdraw_logs withdraw_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.withdraw_logs
    ADD CONSTRAINT withdraw_logs_pkey PRIMARY KEY (id);


--
-- Name: withdraw_requests withdraw_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.withdraw_requests
    ADD CONSTRAINT withdraw_requests_pkey PRIMARY KEY (id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_session_expire" ON public.session USING btree (expire);


--
-- Name: agent_number_requests agent_number_requests_range_id_sms_ranges_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_number_requests
    ADD CONSTRAINT agent_number_requests_range_id_sms_ranges_id_fk FOREIGN KEY (range_id) REFERENCES public.sms_ranges(id);


--
-- Name: agent_number_requests agent_number_requests_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_number_requests
    ADD CONSTRAINT agent_number_requests_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: api_keys api_keys_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: audit_logs audit_logs_actor_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_actor_user_id_users_id_fk FOREIGN KEY (actor_user_id) REFERENCES public.users(id);


--
-- Name: clients clients_agent_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_agent_id_users_id_fk FOREIGN KEY (agent_id) REFERENCES public.users(id);


--
-- Name: credit_requests credit_requests_payment_method_id_payment_methods_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credit_requests
    ADD CONSTRAINT credit_requests_payment_method_id_payment_methods_id_fk FOREIGN KEY (payment_method_id) REFERENCES public.payment_methods(id);


--
-- Name: credit_requests credit_requests_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credit_requests
    ADD CONSTRAINT credit_requests_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: external_db_connections external_db_connections_created_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.external_db_connections
    ADD CONSTRAINT external_db_connections_created_by_users_id_fk FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: external_db_sync_logs external_db_sync_logs_connection_id_external_db_connections_id_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.external_db_sync_logs
    ADD CONSTRAINT external_db_sync_logs_connection_id_external_db_connections_id_ FOREIGN KEY (connection_id) REFERENCES public.external_db_connections(id);


--
-- Name: http_forwarding_rules http_forwarding_rules_agent_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_forwarding_rules
    ADD CONSTRAINT http_forwarding_rules_agent_id_users_id_fk FOREIGN KEY (agent_id) REFERENCES public.users(id);


--
-- Name: http_incoming_logs http_incoming_logs_endpoint_id_http_endpoints_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_incoming_logs
    ADD CONSTRAINT http_incoming_logs_endpoint_id_http_endpoints_id_fk FOREIGN KEY (endpoint_id) REFERENCES public.http_endpoints(id);


--
-- Name: http_incoming_messages http_incoming_messages_provider_id_http_incoming_providers_id_f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_incoming_messages
    ADD CONSTRAINT http_incoming_messages_provider_id_http_incoming_providers_id_f FOREIGN KEY (provider_id) REFERENCES public.http_incoming_providers(id) ON DELETE CASCADE;


--
-- Name: http_smpp_messages http_smpp_messages_endpoint_id_http_endpoints_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_smpp_messages
    ADD CONSTRAINT http_smpp_messages_endpoint_id_http_endpoints_id_fk FOREIGN KEY (endpoint_id) REFERENCES public.http_endpoints(id);


--
-- Name: http_smpp_messages http_smpp_messages_http_log_id_http_incoming_logs_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_smpp_messages
    ADD CONSTRAINT http_smpp_messages_http_log_id_http_incoming_logs_id_fk FOREIGN KEY (http_log_id) REFERENCES public.http_incoming_logs(id);


--
-- Name: http_smpp_messages http_smpp_messages_provider_id_sms_providers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.http_smpp_messages
    ADD CONSTRAINT http_smpp_messages_provider_id_sms_providers_id_fk FOREIGN KEY (provider_id) REFERENCES public.sms_providers(id);


--
-- Name: inactivity_notifications inactivity_notifications_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inactivity_notifications
    ADD CONSTRAINT inactivity_notifications_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: login_history login_history_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: message_ownership message_ownership_message_id_messages_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_ownership
    ADD CONSTRAINT message_ownership_message_id_messages_id_fk FOREIGN KEY (message_id) REFERENCES public.messages(id);


--
-- Name: message_ownership message_ownership_owner_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_ownership
    ADD CONSTRAINT message_ownership_owner_user_id_users_id_fk FOREIGN KEY (owner_user_id) REFERENCES public.users(id);


--
-- Name: message_reactions message_reactions_message_id_support_messages_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT message_reactions_message_id_support_messages_id_fk FOREIGN KEY (message_id) REFERENCES public.support_messages(id);


--
-- Name: message_reactions message_reactions_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT message_reactions_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: messages messages_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: news news_created_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_created_by_users_id_fk FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: number_requests number_requests_country_id_countries_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.number_requests
    ADD CONSTRAINT number_requests_country_id_countries_id_fk FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: number_requests number_requests_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.number_requests
    ADD CONSTRAINT number_requests_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: phone_numbers phone_numbers_country_id_countries_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_numbers
    ADD CONSTRAINT phone_numbers_country_id_countries_id_fk FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: phone_numbers phone_numbers_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_numbers
    ADD CONSTRAINT phone_numbers_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: smpp_dlr_reports smpp_dlr_reports_provider_id_sms_providers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_dlr_reports
    ADD CONSTRAINT smpp_dlr_reports_provider_id_sms_providers_id_fk FOREIGN KEY (provider_id) REFERENCES public.sms_providers(id);


--
-- Name: smpp_gateway_groups smpp_gateway_groups_default_provider_id_sms_providers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_gateway_groups
    ADD CONSTRAINT smpp_gateway_groups_default_provider_id_sms_providers_id_fk FOREIGN KEY (default_provider_id) REFERENCES public.sms_providers(id);


--
-- Name: smpp_gateway_users smpp_gateway_users_provider_id_sms_providers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_gateway_users
    ADD CONSTRAINT smpp_gateway_users_provider_id_sms_providers_id_fk FOREIGN KEY (provider_id) REFERENCES public.sms_providers(id);


--
-- Name: smpp_http_api_keys smpp_http_api_keys_gateway_user_id_smpp_gateway_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_http_api_keys
    ADD CONSTRAINT smpp_http_api_keys_gateway_user_id_smpp_gateway_users_id_fk FOREIGN KEY (gateway_user_id) REFERENCES public.smpp_gateway_users(id);


--
-- Name: smpp_http_api_keys smpp_http_api_keys_provider_id_sms_providers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_http_api_keys
    ADD CONSTRAINT smpp_http_api_keys_provider_id_sms_providers_id_fk FOREIGN KEY (provider_id) REFERENCES public.sms_providers(id);


--
-- Name: smpp_logs smpp_logs_provider_id_sms_providers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smpp_logs
    ADD CONSTRAINT smpp_logs_provider_id_sms_providers_id_fk FOREIGN KEY (provider_id) REFERENCES public.sms_providers(id);


--
-- Name: sms_numbers sms_numbers_range_id_sms_ranges_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_numbers
    ADD CONSTRAINT sms_numbers_range_id_sms_ranges_id_fk FOREIGN KEY (range_id) REFERENCES public.sms_ranges(id);


--
-- Name: sms_numbers sms_numbers_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_numbers
    ADD CONSTRAINT sms_numbers_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sms_ranges sms_ranges_country_id_countries_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_ranges
    ADD CONSTRAINT sms_ranges_country_id_countries_id_fk FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: sms_test_numbers sms_test_numbers_country_id_countries_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_test_numbers
    ADD CONSTRAINT sms_test_numbers_country_id_countries_id_fk FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: source_ranges source_ranges_range_id_sms_ranges_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.source_ranges
    ADD CONSTRAINT source_ranges_range_id_sms_ranges_id_fk FOREIGN KEY (range_id) REFERENCES public.sms_ranges(id) ON DELETE CASCADE;


--
-- Name: source_ranges source_ranges_source_id_sources_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.source_ranges
    ADD CONSTRAINT source_ranges_source_id_sources_id_fk FOREIGN KEY (source_id) REFERENCES public.sources(id) ON DELETE CASCADE;


--
-- Name: support_conversations support_conversations_assigned_agent_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.support_conversations
    ADD CONSTRAINT support_conversations_assigned_agent_id_users_id_fk FOREIGN KEY (assigned_agent_id) REFERENCES public.users(id);


--
-- Name: support_conversations support_conversations_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.support_conversations
    ADD CONSTRAINT support_conversations_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: support_messages support_messages_conversation_id_support_conversations_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.support_messages
    ADD CONSTRAINT support_messages_conversation_id_support_conversations_id_fk FOREIGN KEY (conversation_id) REFERENCES public.support_conversations(id);


--
-- Name: support_messages support_messages_sender_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.support_messages
    ADD CONSTRAINT support_messages_sender_id_users_id_fk FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: test_requests test_requests_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_requests
    ADD CONSTRAINT test_requests_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: ticket_attachments ticket_attachments_message_id_support_messages_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_attachments
    ADD CONSTRAINT ticket_attachments_message_id_support_messages_id_fk FOREIGN KEY (message_id) REFERENCES public.support_messages(id);


--
-- Name: ticket_attachments ticket_attachments_ticket_id_support_conversations_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_attachments
    ADD CONSTRAINT ticket_attachments_ticket_id_support_conversations_id_fk FOREIGN KEY (ticket_id) REFERENCES public.support_conversations(id);


--
-- Name: ticket_attachments ticket_attachments_uploaded_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_attachments
    ADD CONSTRAINT ticket_attachments_uploaded_by_users_id_fk FOREIGN KEY (uploaded_by) REFERENCES public.users(id);


--
-- Name: withdraw_requests withdraw_requests_agent_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.withdraw_requests
    ADD CONSTRAINT withdraw_requests_agent_id_users_id_fk FOREIGN KEY (agent_id) REFERENCES public.users(id);


--
-- Name: withdraw_requests withdraw_requests_number_id_sms_numbers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.withdraw_requests
    ADD CONSTRAINT withdraw_requests_number_id_sms_numbers_id_fk FOREIGN KEY (number_id) REFERENCES public.sms_numbers(id);


--
-- Name: withdraw_requests withdraw_requests_reviewed_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.withdraw_requests
    ADD CONSTRAINT withdraw_requests_reviewed_by_users_id_fk FOREIGN KEY (reviewed_by) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--


