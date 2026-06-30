import * as esbuild from "esbuild";
import { execSync } from "child_process";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, "..");

execSync("npx vite build", { stdio: "inherit" });

await esbuild.build({
  entryPoints: [path.join(root, "client/server/index.ts")],
  outfile: path.join(root, "dist/index.cjs"),
  platform: "node",
  format: "cjs",
  bundle: true,
  banner: {
    js: `const __importMetaUrl = typeof __filename !== "undefined" ? require("url").pathToFileURL(__filename).href : undefined;`,
  },
  define: {
    "import.meta.url": "__importMetaUrl",
    "import.meta.dirname": "__dirname",
  },
  // Resolve tsconfig path aliases (@shared/*, @/*, etc.)
  alias: {
    "@shared": path.join(root, "shared"),
    "@": path.join(root, "client/src"),
    "@assets": path.join(root, "attached_assets"),
  },
  external: [
    "pg-native",
    "better-sqlite3",
    "mysql2",
    "@libsql/client",
    "esbuild",
    "lightningcss",
    "smpp",
    "dotenv",
  ],
  plugins: [
    {
      name: "exclude-vite-dev",
      setup(build) {
        build.onResolve({ filter: /^\.\/vite$/ }, () => {
          return {
            path: "vite-dev-stub",
            namespace: "vite-stub",
          };
        });
        build.onLoad({ filter: /.*/, namespace: "vite-stub" }, () => {
          return {
            contents: `export function setupVite() { throw new Error("Vite dev server not available in production"); }`,
            loader: "js",
          };
        });
      },
    },
  ],
  logLevel: "info",
});
