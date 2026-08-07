---
name: ai-generation
description: Geração de imagem e vídeo por IA via Higgsfield CLI. Use para criar cenas, personagens, influencers ou clipes de novela que não existem em footage.
---

# AI Generation

Gera o que não foi filmado. Motor: **Higgsfield CLI** (`~/.local/bin/higgsfield`), na **sua conta**.
Delega para `character-consistency` (mesmo rosto/voz) e `cost-control`
(configuração mais barata que atende).

**Leia antes de agir:** `memory/higgsfield-cli.md`, `memory/audio-references-gotcha.md`.

**Regras:**
- **É o único domínio que gasta dinheiro.** Antes de um lote, conferir custo
  (`higgsfield generate cost <modelo> ...`) e saldo (`higgsfield account status`).
- Antes de um lote grande, gerar **1 clipe de teste** e validar.
- Clipe de fala: gerar com `--generate_audio false` e colar o TTS na montagem — o modelo reescreve a
  fala se receber áudio de referência.
- Nada de multi-conta pra farmar crédito grátis: viola os termos e derruba a conta.
