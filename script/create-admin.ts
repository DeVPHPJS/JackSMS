import "dotenv/config";
import { db } from "../server/db";
import { users } from "../shared/schema";
import bcrypt from "bcryptjs";
import { eq } from "drizzle-orm";

const ADMIN_EMAIL = "admin@admin.com";
const ADMIN_USERNAME = "admin";
const ADMIN_PASSWORD = "Admin@123456";

async function createAdmin() {
  const existing = await db.select().from(users).where(eq(users.email, ADMIN_EMAIL));
  if (existing.length > 0) {
    console.log("Admin account already exists:", existing[0].email);
    process.exit(0);
  }

  const hashedPassword = await bcrypt.hash(ADMIN_PASSWORD, 10);

  const [admin] = await db.insert(users).values({
    firstName: "Admin",
    secondName: "System",
    email: ADMIN_EMAIL,
    username: ADMIN_USERNAME,
    password: hashedPassword,
    role: "admin",
    isActive: true,
    verified: true,
  }).returning();

  console.log("Admin account created successfully!");
  console.log("Email:", admin.email);
  console.log("Username:", admin.username);
  console.log("Password:", ADMIN_PASSWORD);
  console.log("Role:", admin.role);
  process.exit(0);
}

createAdmin().catch((err) => {
  console.error("Error creating admin:", err);
  process.exit(1);
});
