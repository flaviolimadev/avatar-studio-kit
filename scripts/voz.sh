#!/usr/bin/env bash
# Escolhe ou clona a voz do avatar.
#
#   ./scripts/voz.sh "<avatar>" --testar            # 4 vozes preset + a nativa pt lendo a mesma frase
#   ./scripts/voz.sh "<avatar>" --clonar <audio>    # usa uma voz de referência (áudio) como base
#
# ⚠️ Antes de clonar, TRANSCREVA o áudio e confirme de quem é a voz. Um arquivo já chegou aqui
#    como "vídeo dele" e era de outra pessoa — clonar teria posto palavras na boca de um terceiro.
source "$(dirname "${BASH_SOURCE[0]}")/_comum.sh"
DIR=$(avatar_dir "$1"); ACAO="${2:---testar}"; ARG="${3:-}"
mkdir -p "$DIR/vozes"

# escrita COMO SE FALA: reticências, interjeição e repetição viram respiração (3 → 9 pausas medidas)
FRASE="Fala galera... beleza? Ó, passando rapidinho aqui, rapidinho mesmo, só pra dar um oi pra vocês. E qualquer dúvida — qualquer dúvida mesmo — chama no privado que eu respondo, tá? Valeu!"

if [ "$ACAO" = "--testar" ]; then
  confirmar "~2,9 créditos (4 × 0,3 + 1 nativa × 2)" "amostras de voz para $(basename "$DIR")"
  # pares nome:id — array associativo não existe no bash 3.2 do macOS
  for par in roman:7e63ac18-5fcd-4aba-8078-a86d4e11c127 julian:95429266-c0ac-4137-a209-63b8812b0f23 \
             xavier:43173c95-3ec8-446a-a162-6504332c578b marcus:6f98d3dd-324f-4845-8c28-c1d1647a06cd; do
    n="${par%%:*}"; vid="${par#*:}"
    u=$("$HF" generate create text2speech_v2 --variant elevenlabs --voice_id "$vid" \
        --voice_type preset --prompt "$FRASE" --wait --wait-timeout 5m 2>&1 | tail -1)
    case "$u" in http*) curl -s -o "$DIR/vozes/$n.mp3" "$u"; echo "  → vozes/$n.mp3";; esac
  done
  # Heitor é voz NATIVA em português; as preset acima são vozes inglesas lendo pt
  u=$("$HF" generate create inworld_text_to_speech --voice "Heitor (pt)" --prompt "$FRASE" \
      --wait --wait-timeout 5m 2>&1 | tail -1)
  case "$u" in http*) curl -s -o "$DIR/vozes/heitor-nativa-pt.mp3" "$u"; echo "  → vozes/heitor-nativa-pt.mp3";; esac
  echo; echo "Ouça e escolha. A nativa pt costuma soar melhor que as preset."

elif [ "$ACAO" = "--clonar" ]; then
  [ -f "$ARG" ] || { echo "áudio não encontrado: $ARG" >&2; exit 1; }
  echo "⚠️  Se esta voz for de uma pessoa real, confirme que você tem o consentimento dela."
  confirmar "0,3 crédito" "fala de teste com a voz clonada de $(basename "$ARG")"
  u=$("$HF" generate create seed_audio --prompt "$FRASE" --audio-references "$ARG" \
      --wait --wait-timeout 8m 2>&1 | tail -1)
  case "$u" in http*) curl -s -o "$DIR/vozes/clonada.mp3" "$u"; echo "→ vozes/clonada.mp3";;
                   *) echo "falhou: $u" >&2;; esac
else echo "uso: voz.sh \"<avatar>\" --testar | --clonar <audio>" >&2; exit 1; fi
saldo
