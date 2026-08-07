---
name: auto-loop-hooks
description: O loop de manutenção é AUTOMÁTICO — três hooks do harness carregam a memória, relembram o loop e barram o encerramento com desvio
metadata:
  type: feedback
---

O cliente pediu (2026-07-25) que atualizar agentes e alimentar a memória aconteça **sozinho a cada
mensagem**, sem depender de lembrança. Como quem executa hook é o harness (não o assistente), isso
virou configuração em `.claude/settings.json`:

| Hook | Script | O que faz |
|---|---|---|
| `SessionStart` | `.claude/hooks/mind-load.sh` | injeta `memory/MEMORY.md` inteiro + os donos por domínio, uma vez por sessão; avisa se a sessão anterior deixou desvio |
| `UserPromptSubmit` | `.claude/hooks/mind-remind.sh` | a CADA mensagem, injeta o loop obrigatório: carregar memória antes, e depois de entregar → memória nova, agente/sub-agente novo se houver domínio sem dono, `log.mjs`, `check.mjs` |
| `Stop` | `.claude/hooks/mind-verify.sh` | roda `check.mjs` antes de encerrar o turno; **com desvio devolve exit 2** e o assistente continua até consertar |

**Por quê a divisão:** o conteúdo pesado (índice de memória) entra uma vez no SessionStart; o
lembrete do UserPromptSubmit é curto de propósito, pra não inflar o contexto a cada mensagem.

**Proteção anti-laço:** o `Stop` lê `stop_hook_active` do payload — na segunda passada ele sai com 0
em vez de bloquear de novo, então nunca entra em loop infinito.

**Testado em 2026-07-25:** com desvio proposital o Stop devolveu exit 2 listando os desvios; com
`stop_hook_active:true` devolveu 0. Ver [[the-loop]], [[the-check]], [[how-it-works]].
