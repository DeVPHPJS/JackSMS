import { sql } from "drizzle-orm";
import { pgTable, text, varchar, timestamp, integer, boolean } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod";

export const users = pgTable("users", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  firstName: text("first_name").notNull(),
  secondName: text("second_name").notNull(),
  email: text("email").unique(),
  password: text("password").notNull(),
  activationCode: text("activation_code"),
  isActive: boolean("is_active").default(false),
  role: text("role").default("user"),
  createdBy: varchar("created_by"),
  createdAt: timestamp("created_at").defaultNow(),
  username: text("username"),
  contact: text("contact"),
  skypeId: text("skype_id"),
  companyName: text("company_name"),
  address: text("address"),
  country: text("country"),
  scrubPercent: integer("scrub_percent").default(0),
  usdBalance: text("usd_balance").default("0"),
  eurBalance: text("eur_balance").default("0"),
  gbpBalance: text("gbp_balance").default("0"),
  egpBalance: text("egp_balance").default("0"),
  smsDeliveryVia: text("sms_delivery_via").default("HTTP"),
  httpDeliveryUrl: text("http_delivery_url"),
  emailActive: boolean("email_active").default(true),
  verified: boolean("verified").default(false),
  bindStatus: text("bind_status").default("HTTP"),
  manager: varchar("manager"),
  uniqueCode: text("unique_code").unique(),
  uniqueCodeGeneratedAt: timestamp("unique_code_generated_at"),
  lastLogin: timestamp("last_login"),
  profilePicture: text("profile_picture"),
  phone: text("phone"),
  expiresAt: timestamp("expires_at"),
  activeFrom: text("active_from"),
  activeTo: text("active_to"),
  webhookUrl: text("webhook_url"),
});

export const countries = pgTable("countries", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  code: text("code").notNull().unique(),
  price: text("price").default("0"),
  availableNumbers: integer("available_numbers").default(0),
});

export const activationCodes = pgTable("activation_codes", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  code: text("code").notNull().unique(),
  name: text("name").notNull(),
  country: text("country").notNull(),
  whatsappNumber: text("whatsapp_number").notNull(),
  email: text("email").notNull(),
  isUsed: boolean("is_used").default(false),
  createdAt: timestamp("created_at").defaultNow(),
});

export const phoneNumbers = pgTable("phone_numbers", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  number: text("number").notNull().unique(),
  countryId: varchar("country_id").references(() => countries.id),
  isActive: boolean("is_active").default(true),
  userId: varchar("user_id").references(() => users.id),
  clientId: varchar("client_id"),
  payout: text("payout").default("0.00"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const messages = pgTable("messages", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  time: timestamp("time").defaultNow(),
  country: text("country").notNull(),
  number: text("number").notNull(),
  cllr: text("cllr").notNull(),
  content: text("content"),
  userId: varchar("user_id").references(() => users.id),
  range: text("range"),
  payout: text("payout").default("0.00"),
  clientPayout: text("client_payout").default("0.00"),
  currency: text("currency").default("$"),
  clientName: text("client_name"),
  provider: text("provider"),
  type: text("type").default("General"),
  agentName: text("agent_name"),
  managerName: text("manager_name"),
  agentPayout: text("agent_payout").default("0.00"),
  cause: text("cause").default("Success"),
  ip: text("ip"),
});

export const numberRequests = pgTable("number_requests", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").references(() => users.id),
  countryId: varchar("country_id").references(() => countries.id),
  quantity: integer("quantity").notNull(),
  siteUrl: text("site_url"),
  status: text("status").default("pending"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const testRequests = pgTable("test_requests", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  country: text("country").notNull(),
  number: text("number").notNull(),
  cllr: text("cllr").notNull(),
  sms: text("sms"),
  userId: varchar("user_id").references(() => users.id),
  createdAt: timestamp("created_at").defaultNow(),
});

export const apiKeys = pgTable("api_keys", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  key: text("key").notNull().unique(),
  name: text("name").notNull(),
  userId: varchar("user_id").references(() => users.id),
  isActive: boolean("is_active").default(true),
  createdAt: timestamp("created_at").defaultNow(),
  lastUsedAt: timestamp("last_used_at"),
});

// ✅ جدول smsRanges المعدل مع إضافة حقل agentPayout
export const smsRanges = pgTable("sms_ranges", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  provider: text("provider").default(""),
  prefix: text("prefix").default(""),
  active: boolean("active").default(true),
  currency: text("currency").default("USD"),
  payterm: text("payterm").default("7/1"),
  cliList: text("cli_list").default(""),
  countryId: varchar("country_id").references(() => countries.id),
  availableCount: integer("available_count").default(0),
  unavailableCount: integer("unavailable_count").default(0),
  payout: text("payout").default("0.00"),           // Admin Payout
  agentPayout: text("agent_payout").default("0.00"), // ✅ Agent Payout - حقل جديد
  maxSmsLimitDay: integer("max_sms_limit_day").default(0),
  maxSmsLimitWeek: integer("max_sms_limit_week").default(0),
  rangeMsgLimit: integer("range_msg_limit").default(0),
  testNumber: text("test_number").default(""),
  memoText: text("memo_text").default(""),
  payout_1_1: text("payout_1_1").default("0"),
  payout_7_1: text("payout_7_1").default("0"),
  payout_7_7: text("payout_7_7").default("0"),
  payout_15_15: text("payout_15_15").default("0"),
  payout_15_30: text("payout_15_30").default("0"),
  payout_30_15: text("payout_30_15").default("0"),
  payout_30_30: text("payout_30_30").default("0"),
  payout_30_45: text("payout_30_45").default("0"),
  payout_30_60: text("payout_30_60").default("0"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const agentNumberRequests = pgTable("agent_number_requests", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").references(() => users.id),
  rangeId: varchar("range_id").references(() => smsRanges.id),
  quantity: integer("quantity").notNull(),
  status: text("status").default("pending"),
  approvedBy: varchar("approved_by"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const clients = pgTable("clients", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  username: text("username").notNull().unique(),
  name: text("name").default(""),
  email: text("email").default(""),
  password: text("password").notNull(),
  contact: text("contact").default(""),
  skype: text("skype").default(""),
  company: text("company").default(""),
  address: text("address").default(""),
  country: text("country").default(""),
  balance: text("balance").default("0.00"),
  status: text("status").default("active"),
  agentId: varchar("agent_id").references(() => users.id),
  createdAt: timestamp("created_at").defaultNow(),
  profilePicture: text("profile_picture"),
});

export const apiConnections = pgTable("api_connections", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  apiToken: text("api_token").notNull(),
  apiUrl: text("api_url").notNull(),
  status: text("status").default("offline"),
  lastCheckedAt: timestamp("last_checked_at"),
  lastError: text("last_error"),
  isActive: boolean("is_active").default(true),
  autoFetch: boolean("auto_fetch").default(false),
  fetchIntervalSeconds: integer("fetch_interval_seconds").default(5),
  lastFetchedAt: timestamp("last_fetched_at"),
  lastFetchedRecordDate: text("last_fetched_record_date"),
  totalFetched: integer("total_fetched").default(0),
  createdAt: timestamp("created_at").defaultNow(),
});

export const supportConversations = pgTable("support_conversations", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").references(() => users.id).notNull(),
  subject: text("subject").notNull(),
  status: text("status").default("open"),
  priority: text("priority").default("medium"),
  assignedAgentId: varchar("assigned_agent_id").references(() => users.id),
  slaDeadline: timestamp("sla_deadline"),
  slaResolutionDeadline: timestamp("sla_resolution_deadline"),
  isMuted: boolean("is_muted").default(false),
  mutedUntil: timestamp("muted_until"),
  isBlocked: boolean("is_blocked").default(false),
  archived: boolean("archived").default(false),
  unreadCount: integer("unread_count").default(0),
  lastMessageAt: timestamp("last_message_at").defaultNow(),
  lastReplyAt: timestamp("last_reply_at"),
  updatedAt: timestamp("updated_at").defaultNow(),
  createdAt: timestamp("created_at").defaultNow(),
});

export const supportMessages = pgTable("support_messages", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  conversationId: varchar("conversation_id").references(() => supportConversations.id).notNull(),
  senderId: varchar("sender_id").references(() => users.id).notNull(),
  senderRole: text("sender_role").notNull(),
  content: text("content").notNull(),
  messageType: text("message_type").default("text"),
  mediaUrl: text("media_url"),
  deliveredAt: timestamp("delivered_at"),
  readAt: timestamp("read_at"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const messageReactions = pgTable("message_reactions", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  messageId: varchar("message_id").references(() => supportMessages.id).notNull(),
  userId: varchar("user_id").references(() => users.id).notNull(),
  emoji: text("emoji").notNull(),
  createdAt: timestamp("created_at").defaultNow(),
});

export const ticketAttachments = pgTable("ticket_attachments", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  ticketId: varchar("ticket_id").references(() => supportConversations.id).notNull(),
  messageId: varchar("message_id").references(() => supportMessages.id),
  fileName: text("file_name").notNull(),
  fileSize: integer("file_size").notNull(),
  fileType: text("file_type").notNull(),
  url: text("url").notNull(),
  uploadedBy: varchar("uploaded_by").references(() => users.id).notNull(),
  createdAt: timestamp("created_at").defaultNow(),
});

export const news = pgTable("news", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  title: text("title").notNull(),
  content: text("content").notNull(),
  type: text("type").notNull(),
  url: text("url"),
  isActive: boolean("is_active").default(true),
  createdBy: varchar("created_by").references(() => users.id),
  createdAt: timestamp("created_at").defaultNow(),
});

export const announcements = pgTable("announcements", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  title: text("title").notNull(),
  body: text("body").default(""),
  imageUrl: text("image_url"),
  isActive: boolean("is_active").default(true),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertAnnouncementSchema = createInsertSchema(announcements).omit({ id: true, createdAt: true });
export type InsertAnnouncement = z.infer<typeof insertAnnouncementSchema>;
export type Announcement = typeof announcements.$inferSelect;

export const telegramBotConfig = pgTable("telegram_bot_config", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  botToken: text("bot_token").notNull(),
  botUsername: text("bot_username").notNull(),
  adminTelegramId: text("admin_telegram_id"),
  additionalAdminIds: text("additional_admin_ids").array(),
  minAmount: text("min_amount").default("10"),
  maxAmount: text("max_amount").default("10000"),
  minAmountUsd: text("min_amount_usd").default("20"),
  maxAmountUsd: text("max_amount_usd").default("1000"),
  minAmountEgp: text("min_amount_egp").default("1000"),
  maxAmountEgp: text("max_amount_egp").default("10000"),
  notificationsEnabled: boolean("notifications_enabled").default(true),
  welcomeMessage: text("welcome_message"),
  successMessage: text("success_message"),
  scheduleEnabled: boolean("schedule_enabled").default(false),
  scheduleDays: text("schedule_days").array(),
  scheduleStartTime: text("schedule_start_time"),
  scheduleEndTime: text("schedule_end_time"),
  scheduleTimezone: text("schedule_timezone").default("Africa/Cairo"),
  isActive: boolean("is_active").default(true),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});

export const telegramBotUsers = pgTable("telegram_bot_users", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  chatId: text("chat_id").notNull().unique(),
  firstName: text("first_name"),
  username: text("username"),
  isAdmin: boolean("is_admin").default(false),
  createdAt: timestamp("created_at").defaultNow(),
});

export const paymentMethods = pgTable("payment_methods", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  description: text("description"),
  icon: text("icon"),
  imageUrl: text("image_url"),
  accountPlaceholder: text("account_placeholder").default("Enter account details"),
  currency: text("currency").default("EGP"),
  sortOrder: integer("sort_order").default(0),
  isActive: boolean("is_active").default(true),
  createdAt: timestamp("created_at").defaultNow(),
});

export const creditRequests = pgTable("credit_requests", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").references(() => users.id).notNull(),
  amount: text("amount").notNull(),
  currency: text("currency").notNull(),
  paymentMethodId: varchar("payment_method_id").references(() => paymentMethods.id),
  status: text("status").default("pending"),
  telegramChatId: text("telegram_chat_id"),
  createdAt: timestamp("created_at").defaultNow(),
  processedAt: timestamp("processed_at"),
});

// ✅ جدول smsNumbers المعدل مع agentPayout و clientPayout
export const smsNumbers = pgTable("sms_numbers", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  rangeId: varchar("range_id").references(() => smsRanges.id),
  number: text("number").notNull(),
  userId: varchar("user_id").references(() => users.id),
  clientId: varchar("client_id"),
  payout: text("payout").default("0.00"),                // Admin Payout
  agentPayout: text("agent_payout").default("0.00"),     // Agent Payout
  clientPayout: text("client_payout").default("0.00"),   // Client Payout
  isTest: boolean("is_test").default(false),
  numberMsgLimit: integer("number_msg_limit").default(0),
  createdAt: timestamp("created_at").defaultNow(),
  deletedAt: timestamp("deleted_at"),
});

export const smsTestNumbers = pgTable("sms_test_numbers", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  countryId: varchar("country_id").references(() => countries.id),
  countryName: text("country_name").notNull(),
  numbers: text("numbers").notNull(),
  quantity: integer("quantity").default(0),
  createdAt: timestamp("created_at").defaultNow(),
});

// Insert schemas
export const insertUserSchema = createInsertSchema(users).omit({ id: true, createdAt: true, isActive: true, role: true, createdBy: true });
export const createUserByAdminSchema = createInsertSchema(users).omit({ id: true, createdAt: true });
export const insertCountrySchema = createInsertSchema(countries).omit({ id: true, availableNumbers: true });
export const insertPhoneNumberSchema = createInsertSchema(phoneNumbers).omit({ id: true, createdAt: true });
export const insertMessageSchema = createInsertSchema(messages).omit({ id: true });
export const insertNumberRequestSchema = createInsertSchema(numberRequests).omit({ id: true, createdAt: true, status: true });
export const insertTestRequestSchema = createInsertSchema(testRequests).omit({ id: true, createdAt: true });
export const insertActivationCodeSchema = createInsertSchema(activationCodes).omit({ id: true, createdAt: true, isUsed: true, code: true });
export const insertApiKeySchema = createInsertSchema(apiKeys).omit({ id: true, createdAt: true, lastUsedAt: true, isActive: true, key: true });
export const insertSmsRangeSchema = createInsertSchema(smsRanges).omit({ id: true, createdAt: true });
export const insertAgentNumberRequestSchema = createInsertSchema(agentNumberRequests).omit({ id: true, createdAt: true, status: true });
export const insertClientSchema = createInsertSchema(clients).omit({ id: true, createdAt: true }).extend({
  status: z.enum(["active", "disabled"]).default("active"),
});
export const insertApiConnectionSchema = createInsertSchema(apiConnections).omit({ id: true, createdAt: true, lastCheckedAt: true, status: true, lastError: true });
export const insertSupportConversationSchema = createInsertSchema(supportConversations).omit({ id: true, createdAt: true, lastMessageAt: true, status: true, slaDeadline: true, slaResolutionDeadline: true, updatedAt: true, lastReplyAt: true, unreadCount: true, archived: true });
export const insertSupportMessageSchema = createInsertSchema(supportMessages).omit({ id: true, createdAt: true, deliveredAt: true, readAt: true });
export const insertMessageReactionSchema = createInsertSchema(messageReactions).omit({ id: true, createdAt: true });
export const insertTicketAttachmentSchema = createInsertSchema(ticketAttachments).omit({ id: true, createdAt: true });
export const insertNewsSchema = createInsertSchema(news).omit({ id: true, createdAt: true, isActive: true });
export const insertTelegramBotUserSchema = createInsertSchema(telegramBotUsers).omit({ id: true, createdAt: true });
export const insertTelegramBotConfigSchema = createInsertSchema(telegramBotConfig).omit({ id: true, createdAt: true, updatedAt: true, isActive: true });
export const insertPaymentMethodSchema = createInsertSchema(paymentMethods).omit({ id: true, createdAt: true });
export const insertCreditRequestSchema = createInsertSchema(creditRequests).omit({ id: true, createdAt: true, processedAt: true, status: true });
export const insertSmsNumberSchema = createInsertSchema(smsNumbers).omit({ id: true, createdAt: true });
export const insertSmsTestNumberSchema = createInsertSchema(smsTestNumbers).omit({ id: true, createdAt: true });

export const smsProviders = pgTable("sms_providers", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  providerName: text("provider_name").notNull(),
  email: text("email").default(""),
  ipAddresses: text("ip_addresses").default(""),
  esmeUsername: text("esme_username").default(""),
  esmePassword: text("esme_password").default(""),
  numberField: text("number_field").default("number"),
  cliField: text("cli_field").default("cli"),
  messageField: text("message_field").default("message"),
  uniqueIdField: text("unique_id_field").default("uuid"),
  returnValue: text("return_value").default("OK-#uuid"),
  smppHost: text("smpp_host").default(""),
  smppPort: text("smpp_port").default("2775"),
  systemId: text("system_id").default(""),
  smscPassword: text("smsc_password").default(""),
  bindMode: text("bind_mode").default(""),
  connectionAllowedIp: text("connection_allowed_ip").default(""),
  isActive: boolean("is_active").default(true),
  createdAt: timestamp("created_at").defaultNow(),
  bindType: text("bind_type").default("transceiver"),
  systemType: text("system_type").default(""),
  interfaceVersion: text("interface_version").default("3.4"),
  rateLimit: integer("rate_limit").default(100),
  senderIds: text("sender_ids").default(""),
  messageType: text("message_type").default("OTP"),
  encoding: text("encoding").default("GSM"),
  dlrEnabled: boolean("dlr_enabled").default(true),
  priority: integer("priority").default(1),
  autoReconnect: boolean("auto_reconnect").default(true),
  ipWhitelist: text("ip_whitelist").default(""),
  bindStatus: text("bind_status").default("disconnected"),
  failoverOrder: integer("failover_order").default(0),
  lastBindAt: timestamp("last_bind_at"),
  lastErrorMessage: text("last_error_message").default(""),
  totalSent: integer("total_sent").default(0),
  totalDelivered: integer("total_delivered").default(0),
  totalFailed: integer("total_failed").default(0),
});

export const smppLogs = pgTable("smpp_logs", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  providerId: varchar("provider_id").references(() => smsProviders.id),
  eventType: text("event_type").notNull(),
  direction: text("direction").default("outgoing"),
  sourceAddr: text("source_addr").default(""),
  destAddr: text("dest_addr").default(""),
  messageContent: text("message_content").default(""),
  status: text("status").default(""),
  messageId: text("message_id").default(""),
  dlrStatus: text("dlr_status").default(""),
  errorCode: text("error_code").default(""),
  details: text("details").default(""),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertSmsProviderSchema = createInsertSchema(smsProviders).omit({ id: true, createdAt: true, isActive: true, bindStatus: true, lastBindAt: true, lastErrorMessage: true, totalSent: true, totalDelivered: true, totalFailed: true });
export type InsertSmsProvider = z.infer<typeof insertSmsProviderSchema>;
export type SmsProvider = typeof smsProviders.$inferSelect;

export const insertSmppLogSchema = createInsertSchema(smppLogs).omit({ id: true, createdAt: true });
export type InsertSmppLog = z.infer<typeof insertSmppLogSchema>;
export type SmppLog = typeof smppLogs.$inferSelect;

export const smppGatewayUsers = pgTable("smpp_gateway_users", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  username: text("username").notNull(),
  password: text("password").notNull(),
  groupId: varchar("group_id"),
  providerId: varchar("provider_id").references(() => smsProviders.id),
  isActive: boolean("is_active").default(true),
  maxBinds: integer("max_binds").default(1),
  throughput: integer("throughput").default(10),
  allowedIps: text("allowed_ips").default(""),
  defaultSenderId: text("default_sender_id").default(""),
  defaultEncoding: text("default_encoding").default("GSM"),
  totalSent: integer("total_sent").default(0),
  totalDelivered: integer("total_delivered").default(0),
  totalFailed: integer("total_failed").default(0),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertSmppGatewayUserSchema = createInsertSchema(smppGatewayUsers).omit({ id: true, createdAt: true, isActive: true, totalSent: true, totalDelivered: true, totalFailed: true });
export type InsertSmppGatewayUser = z.infer<typeof insertSmppGatewayUserSchema>;
export type SmppGatewayUser = typeof smppGatewayUsers.$inferSelect;

export const smppGatewayGroups = pgTable("smpp_gateway_groups", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  description: text("description").default(""),
  maxThroughput: integer("max_throughput").default(100),
  defaultProviderId: varchar("default_provider_id").references(() => smsProviders.id),
  isActive: boolean("is_active").default(true),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertSmppGatewayGroupSchema = createInsertSchema(smppGatewayGroups).omit({ id: true, createdAt: true, isActive: true });
export type InsertSmppGatewayGroup = z.infer<typeof insertSmppGatewayGroupSchema>;
export type SmppGatewayGroup = typeof smppGatewayGroups.$inferSelect;

export const smppHttpApiKeys = pgTable("smpp_http_api_keys", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  apiKey: text("api_key").notNull(),
  apiSecret: text("api_secret").notNull(),
  gatewayUserId: varchar("gateway_user_id").references(() => smppGatewayUsers.id),
  providerId: varchar("provider_id").references(() => smsProviders.id),
  isActive: boolean("is_active").default(true),
  rateLimit: integer("rate_limit").default(10),
  allowedIps: text("allowed_ips").default(""),
  totalRequests: integer("total_requests").default(0),
  lastUsedAt: timestamp("last_used_at"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertSmppHttpApiKeySchema = createInsertSchema(smppHttpApiKeys).omit({ id: true, createdAt: true, isActive: true, totalRequests: true, lastUsedAt: true });
export type InsertSmppHttpApiKey = z.infer<typeof insertSmppHttpApiKeySchema>;
export type SmppHttpApiKey = typeof smppHttpApiKeys.$inferSelect;

export const smppDlrReports = pgTable("smpp_dlr_reports", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  messageId: text("message_id").notNull(),
  providerId: varchar("provider_id").references(() => smsProviders.id),
  sourceAddr: text("source_addr").default(""),
  destAddr: text("dest_addr").default(""),
  dlrStatus: text("dlr_status").notNull(),
  errorCode: text("error_code").default(""),
  submitDate: text("submit_date").default(""),
  doneDate: text("done_date").default(""),
  details: text("details").default(""),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertSmppDlrReportSchema = createInsertSchema(smppDlrReports).omit({ id: true, createdAt: true });
export type InsertSmppDlrReport = z.infer<typeof insertSmppDlrReportSchema>;
export type SmppDlrReport = typeof smppDlrReports.$inferSelect;

export const platformInfo = pgTable("platform_info", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  platformName: text("platform_name").default("Express SMS"),
  platformSubtitle: text("platform_subtitle").default("International SMS Platform"),
  contactEmail: text("contact_email").default(""),
  contactEmailVisible: boolean("contact_email_visible").default(false),
  facebookUrl: text("facebook_url").default(""),
  facebookVisible: boolean("facebook_visible").default(false),
  whatsappNumber: text("whatsapp_number").default(""),
  whatsappVisible: boolean("whatsapp_visible").default(false),
  telegramUsername: text("telegram_username").default(""),
  telegramVisible: boolean("telegram_visible").default(false),
  sidebarTickerText: text("sidebar_ticker_text").default(""),
  sidebarTickerEnabled: boolean("sidebar_ticker_enabled").default(false),
  ramadanMode: boolean("ramadan_mode").default(false),
  loginBackgroundType: text("login_background_type").default("default"),
  loginBackgroundImage: text("login_background_image").default(""),
  loginGradientColor1: text("login_gradient_color1").default("#0a1520"),
  loginGradientColor2: text("login_gradient_color2").default("#1a2332"),
  customExchangeRate: text("custom_exchange_rate"),
  minWithdrawalUsd: text("min_withdrawal_usd").default("0"),
  minWithdrawalEgp: text("min_withdrawal_egp").default("0"),
  withdrawalWindowEnabled: boolean("withdrawal_window_enabled").default(false),
  withdrawalWindowDays: text("withdrawal_window_days").default(""),
  withdrawalWindowStartHour: integer("withdrawal_window_start_hour").default(9),
  withdrawalWindowStartMinute: integer("withdrawal_window_start_minute").default(0),
  withdrawalWindowEndHour: integer("withdrawal_window_end_hour").default(17),
  withdrawalWindowEndMinute: integer("withdrawal_window_end_minute").default(0),
  updatedAt: timestamp("updated_at").defaultNow(),
});

export const insertPlatformInfoSchema = createInsertSchema(platformInfo).omit({ id: true, updatedAt: true });
export type InsertPlatformInfo = z.infer<typeof insertPlatformInfoSchema>;
export type PlatformInfo = typeof platformInfo.$inferSelect;

// Login schema
export const loginSchema = z.object({
  username: z.string().min(1),
  password: z.string().min(6),
});

// Registration schema with activation code
export const registerWithCodeSchema = z.object({
  firstName: z.string().min(2),
  secondName: z.string().min(2),
  email: z.string().email(),
  password: z.string().min(6),
  activationCode: z.string().min(1),
});

// Types
export type InsertUser = z.infer<typeof insertUserSchema>;
export type CreateUserByAdmin = z.infer<typeof createUserByAdminSchema>;
export type User = typeof users.$inferSelect;
export type InsertCountry = z.infer<typeof insertCountrySchema>;
export type Country = typeof countries.$inferSelect;
export type InsertPhoneNumber = z.infer<typeof insertPhoneNumberSchema>;
export type PhoneNumber = typeof phoneNumbers.$inferSelect;
export type InsertMessage = z.infer<typeof insertMessageSchema>;
export type Message = typeof messages.$inferSelect;
export type InsertNumberRequest = z.infer<typeof insertNumberRequestSchema>;
export type NumberRequest = typeof numberRequests.$inferSelect;
export type InsertTestRequest = z.infer<typeof insertTestRequestSchema>;
export type TestRequest = typeof testRequests.$inferSelect;
export type InsertActivationCode = z.infer<typeof insertActivationCodeSchema>;
export type ActivationCode = typeof activationCodes.$inferSelect;
export type InsertApiKey = z.infer<typeof insertApiKeySchema>;
export type ApiKey = typeof apiKeys.$inferSelect;
export type InsertSmsRange = z.infer<typeof insertSmsRangeSchema>;
export type SmsRange = typeof smsRanges.$inferSelect;
export type InsertAgentNumberRequest = z.infer<typeof insertAgentNumberRequestSchema>;
export type AgentNumberRequest = typeof agentNumberRequests.$inferSelect;
export type InsertClient = z.infer<typeof insertClientSchema>;
export type Client = typeof clients.$inferSelect;
export type InsertApiConnection = z.infer<typeof insertApiConnectionSchema>;
export type ApiConnection = typeof apiConnections.$inferSelect;
export type InsertSupportConversation = z.infer<typeof insertSupportConversationSchema>;
export type SupportConversation = typeof supportConversations.$inferSelect;
export type InsertSupportMessage = z.infer<typeof insertSupportMessageSchema>;
export type SupportMessage = typeof supportMessages.$inferSelect;
export type InsertMessageReaction = z.infer<typeof insertMessageReactionSchema>;
export type MessageReaction = typeof messageReactions.$inferSelect;
export type InsertTicketAttachment = z.infer<typeof insertTicketAttachmentSchema>;
export type TicketAttachment = typeof ticketAttachments.$inferSelect;
export type InsertNews = z.infer<typeof insertNewsSchema>;
export type News = typeof news.$inferSelect;
export type InsertTelegramBotUser = z.infer<typeof insertTelegramBotUserSchema>;
export type TelegramBotUser = typeof telegramBotUsers.$inferSelect;
export type InsertTelegramBotConfig = z.infer<typeof insertTelegramBotConfigSchema>;
export type TelegramBotConfig = typeof telegramBotConfig.$inferSelect;
export type InsertPaymentMethod = z.infer<typeof insertPaymentMethodSchema>;
export type PaymentMethod = typeof paymentMethods.$inferSelect;
export type InsertCreditRequest = z.infer<typeof insertCreditRequestSchema>;
export type CreditRequest = typeof creditRequests.$inferSelect;
export type InsertSmsNumber = z.infer<typeof insertSmsNumberSchema>;
export type SmsNumber = typeof smsNumbers.$inferSelect;
export type InsertSmsTestNumber = z.infer<typeof insertSmsTestNumberSchema>;
export type SmsTestNumber = typeof smsTestNumbers.$inferSelect;
export type Login = z.infer<typeof loginSchema>;
export type RegisterWithCode = z.infer<typeof registerWithCodeSchema>;

export const loginHistory = pgTable("login_history", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").references(() => users.id),
  username: text("username"),
  role: text("role"),
  ipAddress: text("ip_address"),
  userAgent: text("user_agent"),
  device: text("device"),
  browser: text("browser"),
  os: text("os"),
  status: text("status").default("success"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertLoginHistorySchema = createInsertSchema(loginHistory).omit({ id: true, createdAt: true });
export type InsertLoginHistory = z.infer<typeof insertLoginHistorySchema>;
export type LoginHistory = typeof loginHistory.$inferSelect;

export const httpEndpoints = pgTable("http_endpoints", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  slug: text("slug").notNull().unique(),
  method: text("method").default("POST"),
  contentType: text("content_type").default("application/json"),
  authType: text("auth_type").default("open"),
  authToken: text("auth_token").default(""),
  allowedIps: text("allowed_ips").default(""),
  description: text("description").default(""),
  isActive: boolean("is_active").default(true),
  totalRequests: integer("total_requests").default(0),
  totalSuccess: integer("total_success").default(0),
  totalFailed: integer("total_failed").default(0),
  createdAt: timestamp("created_at").defaultNow(),
});

export const httpIncomingLogs = pgTable("http_incoming_logs", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  endpointId: varchar("endpoint_id").references(() => httpEndpoints.id),
  endpointName: text("endpoint_name").default(""),
  ipAddress: text("ip_address").default(""),
  method: text("method").default(""),
  headers: text("headers").default("{}"),
  body: text("body").default(""),
  queryParams: text("query_params").default("{}"),
  status: text("status").default("SUCCESS"),
  statusCode: integer("status_code").default(200),
  errorMessage: text("error_message").default(""),
  responseBody: text("response_body").default(""),
  userAgent: text("user_agent").default(""),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertHttpEndpointSchema = createInsertSchema(httpEndpoints).omit({ id: true, createdAt: true, isActive: true, totalRequests: true, totalSuccess: true, totalFailed: true });
export type InsertHttpEndpoint = z.infer<typeof insertHttpEndpointSchema>;
export type HttpEndpoint = typeof httpEndpoints.$inferSelect;

export const insertHttpIncomingLogSchema = createInsertSchema(httpIncomingLogs).omit({ id: true, createdAt: true });
export type InsertHttpIncomingLog = z.infer<typeof insertHttpIncomingLogSchema>;
export type HttpIncomingLog = typeof httpIncomingLogs.$inferSelect;

export const httpSmppMessages = pgTable("http_smpp_messages", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  httpLogId: varchar("http_log_id").references(() => httpIncomingLogs.id),
  endpointId: varchar("endpoint_id").references(() => httpEndpoints.id),
  providerId: varchar("provider_id").references(() => smsProviders.id),
  providerName: text("provider_name").default(""),
  sourceAddr: text("source_addr").default(""),
  destAddr: text("dest_addr").default(""),
  messageContent: text("message_content").default(""),
  rawBody: text("raw_body").default(""),
  smppStatus: text("smpp_status").default("pending"),
  smppMessageId: text("smpp_message_id").default(""),
  smppError: text("smpp_error").default(""),
  encoding: text("encoding").default("GSM"),
  ipAddress: text("ip_address").default(""),
  sentAt: timestamp("sent_at"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertHttpSmppMessageSchema = createInsertSchema(httpSmppMessages).omit({ id: true, createdAt: true });
export type InsertHttpSmppMessage = z.infer<typeof insertHttpSmppMessageSchema>;
export type HttpSmppMessage = typeof httpSmppMessages.$inferSelect;

export const inactivityNotifications = pgTable("inactivity_notifications", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").references(() => users.id).notNull(),
  type: text("type").notNull(),
  title: text("title").notNull(),
  message: text("message").notNull(),
  inactiveDays: integer("inactive_days").default(0),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertInactivityNotificationSchema = createInsertSchema(inactivityNotifications).omit({ id: true, createdAt: true });
export type InsertInactivityNotification = z.infer<typeof insertInactivityNotificationSchema>;
export type InactivityNotification = typeof inactivityNotifications.$inferSelect;

export const timeSettings = pgTable("time_settings", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  counterType: text("counter_type").notNull().unique(),
  resetHour: integer("reset_hour").notNull().default(0),
  resetMinute: integer("reset_minute").notNull().default(0),
  isEnabled: boolean("is_enabled").default(false),
  lastResetAt: timestamp("last_reset_at"),
  updatedAt: timestamp("updated_at").defaultNow(),
});

export const insertTimeSettingSchema = createInsertSchema(timeSettings).omit({ id: true, updatedAt: true });
export type InsertTimeSetting = z.infer<typeof insertTimeSettingSchema>;
export type TimeSetting = typeof timeSettings.$inferSelect;

export const numberAssignmentHistory = pgTable("number_assignment_history", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").notNull(),
  number: text("number").notNull(),
  rangeId: varchar("range_id"),
  payout: text("payout").default("0.00"),
  isTest: boolean("is_test").default(false),
  assignedAt: timestamp("assigned_at").defaultNow(),
  removedAt: timestamp("removed_at"),
});

export const insertNumberAssignmentHistorySchema = createInsertSchema(numberAssignmentHistory).omit({ id: true, assignedAt: true, removedAt: true });
export type InsertNumberAssignmentHistory = z.infer<typeof insertNumberAssignmentHistorySchema>;
export type NumberAssignmentHistory = typeof numberAssignmentHistory.$inferSelect;

export const withdrawLogs = pgTable("withdraw_logs", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id"),
  username: text("username"),
  role: text("role"),
  clientId: varchar("client_id"),
  clientName: text("client_name"),
  rangeId: varchar("range_id"),
  rangeName: text("range_name"),
  action: text("action").notNull(),
  status: text("status").notNull().default("success"),
  failureReason: text("failure_reason"),
  ipAddress: text("ip_address"),
  userAgent: text("user_agent"),
  details: text("details"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertWithdrawLogSchema = createInsertSchema(withdrawLogs).omit({ id: true, createdAt: true });
export type InsertWithdrawLog = z.infer<typeof insertWithdrawLogSchema>;
export type WithdrawLog = typeof withdrawLogs.$inferSelect;

export const failedLoginLogs = pgTable("failed_login_logs", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  usernameAttempted: text("username_attempted").notNull(),
  userId: varchar("user_id"),
  ipAddress: text("ip_address"),
  userAgent: text("user_agent"),
  failureReason: text("failure_reason").notNull(),
  attemptsCount: integer("attempts_count").default(1),
  isBlocked: boolean("is_blocked").default(false),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertFailedLoginLogSchema = createInsertSchema(failedLoginLogs).omit({ id: true, createdAt: true });
export type InsertFailedLoginLog = z.infer<typeof insertFailedLoginLogSchema>;
export type FailedLoginLog = typeof failedLoginLogs.$inferSelect;

export const externalDbConnections = pgTable("external_db_connections", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  dbType: text("db_type").notNull(),
  host: text("host").notNull(),
  port: integer("port").notNull(),
  database: text("database").notNull(),
  username: text("username").notNull(),
  password: text("password").notNull(),
  sslEnabled: boolean("ssl_enabled").default(false),
  isActive: boolean("is_active").default(false),
  status: text("status").default("disconnected"),
  lastTestedAt: timestamp("last_tested_at"),
  lastSyncAt: timestamp("last_sync_at"),
  syncInterval: integer("sync_interval").default(0),
  syncType: text("sync_type").default("manual"),
  tableMappings: text("table_mappings").default("{}"),
  createdBy: varchar("created_by").references(() => users.id),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});

export const externalDbSyncLogs = pgTable("external_db_sync_logs", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  connectionId: varchar("connection_id").references(() => externalDbConnections.id),
  syncType: text("sync_type").notNull(),
  status: text("status").notNull(),
  recordsImported: integer("records_imported").default(0),
  recordsFailed: integer("records_failed").default(0),
  errorMessage: text("error_message"),
  details: text("details"),
  startedAt: timestamp("started_at").defaultNow(),
  completedAt: timestamp("completed_at"),
});

export const insertExternalDbConnectionSchema = createInsertSchema(externalDbConnections).omit({ id: true, createdAt: true, updatedAt: true, status: true, lastTestedAt: true, lastSyncAt: true });
export type InsertExternalDbConnection = z.infer<typeof insertExternalDbConnectionSchema>;
export type ExternalDbConnection = typeof externalDbConnections.$inferSelect;

export const insertExternalDbSyncLogSchema = createInsertSchema(externalDbSyncLogs).omit({ id: true, startedAt: true, completedAt: true });
export type InsertExternalDbSyncLog = z.infer<typeof insertExternalDbSyncLogSchema>;
export type ExternalDbSyncLog = typeof externalDbSyncLogs.$inferSelect;

export const messageOwnership = pgTable("message_ownership", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  messageId: varchar("message_id").references(() => messages.id).notNull(),
  ownerUserId: varchar("owner_user_id").references(() => users.id),
  ownerRole: text("owner_role").default("AGENT"),
  agentId: varchar("agent_id"),
  clientId: varchar("client_id"),
  rangeId: varchar("range_id"),
  rangeName: text("range_name"),
  numberId: varchar("number_id"),
  payout: text("payout").default("0.00"),
  agentPayout: text("agent_payout").default("0.00"),
  clientPayout: text("client_payout").default("0.00"),
  currency: text("currency").default("USD"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertMessageOwnershipSchema = createInsertSchema(messageOwnership).omit({ id: true, createdAt: true });
export type InsertMessageOwnership = z.infer<typeof insertMessageOwnershipSchema>;
export type MessageOwnership = typeof messageOwnership.$inferSelect;

export const auditLogs = pgTable("audit_logs", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  actorUserId: varchar("actor_user_id").references(() => users.id),
  actorUsername: text("actor_username"),
  action: text("action").notNull(),
  entityType: text("entity_type").notNull(),
  entityId: text("entity_id"),
  status: text("status").default("success"),
  ipAddress: text("ip_address"),
  userAgent: text("user_agent"),
  details: text("details"),
  meta: text("meta"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertAuditLogSchema = createInsertSchema(auditLogs).omit({ id: true, createdAt: true });
export type InsertAuditLog = z.infer<typeof insertAuditLogSchema>;
export type AuditLog = typeof auditLogs.$inferSelect;

export const withdrawRequests = pgTable("withdraw_requests", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  numberId: varchar("number_id").references(() => smsNumbers.id),
  numberText: text("number_text"),
  agentId: varchar("agent_id").references(() => users.id).notNull(),
  clientId: varchar("client_id"),
  clientName: text("client_name"),
  status: text("status").default("pending"),
  reason: text("reason"),
  reviewedBy: varchar("reviewed_by").references(() => users.id),
  reviewedAt: timestamp("reviewed_at"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertWithdrawRequestSchema = createInsertSchema(withdrawRequests).omit({ id: true, createdAt: true, reviewedBy: true, reviewedAt: true, status: true });
export type InsertWithdrawRequest = z.infer<typeof insertWithdrawRequestSchema>;
export type WithdrawRequest = typeof withdrawRequests.$inferSelect;

export const archivedAccounts = pgTable("archived_accounts", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  originalUserId: varchar("original_user_id").notNull(),
  username: text("username"),
  firstName: text("first_name").notNull(),
  secondName: text("second_name").notNull(),
  email: text("email").notNull(),
  role: text("role"),
  createdBy: varchar("created_by"),
  contact: text("contact"),
  skypeId: text("skype_id"),
  companyName: text("company_name"),
  address: text("address"),
  country: text("country"),
  isActive: boolean("is_active").default(false),
  originalCreatedAt: timestamp("original_created_at"),
  archivedAt: timestamp("archived_at").defaultNow(),
});

export const insertArchivedAccountSchema = createInsertSchema(archivedAccounts).omit({ id: true, archivedAt: true });
export type InsertArchivedAccount = z.infer<typeof insertArchivedAccountSchema>;
export type ArchivedAccount = typeof archivedAccounts.$inferSelect;

export const httpIncomingProviders = pgTable("http_incoming_providers", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  slug: text("slug").notNull().unique(),
  token: text("token").default(""),
  ipAddresses: text("ip_addresses").default(""),
  cliField: text("cli_field").default("cli"),
  messageField: text("message_field").default("message"),
  uniqueIdField: text("unique_id_field").default("uuid"),
  isActive: boolean("is_active").default(true),
  totalReceived: integer("total_received").default(0),
  lastIp: text("last_ip").default(""),
  lastReceivedAt: timestamp("last_received_at"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const httpIncomingMessages = pgTable("http_incoming_messages", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  providerId: varchar("provider_id").references(() => httpIncomingProviders.id, { onDelete: "cascade" }),
  providerName: text("provider_name").default(""),
  senderIp: text("sender_ip").default(""),
  cli: text("cli").default(""),
  messageContent: text("message_content").default(""),
  uniqueId: text("unique_id").default(""),
  isDuplicate: boolean("is_duplicate").default(false),
  rawBody: text("raw_body").default(""),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertHttpIncomingProviderSchema = createInsertSchema(httpIncomingProviders).omit({ id: true, createdAt: true, isActive: true, totalReceived: true, lastIp: true, lastReceivedAt: true });
export type InsertHttpIncomingProvider = z.infer<typeof insertHttpIncomingProviderSchema>;
export type HttpIncomingProvider = typeof httpIncomingProviders.$inferSelect;

export const insertHttpIncomingMessageSchema = createInsertSchema(httpIncomingMessages).omit({ id: true, createdAt: true });
export type InsertHttpIncomingMessage = z.infer<typeof insertHttpIncomingMessageSchema>;
export type HttpIncomingMessage = typeof httpIncomingMessages.$inferSelect;

export const paymentWithdrawals = pgTable("payment_withdrawals", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  agentId: varchar("agent_id").notNull(),
  agentName: text("agent_name"),
  amountUsd: text("amount_usd").notNull(),
  amountEgp: text("amount_egp"),
  currency: text("currency").default("USD"),
  exchangeRate: text("exchange_rate"),
  methodId: text("method_id"),
  methodName: text("method_name"),
  accountDetails: text("account_details"),
  status: text("status").default("pending"),
  proofImageUrl: text("proof_image_url"),
  adminNote: text("admin_note"),
  reviewedBy: varchar("reviewed_by"),
  reviewedAt: timestamp("reviewed_at"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertPaymentWithdrawalSchema = createInsertSchema(paymentWithdrawals).omit({ id: true, createdAt: true, reviewedBy: true, reviewedAt: true, status: true, proofImageUrl: true, adminNote: true });
export type InsertPaymentWithdrawal = z.infer<typeof insertPaymentWithdrawalSchema>;
export type PaymentWithdrawal = typeof paymentWithdrawals.$inferSelect;

export const sources = pgTable("sources", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  image: text("image"),
  description: text("description").default(""),
  counterIncrement: integer("counter_increment").default(2),
  counterBase: integer("counter_base").default(0),
  isCounterActive: boolean("is_counter_active").default(true),
  createdAt: timestamp("created_at").defaultNow(),
});

export const sourceRanges = pgTable("source_ranges", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  sourceId: varchar("source_id").references(() => sources.id, { onDelete: "cascade" }),
  rangeId: varchar("range_id").references(() => smsRanges.id, { onDelete: "cascade" }),
  isActive: boolean("is_active").default(true),
  deliveryPercentage: text("delivery_percentage").default("100"),
});

export const insertSourceSchema = createInsertSchema(sources).omit({ id: true, createdAt: true });
export type InsertSource = z.infer<typeof insertSourceSchema>;
export type Source = typeof sources.$inferSelect;

export const insertSourceRangeSchema = createInsertSchema(sourceRanges).omit({ id: true });
export type InsertSourceRange = z.infer<typeof insertSourceRangeSchema>;
export type SourceRange = typeof sourceRanges.$inferSelect;

export const webhookLogs = pgTable("webhook_logs", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").notNull(),
  event: text("event").notNull(),
  messageId: text("message_id"),
  number: text("number"),
  cli: text("cli"),
  content: text("content"),
  range: text("range"),
  provider: text("provider"),
  receivedAt: text("received_at"),
  rawPayload: text("raw_payload"),
  createdAt: timestamp("created_at").defaultNow(),
});

export type WebhookLog = typeof webhookLogs.$inferSelect;

export const incomingMessages = pgTable("incoming_messages", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  msgid: text("msgid").default(""),
  number: text("number").default(""),
  message: text("message").default(""),
  status: text("status").default("pending"),
  rawStatus: text("raw_status").default(""),
  time: text("time").default(""),
  senderIp: text("sender_ip").default(""),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertIncomingMessageSchema = createInsertSchema(incomingMessages).omit({ id: true, createdAt: true });
export type InsertIncomingMessage = z.infer<typeof insertIncomingMessageSchema>;
export type IncomingMessage = typeof incomingMessages.$inferSelect;

export const dlrMessages = pgTable("dlr_messages", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  msgid: text("msgid").default(""),
  number: text("number").default(""),
  message: text("message").default(""),
  status: text("status").default("pending"),
  rawStatus: text("raw_status").default(""),
  time: text("time").default(""),
  senderIp: text("sender_ip").default(""),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertDlrMessageSchema = createInsertSchema(dlrMessages).omit({ id: true, createdAt: true });
export type InsertDlrMessage = z.infer<typeof insertDlrMessageSchema>;
export type DlrMessage = typeof dlrMessages.$inferSelect;

export const httpForwardingRules = pgTable("http_forwarding_rules", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  agentId: varchar("agent_id").references(() => users.id),
  agentName: text("agent_name"),
  url: text("url").notNull(),
  receiverUrl: text("receiver_url"),
  protocol: text("protocol").default("HTTP_POST"),
  method: text("method").default("POST"),
  headers: text("headers").default("{}"),
  active: boolean("active").default(true),
  description: text("description"),
  messageCount: integer("message_count").default(0),
  createdAt: timestamp("created_at").defaultNow(),
});

export const insertHttpForwardingRuleSchema = createInsertSchema(httpForwardingRules).omit({ id: true, createdAt: true });
export type InsertHttpForwardingRule = z.infer<typeof insertHttpForwardingRuleSchema>;
export type HttpForwardingRule = typeof httpForwardingRules.$inferSelect;

// Persistent system flags table — used to track one-time operations (e.g. data resets) across restarts and deployments
export const systemFlags = pgTable("system_flags", {
  key: text("key").primaryKey(),
  doneAt: timestamp("done_at").defaultNow(),
});
