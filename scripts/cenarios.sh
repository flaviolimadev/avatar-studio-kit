#!/usr/bin/env bash
# Gera cenários "gravando story" a partir das imagens do avatar.
#
# Uso:  ./scripts/cenarios.sh "<avatar>" carro banheiro rede sofa
#       ./scripts/cenarios.sh "<avatar>" --ancora cenarios/carro.png rede sofa
#
# A ÂNCORA é a regra que trava o rosto: gere UM cenário, mostre ao dono, e gere os outros
# passando o aprovado com --ancora. Sem isso o rosto muda entre cenários.
source "$(dirname "${BASH_SOURCE[0]}")/_comum.sh"
DIR=$(avatar_dir "$1"); shift
ANCORA=""
[ "${1:-}" = "--ancora" ] && { ANCORA="$DIR/$2"; shift 2; }

# bash 3.2 do macOS não tem array associativo — `case` funciona em qualquer versão
cena_de() {
  case "$1" in
    carro)    echo "in the driver seat of a parked car with the seatbelt across his chest over his t-shirt, car headrest and side window behind him, daylight through the windshield";;
    banheiro) echo "standing in a small home bathroom, white tiled wall and a hanging towel behind him, warm ceiling light";;
    rede)     echo "reclining in a fabric hammock on a shaded porch, woven hammock edge and rope beside him, wooden porch ceiling and green plants behind";;
    sofa)     echo "reclining against the backrest of a living room couch, cushions beside his head, a lit lamp and framed picture on the wall behind";;
    cozinha)  echo "standing in a home kitchen, cabinets and a countertop behind him, daylight from a window to the side";;
    rua)      echo "standing outdoors on a residential street, parked cars and houses blurred behind him, bright overcast daylight";;
    *)        echo "";;
  esac
}

QUEM="the exact same person as in the reference images: same face shape, same beard and hairline, same skin tone"
VESTE="fully dressed in a plain cotton t-shirt with sleeves, collar and shoulders visible, no bare skin on shoulders or chest"
POV="close selfie from their own phone front camera held at arm's length slightly above eye level, head upright facing the lens, face fills most of the vertical frame, mouth open mid-sentence talking"
NAO="no phone or device visible, no hand holding a phone, no mirror, no app interface, no buttons, no icons, no username, no text, no captions, no watermark, no logo"
LOOK="raw amateur smartphone front-camera photo, vertical, natural available light, slightly grainy, candid, not cinematic"

REFS=()
[ -n "$ANCORA" ] && REFS+=(--image-references "$ANCORA")     # aprovado primeiro: é o que manda
for f in "$DIR"/fotos_reais/*; do [ -f "$f" ] && REFS+=(--image-references "$f"); done
[ ${#REFS[@]} -gt 0 ] || { echo "sem fotos em $DIR/fotos_reais" >&2; exit 1; }

mkdir -p "$DIR/cenarios"
confirmar "$(( $# * 2 )) créditos ($# × 2)" "$# cenário(s) para $(basename "$DIR")"
for nome in "$@"; do
  desc=$(cena_de "$nome")
  [ -n "$desc" ] || { echo "cenário desconhecido: $nome (use: carro banheiro rede sofa cozinha rua)" >&2; continue; }
  echo "── $nome"
  url=$("$HF" generate create nano_banana_pro \
    --prompt "$QUEM. $VESTE. $POV. They are $desc. $LOOK. IMPORTANT: $NAO" \
    --aspect_ratio 9:16 --resolution 2k "${REFS[@]}" --wait --wait-timeout 8m 2>&1 | tail -1)
  case "$url" in http*) curl -s -o "$DIR/cenarios/$nome.png" "$url"; echo "   → cenarios/$nome.png";;
                     *) echo "   falhou: $url" >&2;; esac
done
saldo
