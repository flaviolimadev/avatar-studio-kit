---
name: how-it-works
description: A estrutura em uma página — catálogo → agentes → memória → verificador → grafo
metadata:
  type: reference
---

Cinco peças, nesta ordem de autoridade:

1. **`catalog.json`** — fonte única. Todo agente existe aqui primeiro (`key`, `type`, `parent`,
   `description`, `memory[]`). Tipos: `meta` (governam a estrutura), `domain` (dono de uma etapa do
   pipeline), `sub` (especialização de um domain).
2. **`.claude/agents/<key>.md`** — o agente de verdade: o que faz, o que ler antes, suas regras.
   Catálogo e arquivo andam juntos; um sem o outro é desvio.
3. **`memory/`** — um arquivo = um fato. É o que sobrevive entre sessões. Índice em `MEMORY.md`.
4. **`scripts/check.mjs`** — cruza os três e aponta desvios. Só lê.
5. **`viewer/`** — o grafo ao vivo (`node viewer/server.mjs`), mostra agentes, memórias e atividade.

Neste projeto os domínios espelham o pipeline do `CLAUDE.md` (`rough-cut` → `graphics` → `captions`
→ `audio` → `export`), mais os dois que nasceram da fábrica de conteúdo IA: `ai-generation`
(gera o que não foi filmado) e `formats` (direção criativa dos modelos M1–M8).

Ver também [[the-loop]] e [[the-check]].
