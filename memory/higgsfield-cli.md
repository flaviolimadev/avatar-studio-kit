---
name: higgsfield-cli
description: O motor de geração por IA — CLI do Higgsfield instalada, autenticada e com workspace fixado
metadata:
  type: reference
---

Instalação nesta máquina (não havia permissão para `npm -g` no prefixo padrão):

```bash
npm i -g --prefix "$HOME/.local" @higgsfield/cli     # binário em ~/.local/bin/higgsfield
higgsfield auth login                                 # OAuth no navegador
higgsfield workspace set <workspace_id>               # obrigatório: sem isso account status falha
```

Conta: **a sua** (crie em higgsfield.ai). O plano define o saldo de créditos/mês e quantas gerações
em paralelo — confira com `higgsfield account status`. O preço por crédito sai do seu plano.
Workspace: rode `higgsfield workspace set <seu_workspace_id>` uma vez (sem isso o `account status` falha).

Comandos do dia a dia:
- `higgsfield account status` — saldo
- `higgsfield model get <job_type>` — parâmetros aceitos
- `higgsfield generate cost <job_type> [--param ...]` — custo ANTES de gerar
- `higgsfield generate create <job_type> --prompt "..." --wait --wait-timeout 12m` — gera e espera

**Armadilha do login:** o navegador embutido bloqueia URL de localhost. Rodar o login sob um pty
(`script -q log.txt higgsfield auth login`) e passar a URL de OAuth ao cliente abrir no navegador dele.

**Modelos unlimited/grátis do plano NÃO valem via CLI/MCP** — só pelo site. Pela CLI tudo consome
crédito. Multi-conta pra farmar crédito grátis viola os termos.

Ver [[cost-model]], [[audio-references-gotcha]], [[character-anchors]].
