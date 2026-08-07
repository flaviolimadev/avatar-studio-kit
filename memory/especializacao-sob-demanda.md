---
name: especializacao-sob-demanda
description: Recorte novo cria especialista novo — o sistema ganha agentes conforme encontra trabalho que ninguém domina
metadata:
  type: feedback
---

Regra dada pelo cliente em 2026-07-25, com o exemplo dele: existe um dono de roteiro
(`screenwriter`); chega um pedido de **roteiro de novela de amor**; o sistema verifica se há
roteirista especialista em romance — **se não houver, cria** — e só então escreve.

**Vale para tudo, não só roteiro:** um estilo visual novo cria um sub de prompt de imagem; um
provedor de geração novo cria um domínio; um formato novo cria um especialista de formato.

**Como criar (o `maestro` executa, o `dispatcher` aciona):**
1. Entrada em `catalog.json` com **função única** e `parent` correto (especialista nasce `sub`).
2. Arquivo `.claude/agents/<key>.md` com: função única, o que ler antes, regras duras e o que está
   fora do escopo.
3. Ligar a memória relevante em `memory[]`.
4. `node scripts/check.mjs` tem que fechar zerado; o sync leva ao banco no fim do turno.

**Critério para NÃO criar:** se o recorte é usado uma vez só e não tem regra própria, ele é
parâmetro — não agente. Especialista existe quando há **conhecimento reaproveitável** naquele recorte.

**Nomenclatura:** `<dominio>-<recorte>` (ex.: `screenwriter-romance`, `image-prompt-3d`).

Ver [[roteamento-de-tarefas]], [[how-it-works]].
