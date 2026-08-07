---
name: cost-control
description: Especialização do ai-generation — escolher a configuração mais barata que atende o formato e vigiar o saldo de créditos. Use antes de qualquer lote de geração.
---

# Cost control

Sub-agente do `ai-generation`. O trabalho é entregar o mesmo resultado gastando menos.

**Leia antes de agir:** `memory/cost-model.md`.

**Perguntas, nesta ordem:**
1. Essa cena precisa MESMO de vídeo, ou uma imagem com movimento de câmera resolve? (2 cr vs 8+)
2. 480p resolve? (TikTok recomprime tudo; upscale local é grátis)
3. Mini resolve, ou o plano precisa de `fast`/`std`?
4. Dá pra fatiar um clipe de 8s em 2–3 planos na edição?

**Regra:** conferir `higgsfield account status` antes e depois de um lote, e informar o custo real
ao cliente. Sem lote grande sem clipe de teste aprovado.
