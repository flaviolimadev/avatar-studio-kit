#!/usr/bin/env node
/**
 * Registra uma atividade em memory/.activity.jsonl — alimenta o histórico/crescimento no grafo.
 * Uso: node scripts/log.mjs <agente> <tipo> "<resumo>"
 * Ex.:  node scripts/log.mjs ai-generation gerou "cenário carro do avatar Fulano"
 * Pode ser chamado por um git hook (.githooks/post-commit) pra registrar cada commit sozinho.
 *
 * Aqui NÃO há banco: o ledger é este arquivo .jsonl. É a mesma ideia da memória — o conhecimento
 * (e agora o histórico) vive em ARQUIVO versionado, não num Postgres. Ver memory/the-loop.md.
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const [, , agent, type, ...rest] = process.argv;
const summary = rest.join(' ').trim();
if (!agent || !type || !summary) {
  console.error('uso: node scripts/log.mjs <agente> <tipo> "<resumo>"');
  process.exit(0);
}
const root = path.join(path.dirname(fileURLToPath(import.meta.url)), '..');
const file = path.join(root, 'memory', '.activity.jsonl');
const line = JSON.stringify({ at: new Date().toISOString(), agent, type, summary }) + '\n';
fs.appendFileSync(file, line);
console.log(`registrado: ${agent} · ${type} · ${summary}`);
