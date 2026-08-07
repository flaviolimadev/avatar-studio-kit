#!/usr/bin/env bash
# Trechos compartilhados pelos três passos. Nada aqui gasta crédito sozinho.
set -euo pipefail
RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# O .env precisa entrar no ambiente — sem isto os scripts rodavam sem credencial nenhuma
# e só descobriam no erro do CLI.
[ -f "$RAIZ/.env" ] && set -a && . "$RAIZ/.env" && set +a

HF="${HIGGSFIELD_BIN:-$HOME/.local/bin/higgsfield}"
[ -x "$HF" ] || HF=higgsfield
command -v "$HF" >/dev/null 2>&1 || { echo "Higgsfield CLI não encontrado. Rode ./scripts/instalar.sh" >&2; exit 1; }

avatar_dir() {                       # aceita "<seu-avatar>" ou só "fulano"
  local q="$1" achado
  achado=$(find "$RAIZ/avatares" -maxdepth 1 -type d -iname "*${q}*" ! -name "_MODELO" | head -1)
  [ -n "$achado" ] || { echo "avatar não encontrado: $q" >&2; exit 1; }
  echo "$achado"
}

# Pergunta o custo ANTES de gerar e exige confirmação — crédito gasto não volta.
# DRY=1 mostra o que faria e para — dá para conferir prompt e custo sem gastar.
confirmar() {
  local custo="$1" oque="$2"
  echo "→ $oque"
  echo "  custo: $custo"
  [ "${DRY:-}" = "1" ] && { echo "  (DRY=1 — nada foi gerado)"; exit 0; }
  [ "${SIM:-}" = "1" ] && return 0
  read -rp "  gerar? [s/N] " r
  [ "$r" = "s" ] || { echo "  cancelado"; exit 0; }
}

saldo() { "$HF" account status --json 2>/dev/null | /usr/bin/python3 -c \
  "import json,sys; print('saldo:', json.load(sys.stdin).get('credits'))"; }
