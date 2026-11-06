#!/usr/bin/env node
"use strict";

const fs = require("fs");
const path = require("path");

const POSTS_BASE_URL = "https://purpesec.github.io/blog/posts";
const DEFAULT_SOURCE = "https://purpesec.github.io/blog/assets/js/data/search.json";

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

// El catálogo raíz repite la lista de temas, así que también se comprueba.
const INDEX_FILES = ["README.md", ...INDEX_DIRS.map((dir) => `${dir}/README.md`)];

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

function slugFromUrl(url) {
  const clean = String(url).replace(/[?#].*$/, "").replace(/\/+$/, "");
  const slug = clean.slice(clean.lastIndexOf("/") + 1);
  return slug ? decodeURIComponent(slug) : null;
}

function splitCategories(value) {
  if (Array.isArray(value)) {
    return value.map((item) => String(item).trim()).filter(Boolean);
  }
  return String(value || "")
    .split(",")
    .map((item) => item.trim().replace(/^["']|["']$/g, ""))
    .filter(Boolean);
}

function indexDir(categories) {
  for (const category of categories) {
    const key = normalize(category);
    if (key === "learning") continue;
    if (CATEGORY_TO_DIR[key]) return CATEGORY_TO_DIR[key];
  }
  return null;
}

function readIndex(file) {
  return fs.existsSync(file) ? fs.readFileSync(file, "utf8") : null;
}

async function loadPosts(source) {
  if (/^https?:\/\//.test(source)) {
    const response = await fetch(source);
    if (!response.ok) {
      throw new Error(`No se pudo leer el índice del blog (${response.status}): ${source}`);
    }

    return (await response.json())
      .map((entry) => ({
        slug: slugFromUrl(entry.url),
        title: entry.title || entry.url,
        categories: splitCategories(entry.categories),
      }))
      .filter((post) => post.slug);
  }

  if (!fs.existsSync(source)) {
    throw new Error(`No existe el directorio de posts: ${source}`);
  }

  const posts = [];
  for (const filename of fs.readdirSync(source).sort()) {
    const slug = postSlug(filename);
    if (!slug) continue;
    const front = parseFrontMatter(fs.readFileSync(path.join(source, filename), "utf8"));
    posts.push({
      slug,
      title: front.title || slug,
      categories: front.categories || [],
    });
  }
  return posts;
}

async function main() {
  const source = process.argv[2] || DEFAULT_SOURCE;
  const posts = await loadPosts(source);
  const knownSlugs = new Set(posts.map((post) => post.slug));

  const missing = [];
  const unknown = [];

  for (const post of posts) {
    const dir = indexDir(post.categories);

    // Cada tema debe estar en el catálogo raíz y en el índice de su área.
    const files = ["README.md"];
    if (dir) files.push(`${dir}/README.md`);

    for (const file of files) {
      const content = readIndex(file);
      if (content === null) {
        missing.push({ ...post, where: file, reason: "no existe el README" });
      } else if (!content.includes(post.slug)) {
        missing.push({ ...post, where: file, reason: "el tema no está listado" });
      }
    }

    if (!dir) unknown.push(post);
  }

  const stale = [];
  for (const file of INDEX_FILES) {
    const content = readIndex(file);
    if (content === null) continue;

    for (const match of content.matchAll(/https:\/\/purpesec\.github\.io\/blog\/posts\/([^/)\s]+)\/?/g)) {
      if (!knownSlugs.has(match[1])) {
        stale.push({ where: file, slug: match[1] });
      }
    }
  }

  console.log(`Posts revisados: ${posts.length}`);
  console.log(`Índices revisados: ${INDEX_FILES.length}`);

  if (missing.length) {
    console.log(`\nTEMAS SIN LISTAR (${missing.length}):`);
    for (const item of missing) {
      console.log(
        `  - ${item.where}: "${item.title}" (${POSTS_BASE_URL}/${item.slug}/) — ${item.reason}`,
      );
    }
  }

  if (unknown.length) {
    console.log(`\nPOSTS CON CATEGORÍA NO RECONOCIDA (${unknown.length}):`);
    for (const item of unknown) {
      console.log(`  - ${item.slug}: categorías [${item.categories.join(", ")}]`);
    }
  }

  if (stale.length) {
    console.log(`\nENLACES OBSOLETOS (${stale.length}):`);
    for (const item of stale) {
      console.log(`  - ${item.where} -> ${POSTS_BASE_URL}/${item.slug}/`);
    }
  }

  const problems = missing.length + unknown.length + stale.length;
  if (problems) {
    console.log(`\nResultado: ${problems} problema(s).`);
    process.exit(1);
  }

  console.log("\nResultado: todos los posts del blog están listados en su índice.");
}

main().catch((error) => {
  console.error(error.message);
  console.error("Para trabajar sin conexión: node .github/scripts/check-index.js ../blog/_posts");
  process.exit(2);
});
