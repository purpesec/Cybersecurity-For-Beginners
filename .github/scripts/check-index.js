#!/usr/bin/env node
"use strict";

const fs = require("fs");
const path = require("path");

const POSTS_BASE_URL = "https://purpesec.github.io/blog/posts";

const CATEGORY_TO_DIR = {
  fundamentos: "fundamentos",
  "red team operations": "red-team-operations",
  "blue team operations": "blue-team-operations",
  "analisis de malware": "analisis-de-malware",
  writeups: "writeups",
  laboratorios: "labs",
};

const INDEX_DIRS = [
  "fundamentos",
  "red-team-operations",
  "blue-team-operations",
  "analisis-de-malware",
  "writeups",
  "labs",
];

function normalize(value) {
  return value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/\s+/g, " ")
    .trim();
}

function parseFrontMatter(text) {
  const match = text.match(/^---\r?\n([\s\S]*?)\r?\n---/);
  if (!match) return {};

  const block = match[1];
  const result = {};

  const title = block.match(/^title:\s*(.+?)\s*$/m);
  if (title) {
    result.title = title[1].replace(/^["']|["']$/g, "").trim();
  }

  const inline = block.match(/^categories:\s*\[(.*)\]\s*$/m);
  if (inline) {
    result.categories = inline[1]
      .split(",")
      .map((item) => item.trim().replace(/^["']|["']$/g, ""))
      .filter(Boolean);
  } else {
    const start = block.match(/^categories:\s*$/m);
    if (start) {
      const rest = block.slice(block.indexOf(start[0]) + start[0].length);
      const items = [];
      for (const line of rest.split(/\r?\n/)) {
        const item = line.match(/^\s*-\s*(.+?)\s*$/);
        if (!item) break;
        items.push(item[1].replace(/^["']|["']$/g, ""));
      }
      result.categories = items;
    }
  }

  return result;
}

function postSlug(filename) {
  const match = filename.match(/^\d{4}-\d{2}-\d{2}-(.+)\.(md|markdown)$/i);
  return match ? match[1] : null;
}

function indexDir(categories) {
  for (const category of categories) {
    const key = normalize(category);
    if (key === "learning") continue;
    if (CATEGORY_TO_DIR[key]) return CATEGORY_TO_DIR[key];
  }
  return null;
}

const postsDir = process.argv[2] || path.join("..", "blog", "_posts");
if (!fs.existsSync(postsDir)) {
  console.error(`No existe el directorio de posts: ${postsDir}`);
  process.exit(2);
}

const posts = [];
for (const filename of fs.readdirSync(postsDir).sort()) {
  const slug = postSlug(filename);
  if (!slug) continue;
  const front = parseFrontMatter(fs.readFileSync(path.join(postsDir, filename), "utf8"));
  const categories = front.categories || [];
  posts.push({
    filename,
    slug,
    title: front.title || slug,
    categories,
    dir: indexDir(categories),
  });
}

const knownSlugs = new Set(posts.map((post) => post.slug));
const missing = [];
const unknown = [];

for (const post of posts) {
  if (!post.dir) {
    unknown.push(post);
    continue;
  }

  const indexPath = path.join(post.dir, "README.md");
  if (!fs.existsSync(indexPath)) {
    missing.push({ ...post, reason: "no existe el README del área" });
    continue;
  }

  if (!fs.readFileSync(indexPath, "utf8").includes(post.slug)) {
    missing.push({ ...post, reason: "el tema no está listado" });
  }
}

const stale = [];
for (const dir of INDEX_DIRS) {
  const indexPath = path.join(dir, "README.md");
  if (!fs.existsSync(indexPath)) continue;

  const content = fs.readFileSync(indexPath, "utf8");
  for (const match of content.matchAll(/https:\/\/purpesec\.github\.io\/blog\/posts\/([^/)\s]+)\/?/g)) {
    if (!knownSlugs.has(match[1])) {
      stale.push({ dir, slug: match[1] });
    }
  }
}

console.log(`Posts revisados: ${posts.length}`);
console.log(`Índices revisados: ${INDEX_DIRS.length}`);

if (missing.length) {
  console.log(`\nTEMAS SIN LISTAR (${missing.length}):`);
  for (const item of missing) {
    console.log(
      `  - ${item.dir}/README.md: "${item.title}" (${POSTS_BASE_URL}/${item.slug}/) — ${item.reason}`,
    );
  }
}

if (unknown.length) {
  console.log(`\nPOSTS CON CATEGORÍA NO RECONOCIDA (${unknown.length}):`);
  for (const item of unknown) {
    console.log(`  - ${item.filename}: categorías [${item.categories.join(", ")}]`);
  }
}

if (stale.length) {
  console.log(`\nENLACES OBSOLETOS (${stale.length}):`);
  for (const item of stale) {
    console.log(`  - ${item.dir}/README.md -> ${POSTS_BASE_URL}/${item.slug}/`);
  }
}

const problems = missing.length + unknown.length + stale.length;
if (problems) {
  console.log(`\nResultado: ${problems} problema(s).`);
  process.exit(1);
}

console.log("\nResultado: todos los posts del blog están listados en su índice.");
