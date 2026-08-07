#!/usr/bin/env bash
# Gera o vídeo falado a partir de um cenário aprovado. Áudio NATIVO — sem TTS colado por cima.
#
# Uso:  ./scripts/video.sh "<avatar>" <cenario> <segundos> "<fala>" [--720p] [--lendo]
#
#   --lendo  monta o formato "lendo um comentário e respondendo", com os beats já calibrados
#            (leitura → aperta os olhos e aproxima o celular → levanta o olhar → responde)
source "$(dirname "${BASH_SOURCE[0]}")/_comum.sh"
DIR=$(avatar_dir "$1"); CENARIO="$2"; SEG="$3"; FALA="$4"; shift 4
RES=480p; MODO=fast; LENDO=""
for a in "$@"; do case "$a" in --720p) RES=720p;; --std) MODO=std;; --lendo) LENDO=1;; esac; done
IMG="$DIR/cenarios/$CENARIO.png"
[ -f "$IMG" ] || { echo "cenário não existe: $IMG" >&2; exit 1; }

# As microexpressões moram DENTRO de cada beat — instrução genérica só age onde há verbo.
VIVO="Nothing about their face is ever frozen: eyebrows, forehead and cheeks in constant subtle motion in every beat. They blink several times. Between phrases the mouth closes completely and the chest rises with a breath. Gaze breaks away from the lens briefly and returns."
if [ -n "$LENDO" ]; then
  M=$(( SEG / 3 ))
  BEATS="BEAT TIMING — 0 to ${M}s READING: eyes lowered to the phone, tracking left to right, blinking as they jump back to the start of the next line; eyebrows lift then draw into a concentration frown, forehead creasing and releasing; lips silently mouth a word. ${M} to $((M*2))s: they SQUINT, narrowing their eyes, and BRING THE PHONE CLOSER to their face to make out the text, tilting the head back, chin lifting; then eyebrows shoot UP in surprise and one corner of the mouth pulls into a half-smile of disbelief, and the phone drifts back. $((M*2)) to ${SEG}s ANSWERING to the lens: exhales through the nose, raises their eyes to the lens, eyebrows moving with the emphasis of each phrase, forehead creasing on stressed words, one hand gesture. The arm holding the phone moves, so the framing shifts naturally."
else
  BEATS="BEAT TIMING — They speak straight into the lens the whole time, pausing between phrases, with one hand gesture near the end."
fi
PROMPT="The person in the reference image is filming themselves on their phone. Casual brazilian portuguese, relaxed and spontaneous, they say: \"$FALA\". $BEATS $VIVO Raw amateur front-camera video, natural light, handheld with slight shake, not cinematic, no slow motion. No text, no captions, no watermark, no interface."

CUSTO=$("$HF" generate cost seedance_2_0 --prompt "x" --image-references "$IMG" \
        --duration "$SEG" --resolution "$RES" --mode "$MODO" --aspect_ratio 9:16 2>&1 | tail -1)
confirmar "$CUSTO" "vídeo de ${SEG}s em $RES/$MODO · cenário $CENARIO"
mkdir -p "$DIR/videos"
SAIDA="$DIR/videos/$(date +%Y%m%d-%H%M%S)-$CENARIO.mp4"
url=$("$HF" generate create seedance_2_0 --prompt "$PROMPT" --image-references "$IMG" \
      --duration "$SEG" --resolution "$RES" --mode "$MODO" --aspect_ratio 9:16 \
      --wait --wait-timeout 20m 2>&1 | tail -1)
case "$url" in http*) curl -s -o "$SAIDA" "$url"; echo "→ $SAIDA";;
                   *) echo "falhou: $url" >&2; exit 1;; esac
printf '%s\n' "$PROMPT" > "${SAIDA%.mp4}.prompt.txt"
echo
echo "CONFIRA ANTES DE APROVAR (a verificação é visual, não automática):"
echo "  uv run workflows/tira-do-rosto.py \"$SAIDA\" --regiao sobrancelha --de 0 --ate $(( SEG/2 ))"
echo "  uv run workflows/tira-do-rosto.py \"$SAIDA\" --regiao olhos --de $(( SEG/2 )) --ate $SEG"
saldo
