-- ═══════════════════════════════════════════════════════════
-- MGS Panel - Supabase Migration
-- PART 3 of 3: PRIMARY KEYS, CONSTRAINTS & FOREIGN KEYS
-- Run this LAST after Part 1 and Part 2 complete
-- ═══════════════════════════════════════════════════════════
SET client_encoding = 'UTF8';
SET row_security = off;

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


