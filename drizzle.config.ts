import { defineConfig } from "drizzle-kit";

const url = process.env.DATABASE_URL || process.env.SUPABASE_URL;

if (!url) {
  throw new Error("DATABASE_URL or SUPABASE_URL must be set");
}

const isSupabase = url.includes("supabase");

export default defineConfig({
  out: "./migrations",
  schema: "./shared/schema.ts",
  dialect: "postgresql",
  dbCredentials: {
    url,
    ssl: isSupabase ? { rejectUnauthorized: false } : false,
  },
});
