CREATE TABLE "activation_codes" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"code" text NOT NULL,
	"name" text NOT NULL,
	"country" text NOT NULL,
	"whatsapp_number" text NOT NULL,
	"email" text NOT NULL,
	"is_used" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "activation_codes_code_unique" UNIQUE("code")
);
--> statement-breakpoint
CREATE TABLE "agent_number_requests" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar,
	"range_id" varchar,
	"quantity" integer NOT NULL,
	"status" text DEFAULT 'pending',
	"approved_by" varchar,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "api_connections" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"api_token" text NOT NULL,
	"api_url" text NOT NULL,
	"status" text DEFAULT 'offline',
	"last_checked_at" timestamp,
	"last_error" text,
	"is_active" boolean DEFAULT true,
	"auto_fetch" boolean DEFAULT false,
	"fetch_interval_seconds" integer DEFAULT 5,
	"last_fetched_at" timestamp,
	"last_fetched_record_date" text,
	"total_fetched" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "api_keys" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"key" text NOT NULL,
	"name" text NOT NULL,
	"user_id" varchar,
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now(),
	"last_used_at" timestamp,
	CONSTRAINT "api_keys_key_unique" UNIQUE("key")
);
--> statement-breakpoint
CREATE TABLE "archived_accounts" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"original_user_id" varchar NOT NULL,
	"username" text,
	"first_name" text NOT NULL,
	"second_name" text NOT NULL,
	"email" text NOT NULL,
	"role" text,
	"created_by" varchar,
	"contact" text,
	"skype_id" text,
	"company_name" text,
	"address" text,
	"country" text,
	"is_active" boolean DEFAULT false,
	"original_created_at" timestamp,
	"archived_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "audit_logs" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"actor_user_id" varchar,
	"actor_username" text,
	"action" text NOT NULL,
	"entity_type" text NOT NULL,
	"entity_id" text,
	"status" text DEFAULT 'success',
	"ip_address" text,
	"user_agent" text,
	"details" text,
	"meta" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "clients" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"username" text NOT NULL,
	"name" text DEFAULT '',
	"email" text DEFAULT '',
	"password" text NOT NULL,
	"contact" text DEFAULT '',
	"skype" text DEFAULT '',
	"company" text DEFAULT '',
	"address" text DEFAULT '',
	"country" text DEFAULT '',
	"balance" text DEFAULT '0.00',
	"status" text DEFAULT 'active',
	"agent_id" varchar,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "clients_username_unique" UNIQUE("username")
);
--> statement-breakpoint
CREATE TABLE "countries" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"code" text NOT NULL,
	"price" text DEFAULT '0',
	"available_numbers" integer DEFAULT 0,
	CONSTRAINT "countries_code_unique" UNIQUE("code")
);
--> statement-breakpoint
CREATE TABLE "credit_requests" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"amount" text NOT NULL,
	"currency" text NOT NULL,
	"payment_method_id" varchar,
	"status" text DEFAULT 'pending',
	"telegram_chat_id" text,
	"created_at" timestamp DEFAULT now(),
	"processed_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "external_db_connections" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"db_type" text NOT NULL,
	"host" text NOT NULL,
	"port" integer NOT NULL,
	"database" text NOT NULL,
	"username" text NOT NULL,
	"password" text NOT NULL,
	"ssl_enabled" boolean DEFAULT false,
	"is_active" boolean DEFAULT false,
	"status" text DEFAULT 'disconnected',
	"last_tested_at" timestamp,
	"last_sync_at" timestamp,
	"sync_interval" integer DEFAULT 0,
	"sync_type" text DEFAULT 'manual',
	"table_mappings" text DEFAULT '{}',
	"created_by" varchar,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "external_db_sync_logs" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"connection_id" varchar,
	"sync_type" text NOT NULL,
	"status" text NOT NULL,
	"records_imported" integer DEFAULT 0,
	"records_failed" integer DEFAULT 0,
	"error_message" text,
	"details" text,
	"started_at" timestamp DEFAULT now(),
	"completed_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "failed_login_logs" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"username_attempted" text NOT NULL,
	"user_id" varchar,
	"ip_address" text,
	"user_agent" text,
	"failure_reason" text NOT NULL,
	"attempts_count" integer DEFAULT 1,
	"is_blocked" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "http_endpoints" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"slug" text NOT NULL,
	"method" text DEFAULT 'POST',
	"content_type" text DEFAULT 'application/json',
	"auth_type" text DEFAULT 'open',
	"auth_token" text DEFAULT '',
	"allowed_ips" text DEFAULT '',
	"description" text DEFAULT '',
	"is_active" boolean DEFAULT true,
	"total_requests" integer DEFAULT 0,
	"total_success" integer DEFAULT 0,
	"total_failed" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "http_endpoints_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "http_incoming_logs" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"endpoint_id" varchar,
	"endpoint_name" text DEFAULT '',
	"ip_address" text DEFAULT '',
	"method" text DEFAULT '',
	"headers" text DEFAULT '{}',
	"body" text DEFAULT '',
	"query_params" text DEFAULT '{}',
	"status" text DEFAULT 'SUCCESS',
	"status_code" integer DEFAULT 200,
	"error_message" text DEFAULT '',
	"response_body" text DEFAULT '',
	"user_agent" text DEFAULT '',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "http_incoming_messages" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"provider_id" varchar,
	"provider_name" text DEFAULT '',
	"sender_ip" text DEFAULT '',
	"cli" text DEFAULT '',
	"message_content" text DEFAULT '',
	"unique_id" text DEFAULT '',
	"is_duplicate" boolean DEFAULT false,
	"raw_body" text DEFAULT '',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "http_incoming_providers" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"slug" text NOT NULL,
	"ip_addresses" text DEFAULT '',
	"cli_field" text DEFAULT 'cli',
	"message_field" text DEFAULT 'message',
	"unique_id_field" text DEFAULT 'uuid',
	"is_active" boolean DEFAULT true,
	"total_received" integer DEFAULT 0,
	"last_ip" text DEFAULT '',
	"last_received_at" timestamp,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "http_incoming_providers_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "http_smpp_messages" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"http_log_id" varchar,
	"endpoint_id" varchar,
	"provider_id" varchar,
	"provider_name" text DEFAULT '',
	"source_addr" text DEFAULT '',
	"dest_addr" text DEFAULT '',
	"message_content" text DEFAULT '',
	"raw_body" text DEFAULT '',
	"smpp_status" text DEFAULT 'pending',
	"smpp_message_id" text DEFAULT '',
	"smpp_error" text DEFAULT '',
	"encoding" text DEFAULT 'GSM',
	"ip_address" text DEFAULT '',
	"sent_at" timestamp,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "inactivity_notifications" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"type" text NOT NULL,
	"title" text NOT NULL,
	"message" text NOT NULL,
	"inactive_days" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "login_history" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar,
	"username" text,
	"role" text,
	"ip_address" text,
	"user_agent" text,
	"device" text,
	"browser" text,
	"os" text,
	"status" text DEFAULT 'success',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "message_ownership" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"message_id" varchar NOT NULL,
	"owner_user_id" varchar,
	"owner_role" text DEFAULT 'AGENT',
	"agent_id" varchar,
	"client_id" varchar,
	"range_id" varchar,
	"range_name" text,
	"number_id" varchar,
	"payout" text DEFAULT '0.00',
	"client_payout" text DEFAULT '0.00',
	"currency" text DEFAULT 'USD',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "message_reactions" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"message_id" varchar NOT NULL,
	"user_id" varchar NOT NULL,
	"emoji" text NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "messages" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"time" timestamp DEFAULT now(),
	"country" text NOT NULL,
	"number" text NOT NULL,
	"cllr" text NOT NULL,
	"content" text,
	"user_id" varchar,
	"range" text,
	"payout" text DEFAULT '0.00',
	"client_payout" text DEFAULT '0.00',
	"currency" text DEFAULT '$',
	"client_name" text,
	"provider" text,
	"type" text DEFAULT 'General',
	"agent_name" text,
	"manager_name" text,
	"agent_payout" text DEFAULT '0.00',
	"cause" text DEFAULT 'Success',
	"ip" text
);
--> statement-breakpoint
CREATE TABLE "news" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" text NOT NULL,
	"content" text NOT NULL,
	"type" text NOT NULL,
	"url" text,
	"is_active" boolean DEFAULT true,
	"created_by" varchar,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "number_assignment_history" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"number" text NOT NULL,
	"range_id" varchar,
	"payout" text DEFAULT '0.00',
	"is_test" boolean DEFAULT false,
	"assigned_at" timestamp DEFAULT now(),
	"removed_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "number_requests" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar,
	"country_id" varchar,
	"quantity" integer NOT NULL,
	"site_url" text,
	"status" text DEFAULT 'pending',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "payment_methods" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"icon" text,
	"image_url" text,
	"account_placeholder" text DEFAULT 'Enter account details',
	"currency" text DEFAULT 'EGP',
	"sort_order" integer DEFAULT 0,
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "payment_withdrawals" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"agent_id" varchar NOT NULL,
	"agent_name" text,
	"amount_usd" text NOT NULL,
	"amount_egp" text,
	"currency" text DEFAULT 'USD',
	"exchange_rate" text,
	"method_id" text,
	"method_name" text,
	"account_details" text,
	"status" text DEFAULT 'pending',
	"proof_image_url" text,
	"admin_note" text,
	"reviewed_by" varchar,
	"reviewed_at" timestamp,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "phone_numbers" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"number" text NOT NULL,
	"country_id" varchar,
	"is_active" boolean DEFAULT true,
	"user_id" varchar,
	"client_id" varchar,
	"payout" text DEFAULT '0.00',
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "phone_numbers_number_unique" UNIQUE("number")
);
--> statement-breakpoint
CREATE TABLE "platform_info" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"platform_name" text DEFAULT 'MGS Panel',
	"platform_subtitle" text DEFAULT 'International SMS Platform',
	"contact_email" text DEFAULT '',
	"contact_email_visible" boolean DEFAULT false,
	"facebook_url" text DEFAULT '',
	"facebook_visible" boolean DEFAULT false,
	"whatsapp_number" text DEFAULT '',
	"whatsapp_visible" boolean DEFAULT false,
	"telegram_username" text DEFAULT '',
	"telegram_visible" boolean DEFAULT false,
	"sidebar_ticker_text" text DEFAULT '',
	"sidebar_ticker_enabled" boolean DEFAULT false,
	"ramadan_mode" boolean DEFAULT false,
	"login_background_type" text DEFAULT 'default',
	"login_background_image" text DEFAULT '',
	"login_gradient_color1" text DEFAULT '#0a1520',
	"login_gradient_color2" text DEFAULT '#1a2332',
	"custom_exchange_rate" text,
	"min_withdrawal_usd" text DEFAULT '0',
	"min_withdrawal_egp" text DEFAULT '0',
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "smpp_dlr_reports" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"message_id" text NOT NULL,
	"provider_id" varchar,
	"source_addr" text DEFAULT '',
	"dest_addr" text DEFAULT '',
	"dlr_status" text NOT NULL,
	"error_code" text DEFAULT '',
	"submit_date" text DEFAULT '',
	"done_date" text DEFAULT '',
	"details" text DEFAULT '',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "smpp_gateway_groups" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"description" text DEFAULT '',
	"max_throughput" integer DEFAULT 100,
	"default_provider_id" varchar,
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "smpp_gateway_users" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"username" text NOT NULL,
	"password" text NOT NULL,
	"group_id" varchar,
	"provider_id" varchar,
	"is_active" boolean DEFAULT true,
	"max_binds" integer DEFAULT 1,
	"throughput" integer DEFAULT 10,
	"allowed_ips" text DEFAULT '',
	"default_sender_id" text DEFAULT '',
	"default_encoding" text DEFAULT 'GSM',
	"total_sent" integer DEFAULT 0,
	"total_delivered" integer DEFAULT 0,
	"total_failed" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "smpp_http_api_keys" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"api_key" text NOT NULL,
	"api_secret" text NOT NULL,
	"gateway_user_id" varchar,
	"provider_id" varchar,
	"is_active" boolean DEFAULT true,
	"rate_limit" integer DEFAULT 10,
	"allowed_ips" text DEFAULT '',
	"total_requests" integer DEFAULT 0,
	"last_used_at" timestamp,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "smpp_logs" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"provider_id" varchar,
	"event_type" text NOT NULL,
	"direction" text DEFAULT 'outgoing',
	"source_addr" text DEFAULT '',
	"dest_addr" text DEFAULT '',
	"message_content" text DEFAULT '',
	"status" text DEFAULT '',
	"message_id" text DEFAULT '',
	"dlr_status" text DEFAULT '',
	"error_code" text DEFAULT '',
	"details" text DEFAULT '',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "sms_numbers" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"range_id" varchar,
	"number" text NOT NULL,
	"user_id" varchar,
	"client_id" varchar,
	"payout" text DEFAULT '0.00',
	"agent_payout" text DEFAULT '0.00',
	"client_payout" text DEFAULT '0.00',
	"is_test" boolean DEFAULT false,
	"number_msg_limit" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now(),
	"deleted_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "sms_providers" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"provider_name" text NOT NULL,
	"email" text DEFAULT '',
	"ip_addresses" text DEFAULT '',
	"esme_username" text DEFAULT '',
	"esme_password" text DEFAULT '',
	"number_field" text DEFAULT 'number',
	"cli_field" text DEFAULT 'cli',
	"message_field" text DEFAULT 'message',
	"unique_id_field" text DEFAULT 'uuid',
	"return_value" text DEFAULT 'OK-#uuid',
	"smpp_host" text DEFAULT '',
	"smpp_port" text DEFAULT '2775',
	"system_id" text DEFAULT '',
	"smsc_password" text DEFAULT '',
	"bind_mode" text DEFAULT '',
	"connection_allowed_ip" text DEFAULT '',
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now(),
	"bind_type" text DEFAULT 'transceiver',
	"system_type" text DEFAULT '',
	"interface_version" text DEFAULT '3.4',
	"rate_limit" integer DEFAULT 100,
	"sender_ids" text DEFAULT '',
	"message_type" text DEFAULT 'OTP',
	"encoding" text DEFAULT 'GSM',
	"dlr_enabled" boolean DEFAULT true,
	"priority" integer DEFAULT 1,
	"auto_reconnect" boolean DEFAULT true,
	"ip_whitelist" text DEFAULT '',
	"bind_status" text DEFAULT 'disconnected',
	"failover_order" integer DEFAULT 0,
	"last_bind_at" timestamp,
	"last_error_message" text DEFAULT '',
	"total_sent" integer DEFAULT 0,
	"total_delivered" integer DEFAULT 0,
	"total_failed" integer DEFAULT 0
);
--> statement-breakpoint
CREATE TABLE "sms_ranges" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"provider" text DEFAULT '',
	"prefix" text DEFAULT '',
	"active" boolean DEFAULT true,
	"currency" text DEFAULT 'USD',
	"payterm" text DEFAULT '7/1',
	"cli_list" text DEFAULT '',
	"country_id" varchar,
	"available_count" integer DEFAULT 0,
	"unavailable_count" integer DEFAULT 0,
	"payout" text DEFAULT '0.00',
	"agent_payout" text DEFAULT '0.00',
	"max_sms_limit_day" integer DEFAULT 0,
	"max_sms_limit_week" integer DEFAULT 0,
	"range_msg_limit" integer DEFAULT 0,
	"test_number" text DEFAULT '',
	"memo_text" text DEFAULT '',
	"payout_1_1" text DEFAULT '0',
	"payout_7_1" text DEFAULT '0',
	"payout_7_7" text DEFAULT '0',
	"payout_15_15" text DEFAULT '0',
	"payout_15_30" text DEFAULT '0',
	"payout_30_15" text DEFAULT '0',
	"payout_30_30" text DEFAULT '0',
	"payout_30_45" text DEFAULT '0',
	"payout_30_60" text DEFAULT '0',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "sms_test_numbers" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"country_id" varchar,
	"country_name" text NOT NULL,
	"numbers" text NOT NULL,
	"quantity" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "support_conversations" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"subject" text NOT NULL,
	"status" text DEFAULT 'open',
	"priority" text DEFAULT 'medium',
	"assigned_agent_id" varchar,
	"sla_deadline" timestamp,
	"sla_resolution_deadline" timestamp,
	"is_muted" boolean DEFAULT false,
	"muted_until" timestamp,
	"is_blocked" boolean DEFAULT false,
	"archived" boolean DEFAULT false,
	"unread_count" integer DEFAULT 0,
	"last_message_at" timestamp DEFAULT now(),
	"last_reply_at" timestamp,
	"updated_at" timestamp DEFAULT now(),
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "support_messages" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"conversation_id" varchar NOT NULL,
	"sender_id" varchar NOT NULL,
	"sender_role" text NOT NULL,
	"content" text NOT NULL,
	"message_type" text DEFAULT 'text',
	"media_url" text,
	"delivered_at" timestamp,
	"read_at" timestamp,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "telegram_bot_config" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"bot_token" text NOT NULL,
	"bot_username" text NOT NULL,
	"admin_telegram_id" text,
	"additional_admin_ids" text[],
	"min_amount" text DEFAULT '10',
	"max_amount" text DEFAULT '10000',
	"min_amount_usd" text DEFAULT '20',
	"max_amount_usd" text DEFAULT '1000',
	"min_amount_egp" text DEFAULT '1000',
	"max_amount_egp" text DEFAULT '10000',
	"notifications_enabled" boolean DEFAULT true,
	"welcome_message" text,
	"success_message" text,
	"schedule_enabled" boolean DEFAULT false,
	"schedule_days" text[],
	"schedule_start_time" text,
	"schedule_end_time" text,
	"schedule_timezone" text DEFAULT 'Africa/Cairo',
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "telegram_bot_users" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"chat_id" text NOT NULL,
	"first_name" text,
	"username" text,
	"is_admin" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "telegram_bot_users_chat_id_unique" UNIQUE("chat_id")
);
--> statement-breakpoint
CREATE TABLE "test_requests" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"country" text NOT NULL,
	"number" text NOT NULL,
	"cllr" text NOT NULL,
	"sms" text,
	"user_id" varchar,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "ticket_attachments" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ticket_id" varchar NOT NULL,
	"message_id" varchar,
	"file_name" text NOT NULL,
	"file_size" integer NOT NULL,
	"file_type" text NOT NULL,
	"url" text NOT NULL,
	"uploaded_by" varchar NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "time_settings" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"counter_type" text NOT NULL,
	"reset_hour" integer DEFAULT 0 NOT NULL,
	"reset_minute" integer DEFAULT 0 NOT NULL,
	"is_enabled" boolean DEFAULT false,
	"last_reset_at" timestamp,
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "time_settings_counter_type_unique" UNIQUE("counter_type")
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"first_name" text NOT NULL,
	"second_name" text NOT NULL,
	"email" text,
	"password" text NOT NULL,
	"activation_code" text,
	"is_active" boolean DEFAULT false,
	"role" text DEFAULT 'user',
	"created_by" varchar,
	"created_at" timestamp DEFAULT now(),
	"username" text,
	"contact" text,
	"skype_id" text,
	"company_name" text,
	"address" text,
	"country" text,
	"scrub_percent" integer DEFAULT 0,
	"usd_balance" text DEFAULT '0',
	"eur_balance" text DEFAULT '0',
	"gbp_balance" text DEFAULT '0',
	"egp_balance" text DEFAULT '0',
	"sms_delivery_via" text DEFAULT 'HTTP',
	"http_delivery_url" text,
	"email_active" boolean DEFAULT true,
	"verified" boolean DEFAULT false,
	"bind_status" text DEFAULT 'HTTP',
	"manager" varchar,
	"unique_code" text,
	"unique_code_generated_at" timestamp,
	"last_login" timestamp,
	"profile_picture" text,
	"phone" text,
	"expires_at" timestamp,
	"active_from" text,
	"active_to" text,
	CONSTRAINT "users_email_unique" UNIQUE("email"),
	CONSTRAINT "users_unique_code_unique" UNIQUE("unique_code")
);
--> statement-breakpoint
CREATE TABLE "withdraw_logs" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar,
	"username" text,
	"role" text,
	"client_id" varchar,
	"client_name" text,
	"range_id" varchar,
	"range_name" text,
	"action" text NOT NULL,
	"status" text DEFAULT 'success' NOT NULL,
	"failure_reason" text,
	"ip_address" text,
	"user_agent" text,
	"details" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "withdraw_requests" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"number_id" varchar,
	"number_text" text,
	"agent_id" varchar NOT NULL,
	"client_id" varchar,
	"client_name" text,
	"status" text DEFAULT 'pending',
	"reason" text,
	"reviewed_by" varchar,
	"reviewed_at" timestamp,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
ALTER TABLE "agent_number_requests" ADD CONSTRAINT "agent_number_requests_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "agent_number_requests" ADD CONSTRAINT "agent_number_requests_range_id_sms_ranges_id_fk" FOREIGN KEY ("range_id") REFERENCES "public"."sms_ranges"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "api_keys" ADD CONSTRAINT "api_keys_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_actor_user_id_users_id_fk" FOREIGN KEY ("actor_user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "clients" ADD CONSTRAINT "clients_agent_id_users_id_fk" FOREIGN KEY ("agent_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "credit_requests" ADD CONSTRAINT "credit_requests_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "credit_requests" ADD CONSTRAINT "credit_requests_payment_method_id_payment_methods_id_fk" FOREIGN KEY ("payment_method_id") REFERENCES "public"."payment_methods"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "external_db_connections" ADD CONSTRAINT "external_db_connections_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "external_db_sync_logs" ADD CONSTRAINT "external_db_sync_logs_connection_id_external_db_connections_id_fk" FOREIGN KEY ("connection_id") REFERENCES "public"."external_db_connections"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "http_incoming_logs" ADD CONSTRAINT "http_incoming_logs_endpoint_id_http_endpoints_id_fk" FOREIGN KEY ("endpoint_id") REFERENCES "public"."http_endpoints"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "http_incoming_messages" ADD CONSTRAINT "http_incoming_messages_provider_id_http_incoming_providers_id_fk" FOREIGN KEY ("provider_id") REFERENCES "public"."http_incoming_providers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "http_smpp_messages" ADD CONSTRAINT "http_smpp_messages_http_log_id_http_incoming_logs_id_fk" FOREIGN KEY ("http_log_id") REFERENCES "public"."http_incoming_logs"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "http_smpp_messages" ADD CONSTRAINT "http_smpp_messages_endpoint_id_http_endpoints_id_fk" FOREIGN KEY ("endpoint_id") REFERENCES "public"."http_endpoints"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "http_smpp_messages" ADD CONSTRAINT "http_smpp_messages_provider_id_sms_providers_id_fk" FOREIGN KEY ("provider_id") REFERENCES "public"."sms_providers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inactivity_notifications" ADD CONSTRAINT "inactivity_notifications_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "login_history" ADD CONSTRAINT "login_history_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "message_ownership" ADD CONSTRAINT "message_ownership_message_id_messages_id_fk" FOREIGN KEY ("message_id") REFERENCES "public"."messages"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "message_ownership" ADD CONSTRAINT "message_ownership_owner_user_id_users_id_fk" FOREIGN KEY ("owner_user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "message_reactions" ADD CONSTRAINT "message_reactions_message_id_support_messages_id_fk" FOREIGN KEY ("message_id") REFERENCES "public"."support_messages"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "message_reactions" ADD CONSTRAINT "message_reactions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "messages" ADD CONSTRAINT "messages_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "news" ADD CONSTRAINT "news_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "number_requests" ADD CONSTRAINT "number_requests_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "number_requests" ADD CONSTRAINT "number_requests_country_id_countries_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "phone_numbers" ADD CONSTRAINT "phone_numbers_country_id_countries_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "phone_numbers" ADD CONSTRAINT "phone_numbers_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "smpp_dlr_reports" ADD CONSTRAINT "smpp_dlr_reports_provider_id_sms_providers_id_fk" FOREIGN KEY ("provider_id") REFERENCES "public"."sms_providers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "smpp_gateway_groups" ADD CONSTRAINT "smpp_gateway_groups_default_provider_id_sms_providers_id_fk" FOREIGN KEY ("default_provider_id") REFERENCES "public"."sms_providers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "smpp_gateway_users" ADD CONSTRAINT "smpp_gateway_users_provider_id_sms_providers_id_fk" FOREIGN KEY ("provider_id") REFERENCES "public"."sms_providers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "smpp_http_api_keys" ADD CONSTRAINT "smpp_http_api_keys_gateway_user_id_smpp_gateway_users_id_fk" FOREIGN KEY ("gateway_user_id") REFERENCES "public"."smpp_gateway_users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "smpp_http_api_keys" ADD CONSTRAINT "smpp_http_api_keys_provider_id_sms_providers_id_fk" FOREIGN KEY ("provider_id") REFERENCES "public"."sms_providers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "smpp_logs" ADD CONSTRAINT "smpp_logs_provider_id_sms_providers_id_fk" FOREIGN KEY ("provider_id") REFERENCES "public"."sms_providers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sms_numbers" ADD CONSTRAINT "sms_numbers_range_id_sms_ranges_id_fk" FOREIGN KEY ("range_id") REFERENCES "public"."sms_ranges"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sms_numbers" ADD CONSTRAINT "sms_numbers_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sms_ranges" ADD CONSTRAINT "sms_ranges_country_id_countries_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sms_test_numbers" ADD CONSTRAINT "sms_test_numbers_country_id_countries_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "support_conversations" ADD CONSTRAINT "support_conversations_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "support_conversations" ADD CONSTRAINT "support_conversations_assigned_agent_id_users_id_fk" FOREIGN KEY ("assigned_agent_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "support_messages" ADD CONSTRAINT "support_messages_conversation_id_support_conversations_id_fk" FOREIGN KEY ("conversation_id") REFERENCES "public"."support_conversations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "support_messages" ADD CONSTRAINT "support_messages_sender_id_users_id_fk" FOREIGN KEY ("sender_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "test_requests" ADD CONSTRAINT "test_requests_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ticket_attachments" ADD CONSTRAINT "ticket_attachments_ticket_id_support_conversations_id_fk" FOREIGN KEY ("ticket_id") REFERENCES "public"."support_conversations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ticket_attachments" ADD CONSTRAINT "ticket_attachments_message_id_support_messages_id_fk" FOREIGN KEY ("message_id") REFERENCES "public"."support_messages"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ticket_attachments" ADD CONSTRAINT "ticket_attachments_uploaded_by_users_id_fk" FOREIGN KEY ("uploaded_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "withdraw_requests" ADD CONSTRAINT "withdraw_requests_number_id_sms_numbers_id_fk" FOREIGN KEY ("number_id") REFERENCES "public"."sms_numbers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "withdraw_requests" ADD CONSTRAINT "withdraw_requests_agent_id_users_id_fk" FOREIGN KEY ("agent_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "withdraw_requests" ADD CONSTRAINT "withdraw_requests_reviewed_by_users_id_fk" FOREIGN KEY ("reviewed_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;