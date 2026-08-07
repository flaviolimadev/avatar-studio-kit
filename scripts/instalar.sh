#!/usr/bin/env bash
# Deixa esta máquina pronta para produzir: CLI do Higgsfield instalado E autenticado.
#
# Uso:  ./scripts/instalar.sh
#
# Por que existe: o `.env` sozinho NÃO autentica o Higgsfield. O CLI guarda a sessão em
# ~/.config/higgsfield/credentials.json e normalmente ela vem de um login pelo navegador
# (`higgsfield auth login`, OAuth PKCE). O `HIGGSFIELD_CREDENTIALS` do .env é exatamente o
# conteúdo desse arquivo — então dá para autenticar SEM navegador, escrevendo-o direto.
# É como o worker em contêiner faz.
set -euo pipefail
RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[ -f "$RAIZ/.env" ] || { echo "falta o .env em $RAIZ" >&2; exit 1; }
set -a; . "$RAIZ/.env"; set +a

echo "── 1/4 Node"
command -v node >/dev/null || { echo "instale Node 20+ primeiro" >&2; exit 1; }
node --version

echo "── 2/4 Higgsfield CLI"
if ! command -v higgsfield >/dev/null 2>&1 && [ ! -x "$HOME/.local/bin/higgsfield" ]; then
  npm config set prefix "$HOME/.local" >/dev/null
  npm install -g @higgsfield/cli
fi
export PATH="$HOME/.local/bin:$PATH"
RC="$HOME/.zshrc"; [ -n "${BASH_VERSION:-}" ] && [ -f "$HOME/.bashrc" ] && RC="$HOME/.bashrc"
grep -q '.local/bin' "$RC" 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$RC"
higgsfield --version 2>/dev/null || true

echo "── 3/4 autenticar sem navegador"
#
# ⚠️ NUNCA sobrescrever um credentials.json existente.
#
# O token do Higgsfield ROTACIONA: o CLI o renova sozinho e reescreve este arquivo, consumindo o
# refresh_token antigo. O `.env` guarda apenas uma FOTOGRAFIA. Escrever a fotografia por cima de uma
# sessão viva mata a sessão — o refresh antigo já foi usado e não vale mais. Aconteceu aqui: matei a
# autenticação da máquina e só se recuperou com `higgsfield auth login` pelo navegador.
#
# Então: a semente do .env serve para o PRIMEIRO login de uma máquina nova, e só.
mkdir -p "$HOME/.config/higgsfield"
CRED="$HOME/.config/higgsfield/credentials.json"
if [ -s "$CRED" ]; then
  echo "  já existe sessão local — preservada (não sobrescrevo token vivo)"
elif [ -n "${HIGGSFIELD_CREDENTIALS:-}" ]; then
  printf '%s' "$HIGGSFIELD_CREDENTIALS" > "$CRED"
  chmod 600 "$CRED"
  echo "  semente do .env gravada (primeiro login desta máquina)"
else
  echo "  sem semente no .env — será preciso: higgsfield auth login"
fi
if [ -n "${HIGGSFIELD_WORKSPACE:-}" ]; then
  printf '{"workspace_id":"%s"}' "$HIGGSFIELD_WORKSPACE" > "$HOME/.config/higgsfield/config.json"
  chmod 600 "$HOME/.config/higgsfield/config.json"
  echo "  workspace definido"
fi

echo "── 4/4 dependências dos scripts"
for b in ffmpeg uv; do
  command -v "$b" >/dev/null && echo "  $b ✓" || echo "  $b AUSENTE — instale (brew install $b)"
done

echo
echo "── prova real: o CLI responde autenticado? ──"
if higgsfield account status --json 2>/dev/null | grep -q credits; then
  higgsfield account status --json | python3 -c "import json,sys; print('  ✓ autenticado · saldo:', json.load(sys.stdin).get('credits'), 'créditos')"
else
  echo "  ✗ não autenticou."
  echo "    A semente do .env é uma fotografia e pode já ter sido consumida por outra máquina."
  echo "    Conserto: higgsfield auth login   (abre o navegador, uma vez por máquina)"
fi
