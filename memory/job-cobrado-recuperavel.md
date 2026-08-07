---
name: job-cobrado-recuperavel
description: video.sh --wait pode desistir enquanto o job segue renderizando no Higgsfield — e ele JÁ foi cobrado; recupere pelo job_id, não re-gere
metadata:
  type: reference
---

O `--wait` do `video.sh` (seedance) pode retornar sem a URL enquanto o job **continua renderizando
no servidor** — e o crédito **é debitado no `create`, não no download**. Aconteceu num lote de 4
takes (2026-08-07): o take 4 saiu como "falhou", mas o saldo tinha caído os 16,5 créditos dele.

**Não re-gere (não re-pague).** O job é recuperável pelo id:
- `higgsfield generate list` → acha o job mais recente (`in_progress`/`completed`);
- `higgsfield generate get <id> --json` → campos `result_url` / `min_result_url`;
- `higgsfield generate wait <id>` → bloqueia até terminar (**sem** `--wait-timeout`; esse flag é só do `create`);
- `curl -o <destino> "<result_url>"` → baixa o que já foi pago.

**How to apply (driver de lote):** capture o `job_id` do `create` de cada take; se o download falhar,
recupere por id em vez de marcar o take como perdido. Um "falhou" no script não significa crédito
não gasto — confira o saldo antes de concluir que nada saiu. Ver [[higgsfield-cli]], [[cost-model]].
