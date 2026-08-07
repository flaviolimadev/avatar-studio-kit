---
name: the-loop
description: O loop de auto-aprendizado — toda entrega passa por memória, agentes e verificação
metadata:
  type: reference
---

**Este ciclo não depende de lembrança: ele é disparado pelos hooks do harness** — ver
[[auto-loop-hooks]]. O ciclo padrão de um job de vídeo aqui:

1. **Carregar** — o `librarian` lê `MEMORY.md` e traz os fatos relevantes (formato, presets, custos).
2. **Fazer** — o agente de domínio executa a etapa do pipeline.
3. **Destilar** — o que foi aprendido e se perderia entre sessões vira memória (um fato, um arquivo).
4. **Registrar** — `node scripts/log.mjs <agente> <tipo> "<resumo>"` alimenta o histórico do grafo.
5. **Verificar** — `node scripts/check.mjs` tem que fechar zerado.

Gatilhos de memória neste projeto: preset travado num valor, armadilha que queimou crédito ou tempo,
decisão de formato do cliente, custo real medido. Ver [[the-check]] e [[memory-format]].
