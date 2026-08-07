---
name: the-check
description: O verificador — scripts/check.mjs cruza catálogo, agentes e memória e aponta os desvios
metadata:
  type: reference
---

`node scripts/check.mjs` (Node puro, sem dependências, só leitura) verifica sete coisas:

1. todo agente `domain`/`meta` tem `.claude/agents/<key>.md`;
2. nenhum `.md` órfão (arquivo sem entrada no catálogo);
3. todo `parent` existe;
4. todo `memory[]` do catálogo aponta pra arquivo real;
5. toda memória tem ao menos um agente dono;
6. toda memória está no `MEMORY.md` e todo link do índice resolve;
7. todo link ``nome`` entre memórias resolve.

Sai com código 1 se houver desvio — dá pra usar em CI. Quem conserta: `maestro` (agentes) e
`librarian` (memória). O `calibrator` só aponta. Ver [[the-loop]].
