# Express SMS — التوثيق الفني الشامل

> **المشروع:** Express SMS — منصة SMS دولية متكاملة  
> **الموقع:** [expresssms.online](https://expresssms.online)  
> **Stack:** TypeScript · Node.js · Express · PostgreSQL · Drizzle ORM · React (Vite)

---

## الفهرس

1. [ربط الواجهة بالخادم](#1-ربط-الواجهة-بالخادم)
2. [مخطط قاعدة البيانات](#2-مخطط-قاعدة-البيانات)
3. [نقاط النهاية — API Endpoints](#3-نقاط-النهاية)

---

## 1. ربط الواجهة بالخادم

### البنية العامة

المشروع يعمل على **خادم Express واحد** يخدم كلاً من:
- **الـ API** (REST endpoints تحت مسار `/api/...`)
- **الواجهة الأمامية** (React/Vite — يُخدَّم عبر `server/vite.ts`)

لا يوجد خادمان منفصلان — نفس المنفذ (`5000`) يخدم الجميع.

```
المتصفح  ──►  Port 5000  ──►  Express Server
                              ├── /api/*      →  REST API Handlers
                              └── /*          →  React App (Vite SSR/Static)
```

### طريقة الاتصال

| الجانب | التقنية |
|--------|---------|
| API | **REST API** (JSON over HTTP) |
| الوقت الفعلي | **لا يوجد WebSocket** (polling عبر TanStack Query) |
| المصادقة | **Session Cookies** (`express-session`) + **API Token** (header) |
| رفع الملفات | **Multer** (multipart/form-data) |
| بروتوكول SMS | **SMPP** (smpp-service.ts) |

### كيفية الاتصال من الواجهة الأمامية

```typescript
// client/src/lib/queryClient.ts
// الـ fetcher الافتراضي يُرسل كل الطلبات إلى /api/...
const res = await fetch(`/api/messages/cdr?${params}`);
```

يستخدم المشروع **TanStack Query v5** لإدارة حالة الطلبات:
```typescript
// قراءة البيانات
const { data } = useQuery({ queryKey: ["/api/sms-numbers"] });

// كتابة البيانات
const mutation = useMutation({
  mutationFn: () => apiRequest("POST", "/api/messages", body),
  onSuccess: () => queryClient.invalidateQueries({ queryKey: ["/api/messages"] }),
});
```

### المتغيرات البيئية

| المتغير | الاستخدام | مطلوب |
|---------|----------|-------|
| `DATABASE_URL` | رابط اتصال PostgreSQL | ✅ نعم |
| `SESSION_SECRET` | تشفير الـ Session | ✅ نعم |
| `NODE_ENV` | بيئة التشغيل (`development` / `production`) | ✅ نعم |
| `TELEGRAM_BOT_TOKEN` | بوت التيليجرام للإشعارات | اختياري |
| `REPLIT_DEV_DOMAIN` | النطاق في بيئة Replit | تلقائي |

### المصادقة والصلاحيات

| Middleware | الوصف |
|-----------|-------|
| `requireAuth` | يتحقق من وجود جلسة نشطة |
| `requireAdmin` | يتحقق أن دور المستخدم `admin` |
| `requireAdminOrSubAdmin` | `admin` أو `sub_admin` |
| `requireAuthOrApiToken` | جلسة أو مفتاح API في الـ header |

**أدوار المستخدمين:**

| الدور | الصلاحيات |
|------|----------|
| `admin` | وصول كامل لكل شيء |
| `tester` | رؤية الرسائل التجريبية فقط |
| `agent` | إدارة أرقامه وعملائه، رؤية CDR خاص به |
| `client` | رؤية أرقامه وCDR الخاصة به فقط |

---

## 2. مخطط قاعدة البيانات

### قائمة الجداول (40 جدول)

| الجدول | الغرض |
|--------|-------|
| `users` | المستخدمون (admin / agent / tester) |
| `clients` | عملاء الـ agents |
| `countries` | الدول المتاحة |
| `activation_codes` | أكواد تفعيل التسجيل |
| `api_keys` | مفاتيح API للوصول البرمجي |
| `messages` | الرسائل SMS الواردة |
| `message_ownership` | ملكية كل رسالة (agent/client) |
| `phone_numbers` | أرقام الهاتف (نظام قديم) |
| `sms_numbers` | أرقام SMS الحديثة مع الأسعار |
| `sms_ranges` | نطاقات الأرقام مع إعدادات التسعير |
| `sms_test_numbers` | أرقام الاختبار |
| `sms_providers` | مزودو SMPP |
| `smpp_logs` | سجلات بروتوكول SMPP |
| `smpp_gateway_users` | مستخدمو SMPP Gateway |
| `smpp_gateway_groups` | مجموعات SMPP Gateway |
| `smpp_http_api_keys` | مفاتيح HTTP-SMPP API |
| `smpp_dlr_reports` | تقارير الـ DLR |
| `api_connections` | اتصالات Auto-Fetch API |
| `number_requests` | طلبات أرقام من المستخدمين |
| `agent_number_requests` | طلبات أرقام من الـ agents |
| `number_assignment_history` | تاريخ تعيين الأرقام |
| `support_conversations` | محادثات الدعم الفني |
| `support_messages` | رسائل الدعم الفني |
| `message_reactions` | تفاعلات رسائل الدعم |
| `ticket_attachments` | مرفقات تذاكر الدعم |
| `news` | الأخبار والإشعارات |
| `announcements` | الإعلانات مع الصور |
| `telegram_bot_config` | إعدادات بوت التيليجرام |
| `telegram_bot_users` | مستخدمو بوت التيليجرام |
| `payment_methods` | طرق الدفع |
| `credit_requests` | طلبات شحن الرصيد |
| `payment_withdrawals` | طلبات سحب الأرباح |
| `withdraw_requests` | طلبات سحب الأرقام |
| `withdraw_logs` | سجلات عمليات السحب |
| `platform_info` | إعدادات المنصة العامة |
| `login_history` | سجل تسجيل الدخول |
| `failed_login_logs` | سجل محاولات الدخول الفاشلة |
| `http_endpoints` | نقاط HTTP للاستقبال |
| `http_incoming_logs` | سجلات HTTP الواردة |
| `http_incoming_providers` | مزودو HTTP الواردة |
| `http_incoming_messages` | رسائل HTTP الواردة |
| `http_smpp_messages` | رسائل HTTP-SMPP |
| `inactivity_notifications` | إشعارات عدم النشاط |
| `time_settings` | إعدادات مواعيد الإعادة التلقائية |
| `external_db_connections` | اتصالات قواعد بيانات خارجية |
| `external_db_sync_logs` | سجلات المزامنة مع قواعد البيانات الخارجية |
| `audit_logs` | سجل العمليات التدقيقية |
| `archived_accounts` | الحسابات المؤرشفة |
| `sources` | مصادر الأرقام |
| `source_ranges` | ربط المصادر بالنطاقات |
| `webhook_logs` | سجلات الـ Webhook |
| `incoming_messages` | رسائل SMPP الواردة |
| `dlr_messages` | رسائل DLR |

---

### تفاصيل الجداول الرئيسية

#### `users` — المستخدمون

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `id` | `varchar` PK | UUID تلقائي |
| `first_name` | `text` NOT NULL | الاسم الأول |
| `second_name` | `text` NOT NULL | الاسم الثاني |
| `email` | `text` UNIQUE | البريد الإلكتروني |
| `password` | `text` NOT NULL | كلمة المرور (مشفرة) |
| `username` | `text` | اسم المستخدم |
| `role` | `text` | الدور: `admin` / `agent` / `tester` |
| `is_active` | `boolean` | حالة الحساب |
| `created_by` | `varchar` FK→users | من أنشأ الحساب |
| `usd_balance` | `text` | الرصيد بالدولار |
| `eur_balance` | `text` | الرصيد باليورو |
| `gbp_balance` | `text` | الرصيد بالجنيه الإسترليني |
| `egp_balance` | `text` | الرصيد بالجنيه المصري |
| `sms_delivery_via` | `text` | طريقة التسليم: `HTTP` / `SMPP` |
| `http_delivery_url` | `text` | رابط webhook تسليم الرسائل |
| `bind_status` | `text` | حالة الاتصال: `HTTP` / `SMPP` |
| `unique_code` | `text` UNIQUE | الكود الفريد للـ agent |
| `webhook_url` | `text` | رابط الـ webhook |
| `expires_at` | `timestamp` | تاريخ انتهاء الحساب |
| `created_at` | `timestamp` | تاريخ الإنشاء |

**العلاقات:** `users.created_by` → `users.id` (self-reference للـ agents)

---

#### `clients` — عملاء الـ Agents

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `id` | `varchar` PK | UUID تلقائي |
| `username` | `text` UNIQUE NOT NULL | اسم المستخدم |
| `name` | `text` | الاسم الكامل |
| `email` | `text` | البريد الإلكتروني |
| `password` | `text` NOT NULL | كلمة المرور |
| `balance` | `text` | الرصيد |
| `status` | `text` | الحالة: `active` / `disabled` |
| `agent_id` | `varchar` FK→users | الـ agent المسؤول |
| `created_at` | `timestamp` | تاريخ الإنشاء |

**العلاقات:** `clients.agent_id` → `users.id` (Many-to-One)

---

#### `sms_ranges` — نطاقات الأرقام

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `id` | `varchar` PK | UUID تلقائي |
| `name` | `text` NOT NULL | اسم النطاق |
| `provider` | `text` | مزود الخدمة |
| `prefix` | `text` | بادئة الرقم |
| `currency` | `text` | العملة: `USD` / `EUR` / `GBP` |
| `payterm` | `text` | شروط الدفع (مثل `7/1`) |
| `payout` | `text` | سعر الـ Admin (مخفي عن الـ agents) |
| `agent_payout` | `text` | عمولة الـ agent |
| `max_sms_limit_day` | `integer` | حد الرسائل اليومي |
| `range_msg_limit` | `integer` | حد رسائل النطاق |
| `country_id` | `varchar` FK→countries | الدولة |
| `payout_1_1` إلى `payout_30_60` | `text` | أسعار حسب شروط الدفع |
| `created_at` | `timestamp` | تاريخ الإنشاء |

---

#### `sms_numbers` — أرقام SMS

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `id` | `varchar` PK | UUID تلقائي |
| `range_id` | `varchar` FK→sms_ranges | النطاق التابع له |
| `number` | `text` NOT NULL | رقم الهاتف |
| `user_id` | `varchar` FK→users | الـ agent المعين |
| `client_id` | `varchar` | العميل المعين |
| `payout` | `text` | سعر Admin (مخفي عن agents/clients) |
| `agent_payout` | `text` | عمولة الـ agent |
| `client_payout` | `text` | سعر العميل |
| `is_test` | `boolean` | هل هو رقم تجريبي |
| `number_msg_limit` | `integer` | حد الرسائل للرقم |
| `created_at` | `timestamp` | تاريخ الإضافة |
| `deleted_at` | `timestamp` | تاريخ الحذف (soft delete) |

**العلاقات:**
- `sms_numbers.range_id` → `sms_ranges.id` (Many-to-One)
- `sms_numbers.user_id` → `users.id` (Many-to-One)

---

#### `messages` — الرسائل الواردة

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `id` | `varchar` PK | UUID تلقائي |
| `time` | `timestamp` | وقت الاستقبال |
| `country` | `text` NOT NULL | الدولة |
| `number` | `text` NOT NULL | رقم الوجهة |
| `cllr` | `text` NOT NULL | المُرسِل (CLI) |
| `content` | `text` | محتوى الرسالة |
| `user_id` | `varchar` FK→users | المستخدم المرتبط |
| `range` | `text` | اسم النطاق |
| `payout` | `text` | سعر Admin |
| `client_payout` | `text` | سعر العميل |
| `agent_payout` | `text` | عمولة الـ agent |
| `currency` | `text` | العملة |
| `provider` | `text` | المزود |
| `type` | `text` | النوع: `API` / `HTTP` / `TEST` |
| `cause` | `text` | السبب: `Success` / ... |
| `ip` | `text` | IP المُرسِل |

---

#### `message_ownership` — ملكية الرسائل

> **الجدول الأساسي للـ CDR** — يربط كل رسالة بصاحبها الحقيقي

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `id` | `varchar` PK | UUID تلقائي |
| `message_id` | `varchar` FK→messages NOT NULL | الرسالة |
| `owner_user_id` | `varchar` FK→users | مالك الرسالة |
| `owner_role` | `text` | `AGENT` / `CLIENT` / `TEST` / `UNASSIGNED` |
| `agent_id` | `varchar` | معرف الـ agent |
| `client_id` | `varchar` | معرف العميل |
| `range_id` | `varchar` | معرف النطاق |
| `range_name` | `text` | اسم النطاق |
| `number_id` | `varchar` | معرف الرقم |
| `payout` | `text` | سعر Admin (مخفي عن agents) |
| `agent_payout` | `text` | عمولة الـ agent الفعلية |
| `client_payout` | `text` | سعر العميل |
| `currency` | `text` | العملة |
| `created_at` | `timestamp` | تاريخ الإنشاء |

**العلاقات:** `message_ownership.message_id` → `messages.id` (One-to-One)

---

#### `sms_providers` — مزودو SMPP

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `id` | `varchar` PK | UUID |
| `provider_name` | `text` NOT NULL | اسم المزود |
| `smpp_host` | `text` | عنوان SMPP |
| `smpp_port` | `text` | منفذ SMPP (افتراضي 2775) |
| `system_id` | `text` | معرف النظام |
| `smsc_password` | `text` | كلمة مرور SMSC |
| `bind_mode` | `text` | وضع الاتصال |
| `bind_type` | `text` | `transceiver` / `receiver` / `transmitter` |
| `bind_status` | `text` | `connected` / `disconnected` |
| `dlr_enabled` | `boolean` | تفعيل DLR |
| `rate_limit` | `integer` | حد المعدل (رسالة/ثانية) |
| `is_active` | `boolean` | حالة التفعيل |
| `total_sent` | `integer` | إجمالي المُرسَل |
| `total_delivered` | `integer` | إجمالي المُسلَّم |
| `created_at` | `timestamp` | تاريخ الإنشاء |

---

#### `api_connections` — اتصالات Auto-Fetch

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `id` | `varchar` PK | UUID |
| `name` | `text` NOT NULL | اسم الاتصال |
| `api_token` | `text` NOT NULL | رمز المصادقة |
| `api_url` | `text` NOT NULL | رابط الـ API |
| `status` | `text` | `online` / `offline` |
| `auto_fetch` | `boolean` | الجلب التلقائي |
| `fetch_interval_seconds` | `integer` | الفاصل الزمني (ثوان) |
| `last_fetched_at` | `timestamp` | آخر جلب |
| `last_fetched_record_date` | `text` | تاريخ آخر سجل مجلوب |
| `total_fetched` | `integer` | إجمالي المجلوب |
| `created_at` | `timestamp` | تاريخ الإنشاء |

---

#### `support_conversations` — محادثات الدعم

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `id` | `varchar` PK | UUID |
| `user_id` | `varchar` FK→users NOT NULL | صاحب التذكرة |
| `subject` | `text` NOT NULL | الموضوع |
| `status` | `text` | `open` / `closed` / `pending` |
| `priority` | `text` | `low` / `medium` / `high` / `urgent` |
| `assigned_agent_id` | `varchar` FK→users | الدعم المعين |
| `is_muted` | `boolean` | كتم الإشعارات |
| `is_blocked` | `boolean` | حجب المستخدم |
| `archived` | `boolean` | أرشفة المحادثة |
| `unread_count` | `integer` | عدد الرسائل غير المقروءة |
| `created_at` | `timestamp` | تاريخ الإنشاء |

---

#### `payment_withdrawals` — طلبات السحب المالي

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `id` | `varchar` PK | UUID |
| `agent_id` | `varchar` NOT NULL | الـ agent الطالب |
| `agent_name` | `text` | اسم الـ agent |
| `amount_usd` | `text` NOT NULL | المبلغ بالدولار |
| `amount_egp` | `text` | المبلغ بالجنيه المصري |
| `currency` | `text` | العملة |
| `method_name` | `text` | طريقة الدفع |
| `account_details` | `text` | تفاصيل الحساب |
| `status` | `text` | `pending` / `approved` / `rejected` |
| `proof_image_url` | `text` | صورة إثبات الدفع |
| `admin_note` | `text` | ملاحظة الـ Admin |
| `reviewed_by` | `varchar` | من راجع الطلب |
| `reviewed_at` | `timestamp` | تاريخ المراجعة |
| `created_at` | `timestamp` | تاريخ الطلب |

---

#### `platform_info` — إعدادات المنصة

| الحقل | النوع | الوصف |
|-------|-------|-------|
| `platform_name` | `text` | اسم المنصة |
| `platform_subtitle` | `text` | العنوان الفرعي |
| `contact_email` | `text` | بريد التواصل |
| `facebook_url` | `text` | رابط فيسبوك |
| `whatsapp_number` | `text` | رقم واتساب |
| `telegram_username` | `text` | يوزر تيليجرام |
| `ramadan_mode` | `boolean` | وضع رمضان |
| `login_background_type` | `text` | نوع خلفية تسجيل الدخول |
| `custom_exchange_rate` | `text` | سعر صرف مخصص |
| `min_withdrawal_usd` | `text` | الحد الأدنى للسحب (USD) |
| `withdrawal_window_enabled` | `boolean` | نافذة السحب المجدولة |
| `updated_at` | `timestamp` | آخر تحديث |

---

### مخطط العلاقات (ERD المبسط)

```
users ──────────────────────────── clients
  │ (created_by: agent→agent)        │ (agent_id → users)
  │                                  │
  ├── sms_numbers ──── sms_ranges    │
  │     │ (user_id)    │             │
  │     │              └── countries │
  │     └── message_ownership        │
  │           │ ← messages           │
  │           │   (message_id)       │
  │           ├── agent_id → users   │
  │           └── client_id ─────────┘
  │
  ├── support_conversations ── support_messages ── message_reactions
  ├── credit_requests
  ├── payment_withdrawals
  └── api_keys
```

---

## 3. نقاط النهاية

> **ملاحظة:** جميع المسارات تحت `/api/` — مثلاً `POST /auth/login` = `POST /api/auth/login`

### أكواد HTTP المستخدمة

| الكود | المعنى |
|-------|-------|
| `200` | نجاح |
| `201` | تم الإنشاء |
| `400` | خطأ في البيانات المُرسَلة |
| `401` | غير مصادق (تسجيل الدخول مطلوب) |
| `403` | غير مصرح (لا صلاحية) |
| `404` | غير موجود |
| `409` | تعارض (بيانات مكررة) |
| `500` | خطأ في الخادم |

---

### 🔐 المصادقة (`/api/auth/`)

#### `POST /api/auth/register`
تسجيل مستخدم جديد باستخدام كود التفعيل.

**Body:**
```json
{
  "firstName": "Ahmed",
  "secondName": "Ali",
  "email": "ahmed@example.com",
  "password": "secret123",
  "activationCode": "ABCD-1234"
}
```

**Success (200):** بيانات المستخدم + تهيئة الجلسة  
**Error (400):** كود غير صالح أو مستخدم بالفعل

---

#### `POST /api/auth/login`
تسجيل الدخول.

**Body:**
```json
{ "username": "admin", "password": "Admin@123" }
```

**Success (200):**
```json
{
  "user": {
    "id": "uuid", "firstName": "Admin", "role": "admin",
    "usdBalance": "0", "eurBalance": "0", "lastLogin": "..."
  }
}
```
**Error (401):** بيانات خاطئة أو حساب غير مفعل

---

#### `POST /api/auth/logout`
تسجيل الخروج وإنهاء الجلسة.

**Success (200):** `{ "message": "Logged out" }`

---

#### `GET /api/auth/session`
الحصول على بيانات الجلسة الحالية.

**Success (200):** بيانات المستخدم المسجل  
**Error (401):** لا توجد جلسة

---

### 👤 المستخدمون (`/api/users/`)

#### `PATCH /api/users/:id/profile`
تحديث بيانات الملف الشخصي.

**Auth:** مطلوب | **Params:** `id` = معرف المستخدم

**Body:**
```json
{
  "firstName": "Ahmed", "secondName": "Ali",
  "contact": "+20100...", "skypeId": "...",
  "companyName": "...", "address": "...", "country": "EG"
}
```

---

#### `POST /api/users/:id/profile-picture`
رفع صورة الملف الشخصي.

**Auth:** مطلوب | **Body:** `multipart/form-data` — حقل `profilePicture`

**Success (200):** `{ "profilePicture": "/uploads/..." }`

---

#### `PATCH /api/users/:id/password`
تغيير كلمة المرور.

**Body:**
```json
{ "currentPassword": "old", "newPassword": "new123" }
```

---

#### `POST /api/admin/users` *(Admin)*
إنشاء مستخدم جديد من قِبل الـ Admin.

**Body:** بيانات المستخدم الكاملة مع الدور والصلاحيات

---

#### `GET /api/admin/users/:adminId` *(Admin)*
قائمة المستخدمين المنشأة بواسطة Admin معين.

---

#### `PUT /api/admin/users/:id` *(Admin)*
تعديل بيانات مستخدم.

---

#### `DELETE /api/admin/users/:id` *(Admin)*
حذف مستخدم.

---

#### `POST /api/admin/users/bulk-delete` *(Admin)*
حذف مجموعة مستخدمين.

**Body:** `{ "ids": ["id1", "id2"] }`

---

#### `GET /api/admin/all-users` *(Admin/SubAdmin)*
قائمة جميع المستخدمين.

**Query:** `?role=agent&search=ahmed`

---

#### `GET /api/admin/system-accounts` *(Admin)*
حسابات النظام (sub_admin).

---

#### `POST /api/admin/system-accounts` *(Admin)*
إنشاء حساب نظام جديد.

---

#### `PUT /api/admin/system-accounts/:id` *(Admin)*
تعديل حساب نظام.

---

#### `DELETE /api/admin/system-accounts/:id` *(Admin)*
حذف حساب نظام.

---

### 🤝 العملاء (`/api/clients/`)

#### `GET /api/clients`
قائمة عملاء الـ agent المسجل.

**Auth:** مطلوب | **Query:** `?userId=agent_id`

**Success (200):**
```json
[{ "id": "uuid", "username": "client1", "name": "Client Name", "balance": "50.00", "status": "active" }]
```

---

#### `POST /api/clients`
إضافة عميل جديد.

**Body:**
```json
{
  "username": "client1", "name": "Client Name",
  "email": "client@example.com", "password": "pass123",
  "contact": "+20...", "agentId": "agent_uuid"
}
```

---

#### `PATCH /api/clients/:id`
تعديل بيانات عميل.

---

#### `PATCH /api/clients/:id/status`
تغيير حالة عميل (تفعيل/تعطيل).

**Body:** `{ "status": "active" | "disabled" }`

---

#### `DELETE /api/clients/:id`
حذف عميل.

---

### 📨 الرسائل (`/api/messages/`)

#### `GET /api/messages` *(Admin)*
قائمة جميع الرسائل (Admin فقط).

---

#### `GET /api/messages/cdr`
تقرير CDR مفصّل حسب دور المستخدم.

**Auth:** مطلوب (أو API Token في الـ header)

**Query:**
```
startDate=2026-03-01 00:00:00
endDate=2026-03-31 23:59:59
number=593979...   (بحث برقم)
cli=TestSender     (بحث بالمُرسِل)
range=Ecuador...   (تصفية بالنطاق)
page=1
pageSize=200
```

**Success (200):**
```json
[{
  "id": "uuid",
  "time": "2026-03-25T01:17:23.593Z",
  "number": "593979493132",
  "cllr": "TestSender",
  "content": "Message text",
  "payout": "0.014",
  "agentPayout": "0.012",
  "clientPayout": "0.00",
  "currency": "USD",
  "ownerRole": "AGENT",
  "agentId": "uuid",
  "clientId": null,
  "rangeName": "Ecuador express TF01",
  "agentName": "Agent Name",
  "clientName": null
}]
```

**ملاحظة الأمان:** الـ `payout` (سعر Admin) مخفي في واجهات agents/clients — يظهر `agentPayout` للـ agents و`clientPayout` للعملاء فقط.

---

#### `POST /api/messages`
إنشاء رسالة واردة يدوية.

**Auth:** مطلوب | **Body:**
```json
{
  "number": "593979493132",
  "cllr": "TestSender",
  "content": "Test message",
  "country": "EC"
}
```

**Error (400):** `{ "message": "Destination number is not registered in SMS Numbers" }`

---

#### `GET /api/messages/with-users`
الرسائل مع بيانات المستخدمين.

---

### 📱 نطاقات وأرقام SMS

#### `GET /api/sms-ranges`
قائمة النطاقات المتاحة.

**Auth:** مطلوب

**Success (200):**
```json
[{
  "id": "uuid", "name": "Ecuador express TF01",
  "provider": "fly sms", "currency": "USD",
  "payout": "0.014", "agentPayout": "0.012",
  "availableCount": 50
}]
```

---

#### `GET /api/admin/sms-ranges` *(Admin/SubAdmin)*
قائمة النطاقات الكاملة مع تفاصيل الأسعار.

---

#### `POST /api/admin/sms-ranges` *(Admin)*
إنشاء نطاق جديد.

**Body:**
```json
{
  "name": "New Range", "provider": "fly sms",
  "currency": "USD", "payout": "0.014",
  "agentPayout": "0.012", "payterm": "7/1"
}
```

---

#### `PATCH /api/admin/sms-ranges/:id` *(Admin)*
تعديل نطاق.

---

#### `DELETE /api/admin/sms-ranges/:id` *(Admin)*
حذف نطاق.

---

#### `GET /api/sms-numbers`
قائمة الأرقام.

**Query:** `?search=593&userId=agent_id&rangeId=uuid`

---

#### `POST /api/sms-numbers` *(Admin)*
إضافة رقم واحد.

**Body:**
```json
{
  "number": "593979493132", "rangeId": "uuid",
  "payout": "0.014", "agentPayout": "0.012", "clientPayout": "0.00"
}
```

---

#### `POST /api/sms-numbers/bulk` *(Admin)*
إضافة أرقام بالجملة.

**Body:**
```json
{
  "numbers": ["593979493132", "593979493133"],
  "rangeId": "uuid", "payout": "0.014"
}
```

---

#### `PATCH /api/sms-numbers/:id` *(Admin)*
تعديل رقم.

---

#### `DELETE /api/sms-numbers/:id` *(Admin)*
حذف رقم (soft delete).

---

#### `POST /api/sms-numbers/assign-agent` *(Admin)*
تعيين رقم لـ agent.

**Body:** `{ "numberId": "uuid", "agentId": "uuid" }`

---

#### `GET /api/agent/sms-numbers`
أرقام الـ agent المسجل (بدون سعر Admin).

**Auth:** Agent

**Success (200):**
```json
[{
  "id": "uuid", "number": "593985230861",
  "agentPayout": "0.012", "clientPayout": "0.00",
  "rangeName": "Ecuador express TF01"
}]
```

---

#### `PATCH /api/agent/sms-numbers/:id/client`
ربط رقم بعميل (من قِبل الـ agent).

**Body:** `{ "clientId": "uuid" }`

---

#### `POST /api/agent/sms-numbers/add-to-client`
إضافة أرقام لعميل.

---

#### `POST /api/agent/sms-numbers/remove-from-client`
إزالة أرقام من عميل.

---

#### `GET /api/agent/my-numbers`
أرقام الـ agent مع تفاصيل التعيين.

---

#### `POST /api/agent/assign-to-client`
تعيين رقم لعميل محدد.

**Body:** `{ "numberId": "uuid", "clientId": "uuid" }`

---

#### `GET /api/client/my-numbers`
أرقام العميل المسجل (بسعر العميل فقط).

**Success (200):** قائمة بـ `clientPayout` فقط — بدون `payout` أو `agentPayout`

---

#### `POST /api/sms-ranges/:id/msg-limit` *(Admin)*
تعيين حد الرسائل للنطاق.

**Body:** `{ "limit": 100 }`

---

#### `POST /api/sms-numbers/:id/msg-limit` *(Admin)*
تعيين حد الرسائل لرقم محدد.

---

### 🔌 اتصالات Auto-Fetch API

#### `GET /api/api-connections` *(Admin)*
قائمة الاتصالات.

**Success (200):**
```json
[{
  "id": "uuid", "name": "Fly SMS API",
  "status": "online", "autoFetch": true,
  "fetchIntervalSeconds": 5, "totalFetched": 22
}]
```

---

#### `POST /api/api-connections` *(Admin)*
إضافة اتصال جديد.

**Body:**
```json
{
  "name": "Provider API", "apiToken": "token123",
  "apiUrl": "http://provider.com/api/messages"
}
```

---

#### `POST /api/api-connections/:id/test` *(Admin)*
اختبار الاتصال.

---

#### `POST /api/api-connections/:id/fetch-data` *(Admin)*
جلب البيانات يدوياً.

---

#### `PATCH /api/api-connections/:id/toggle` *(Admin)*
تفعيل/تعطيل الاتصال.

---

#### `PATCH /api/api-connections/:id/auto-fetch` *(Admin)*
تفعيل/تعطيل الجلب التلقائي.

---

#### `PATCH /api/api-connections/:id` *(Admin)*
تعديل اتصال.

---

#### `DELETE /api/api-connections/:id` *(Admin)*
حذف اتصال.

---

### 📡 مزودو SMPP

#### `GET /api/sms-providers` *(Admin)*
قائمة مزودي SMPP.

---

#### `POST /api/sms-providers` *(Admin)*
إضافة مزود SMPP.

**Body:**
```json
{
  "providerName": "FlySMS", "smppHost": "smpp.provider.com",
  "smppPort": "2775", "systemId": "username",
  "smscPassword": "password", "bindType": "transceiver"
}
```

---

#### `PATCH /api/sms-providers/:id` *(Admin)*
تعديل مزود.

---

#### `DELETE /api/sms-providers/:id` *(Admin)*
حذف مزود.

---

#### `POST /api/sms-providers/:id/toggle` *(Admin)*
تفعيل/تعطيل مزود.

---

#### `POST /api/sms-providers/:id/test-bind` *(Admin)*
اختبار الاتصال بالمزود.

---

#### `POST /api/sms-providers/:id/test-sms` *(Admin)*
إرسال رسالة اختبارية.

**Body:** `{ "number": "+20100...", "message": "Test" }`

---

#### `POST /api/sms-providers/:id/disconnect` *(Admin)*
قطع الاتصال بالمزود.

---

#### `GET /api/sms-providers/:id/connection-status` *(Admin)*
حالة الاتصال بمزود محدد.

---

#### `GET /api/smpp-logs` *(Admin)*
سجلات SMPP.

**Query:** `?providerId=uuid&page=1&pageSize=50`

---

#### `DELETE /api/smpp-logs` *(Admin)*
مسح سجلات SMPP.

---

### 📤 SMPP Gateway

#### `GET /api/smpp-gateway-users` *(Admin)*
مستخدمو SMPP Gateway.

---

#### `POST /api/smpp-gateway-users` *(Admin)*
إضافة مستخدم Gateway.

**Body:**
```json
{
  "username": "gw_user", "password": "pass",
  "maxBinds": 5, "throughput": 10
}
```

---

#### `PATCH /api/smpp-gateway-users/:id` *(Admin)*
تعديل مستخدم Gateway.

---

#### `DELETE /api/smpp-gateway-users/:id` *(Admin)*
حذف مستخدم Gateway.

---

#### `GET /api/smpp-gateway-groups` *(Admin)*
مجموعات Gateway.

---

#### `POST /api/smpp-gateway-groups` *(Admin)*
إنشاء مجموعة.

---

#### `GET /api/smpp-http-api-keys` *(Admin)*
مفاتيح HTTP-SMPP API.

---

#### `POST /api/smpp-http-api-keys` *(Admin)*
إنشاء مفتاح API.

---

#### `GET /api/smpp-dlr-reports` *(Admin)*
تقارير DLR.

---

#### `DELETE /api/smpp-dlr-reports` *(Admin)*
مسح تقارير DLR.

---

#### `POST /api/v1/sms/send`
إرسال SMS عبر HTTP API (مفتاح API مطلوب في الـ header).

**Headers:** `X-API-Key: your_key`

**Body:**
```json
{
  "to": "+20100...",
  "from": "SenderID",
  "message": "Hello World"
}
```

**Success (200):** `{ "messageId": "uuid", "status": "queued" }`

---

### 🛡️ HTTP Endpoints الواردة

#### `GET /api/http-endpoints` *(Admin)*
قائمة HTTP endpoints المعرفة لاستقبال الرسائل.

---

#### `POST /api/http-endpoints` *(Admin)*
إنشاء endpoint جديد.

**Body:**
```json
{
  "name": "Provider Webhook", "slug": "provider-hook",
  "method": "POST", "authType": "token",
  "authToken": "secret", "description": "..."
}
```

---

#### `PUT /api/http-endpoints/:id` *(Admin)*
تعديل endpoint.

---

#### `PATCH /api/http-endpoints/:id/toggle` *(Admin)*
تفعيل/تعطيل endpoint.

---

#### `DELETE /api/http-endpoints/:id` *(Admin)*
حذف endpoint.

---

#### `GET /api/http-incoming-logs` *(Admin)*
سجلات الطلبات الواردة.

---

#### `DELETE /api/http-incoming-logs` *(Admin)*
مسح السجلات.

---

#### `POST /api/incoming/:slug` — **الـ Webhook الرئيسي**
استقبال رسائل واردة من المزودين الخارجيين.

**Params:** `slug` = معرف المزود (من `http_incoming_providers.slug`)

**Body (مثال):**
```json
{
  "number": "593979493132",
  "cli": "SenderID",
  "message": "Hello"
}
```

**Success (200):** `{ "status": "OK" }`  
**Error (404):** Endpoint غير موجود  
**Error (403):** IP غير مسموح به  
**Error (503):** Endpoint معطل

---

### 📊 التقارير والإحصائيات

#### `GET /api/reports/my-activity`
نشاط المستخدم الحالي (رسائل، أرقام، أرباح).

---

#### `GET /api/reports/user-activity`
نشاط مستخدم محدد.

**Query:** `?userId=uuid&startDate=...&endDate=...`

---

#### `GET /api/admin/reports/overview` *(Admin)*
نظرة عامة: عدد المستخدمين، الرسائل، الأرباح.

---

#### `GET /api/admin/reports/agents` *(Admin)*
تقرير الـ agents: رسائل وأرباح لكل agent.

---

#### `GET /api/admin/reports/login-history` *(Admin)*
تقرير تسجيلات الدخول.

---

#### `GET /api/notifications/unread`
الإشعارات غير المقروءة للمستخدم الحالي.

**Success (200):**
```json
{
  "total": 3,
  "breakdown": { "smsCdr": 3 },
  "recentSmsMessages": [...]
}
```

---

### 💳 الدفع والسحب

#### `GET /api/payment-methods`
طرق الدفع المتاحة.

---

#### `POST /api/admin/payment-methods` *(Admin)*
إضافة طريقة دفع.

**Body:** `multipart/form-data` — اسم + صورة + عملة + ترتيب

---

#### `PUT /api/payment-methods/:id` *(Admin)*
تعديل طريقة دفع.

---

#### `PATCH /api/payment-methods/:id/toggle` *(Admin)*
تفعيل/تعطيل طريقة دفع.

---

#### `GET /api/credit-requests`
طلبات شحن الرصيد.

---

#### `POST /api/credit-requests`
تقديم طلب شحن رصيد.

**Body:**
```json
{
  "amount": "100", "currency": "USD",
  "paymentMethodId": "uuid"
}
```

---

#### `PATCH /api/credit-requests/:id/status` *(Admin)*
مراجعة طلب شحن (قبول/رفض).

**Body:** `{ "status": "approved" | "rejected" }`

---

#### `GET /api/payment-withdrawals`
طلبات سحب الأرباح.

---

#### `POST /api/payment-withdrawals`
تقديم طلب سحب.

**Body:**
```json
{
  "amountUsd": "500", "currency": "USD",
  "methodId": "uuid", "accountDetails": "Account info"
}
```

---

#### `PATCH /api/payment-withdrawals/:id/review` *(Admin)*
مراجعة طلب السحب.

**Body:** `{ "status": "approved", "adminNote": "Paid via bank" }`

---

### 🎧 الدعم الفني

#### `GET /api/support/conversations`
محادثات المستخدم الحالي.

---

#### `POST /api/support/conversations`
فتح محادثة دعم جديدة.

**Body:** `{ "subject": "مشكلة في الرسائل" }`

---

#### `GET /api/admin/support/conversations` *(Admin/SubAdmin)*
جميع محادثات الدعم مع التصفية والترتيب.

---

#### `PATCH /api/admin/support/conversations/:id/assign` *(Admin/SubAdmin)*
تعيين موظف دعم للمحادثة.

---

#### `PATCH /api/admin/support/conversations/:id/status` *(Admin/SubAdmin)*
تغيير حالة المحادثة.

---

#### `GET /api/support/messages/:conversationId`
رسائل محادثة محددة.

---

#### `POST /api/support/messages`
إرسال رسالة في محادثة.

**Body:** `{ "conversationId": "uuid", "content": "النص" }`

---

#### `DELETE /api/support/messages/:id`
حذف رسالة.

---

#### `POST /api/support/messages/:conversationId/read`
تحديد المحادثة كمقروءة.

---

#### `POST /api/support/reactions`
إضافة تفاعل (إيموجي) على رسالة.

**Body:** `{ "messageId": "uuid", "emoji": "👍" }`

---

#### `POST /api/support/upload/:ticketId`
رفع مرفق لتذكرة.

**Body:** `multipart/form-data` — حقل `file`

---

### 📢 الأخبار والإعلانات

#### `GET /api/news`
قائمة الأخبار النشطة.

---

#### `GET /api/news/:id`
تفاصيل خبر محدد.

---

#### `POST /api/news` *(Admin)*
إضافة خبر.

**Body:** `{ "title": "...", "content": "...", "type": "info", "url": "https://..." }`

---

#### `PUT /api/news/:id` *(Admin)*
تعديل خبر.

---

#### `PATCH /api/news/:id/toggle` *(Admin)*
تفعيل/تعطيل خبر.

---

#### `DELETE /api/news/:id` *(Admin)*
حذف خبر.

---

#### `GET /api/announcements`
الإعلانات النشطة.

---

#### `POST /api/admin/announcements` *(Admin)*
إضافة إعلان.

**Body:** `multipart/form-data` — عنوان + نص + صورة

---

#### `PATCH /api/admin/announcements/:id` *(Admin)*
تعديل إعلان.

---

#### `DELETE /api/admin/announcements/:id` *(Admin)*
حذف إعلان.

---

### 🤖 التيليجرام

#### `GET /api/telegram-bot-config`
إعدادات بوت التيليجرام.

---

#### `POST /api/telegram-bot-config` *(Admin)*
تحديث إعدادات البوت.

**Body:**
```json
{
  "botToken": "123:TOKEN", "botUsername": "expresssms_bot",
  "adminTelegramId": "12345", "notificationsEnabled": true
}
```

---

### ⚙️ إعدادات المنصة

#### `GET /api/platform-info`
المعلومات العامة للمنصة (متاحة للعموم).

**Success (200):**
```json
{
  "platformName": "Express SMS",
  "contactEmail": "info@...",
  "whatsappNumber": "+20...",
  "ramadanMode": false
}
```

---

#### `GET /api/admin/platform-info` *(Admin)*
إعدادات المنصة الكاملة.

---

#### `PUT /api/admin/platform-info` *(Admin)*
تحديث إعدادات المنصة.

---

#### `POST /api/admin/login-background` *(Admin)*
رفع خلفية صفحة تسجيل الدخول.

**Body:** `multipart/form-data` — حقل `background`

---

### 🔗 Webhook

#### `GET /api/webhook/settings`
إعدادات webhook المستخدم الحالي.

---

#### `PUT /api/webhook/url`
تحديث رابط الـ webhook.

**Body:** `{ "webhookUrl": "https://your-site.com/webhook" }`

---

#### `POST /api/webhook/regenerate-token`
إعادة توليد رمز الـ webhook.

---

#### `POST /api/webhook/test`
إرسال رسالة اختبار للـ webhook.

---

#### `GET /api/webhook/logs`
سجلات إرسال الـ webhook.

---

#### `POST /api/webhook/collect`
استقبال بيانات من webhook خارجي.

---

### 📋 السجلات والتدقيق

#### `GET /api/admin/reports/login-history` *(Admin)*
سجل جميع تسجيلات الدخول.

---

#### `GET /api/admin/logs/withdraw` *(Admin)*
سجلات السحب.

---

#### `GET /api/admin/logs/failed-logins` *(Admin)*
سجل محاولات الدخول الفاشلة.

---

#### `GET /api/audit-logs` *(Admin)*
سجل العمليات التدقيقية الكاملة.

---

### 🔃 طلبات الأرقام

#### `GET /api/number-requests`
طلبات الأرقام الخاصة بالمستخدم.

---

#### `POST /api/number-requests`
تقديم طلب أرقام جديدة.

**Body:** `{ "countryId": "uuid", "quantity": 10, "siteUrl": "https://..." }`

---

#### `PATCH /api/admin/number-requests/:id` *(Admin)*
مراجعة طلب الأرقام (قبول/رفض).

---

#### `GET /api/agent-requests`
طلبات الـ agent requests الخاصة.

---

#### `POST /api/agent-requests`
تقديم طلب ترقية لـ agent.

---

#### `PATCH /api/admin/agent-requests/:id` *(Admin/SubAdmin)*
مراجعة طلب الـ agent.

---

#### `POST /api/verify-agent-code`
التحقق من كود الـ agent.

**Body:** `{ "code": "AGENT001" }`

---

### 🗄️ قواعد البيانات الخارجية

#### `GET /api/external-db/connections` *(Admin)*
قائمة الاتصالات الخارجية.

---

#### `POST /api/external-db/connections` *(Admin)*
إضافة اتصال بقاعدة بيانات خارجية.

**Body:**
```json
{
  "name": "MySQL DB", "dbType": "mysql",
  "host": "db.example.com", "port": 3306,
  "database": "sms_db", "username": "root", "password": "pass"
}
```

---

#### `PUT /api/external-db/connections/:id` *(Admin)*
تعديل اتصال.

---

#### `DELETE /api/external-db/connections/:id` *(Admin)*
حذف اتصال.

---

#### `POST /api/external-db/connections/:id/test` *(Admin)*
اختبار الاتصال.

---

#### `POST /api/external-db/connections/:id/sync` *(Admin)*
مزامنة البيانات يدوياً.

---

#### `POST /api/external-db/connections/:id/fetch-numbers` *(Admin)*
جلب الأرقام من قاعدة البيانات الخارجية.

---

### 🌐 مصادر الأرقام (Sources)

#### `GET /api/sources`
قائمة المصادر.

---

#### `POST /api/admin/sources` *(Admin)*
إضافة مصدر جديد.

**Body:** `multipart/form-data` — اسم + صورة

---

#### `PATCH /api/admin/sources/:id` *(Admin)*
تعديل مصدر.

---

#### `DELETE /api/admin/sources/:id` *(Admin)*
حذف مصدر.

---

#### `PUT /api/admin/sources/:id/ranges` *(Admin)*
ربط مصدر بنطاقات.

**Body:** `{ "rangeIds": ["uuid1", "uuid2"] }`

---

### 🔧 أدوات الـ Admin الأخرى

#### `GET /api/admin/activation-codes` *(Admin)*
أكواد التفعيل.

---

#### `POST /api/admin/activation-codes` *(Admin)*
إنشاء كود تفعيل.

**Body:** `{ "name": "Ahmed Ali", "country": "Egypt", "email": "...", "whatsappNumber": "..." }`

---

#### `GET /api/admin/api-keys` *(Admin)*
مفاتيح API.

---

#### `POST /api/admin/api-keys` *(Admin)*
إنشاء مفتاح API.

---

#### `POST /api/admin/api-keys/:id/revoke` *(Admin)*
إلغاء مفتاح API.

---

#### `GET /api/admin/settings-summary` *(Admin)*
ملخص الإعدادات العامة.

---

#### `GET /api/admin/time-settings` *(Admin)*
إعدادات أوقات الإعادة التلقائية.

---

#### `PUT /api/admin/time-settings/:counterType` *(Admin)*
تعديل إعداد وقت معين.

---

#### `POST /api/admin/time-settings/:counterType/reset-now` *(Admin)*
إعادة ضبط عداد فوراً.

---

#### `POST /api/admin/backfill-ownership` *(Admin)*
إعادة حساب ملكية جميع الرسائل القديمة.

---

#### `GET /api/audit-logs` *(Admin)*
سجل التدقيق الكامل.

---

#### `GET /api/inactivity-notifications`
إشعارات عدم النشاط.

---

## ملاحظات أمنية مهمة

1. **سعر الـ Admin (`payout`) مخفي تماماً عن agents و clients:**
   - `/api/agent/sms-numbers` — يُرجع `agentPayout` فقط
   - `/api/client/my-numbers` — يُرجع `clientPayout` فقط
   - `/api/messages/cdr` — يُرجع للـ agent: `agentPayout` فقط

2. **المصادقة بالجلسات** — `HttpOnly` cookies مشفرة

3. **فصل الصلاحيات** — كل role له endpoints منفصلة

4. **IP Whitelisting** — متاح على مستوى SMPP providers و HTTP endpoints

5. **Rate Limiting** — على مستوى SMPP providers

---

*آخر تحديث: مارس 2026*
