---
name: influencer-falando
description: Vídeo com a influencer FALANDO (lip-sync) — motor wan2_7, o still que carrega o produto, e as quatro armadilhas
metadata:
  type: reference
---

Construído em 2026-07-28 a pedido do cliente: *"crie uma versão onde a influencer fala apresentando
o produto, não um vídeo narrado"*. Virou o formato **M14 · Influencer falando**, dono
`talking-avatar` (agente).

## O motor: `wan2_7`, não o seedance

| | seedance (narrado) | **wan2_7 (falado)** |
|---|---|---|
| áudio devolvido | **re-sintetizado**, troca as palavras ([[audio-references-gotcha]]) | **o nosso**, alinhado no zero (correlação 1,0 medida) |
| referências | até 9 imagens | **só `start_image`** — uma imagem |
| custo 5 s | 12,5 cr | 7,5 cr (720p) · 12,5 cr (1080p) |

**`wan2_7` não tem lista de referências.** Tudo o que precisa aparecer no clipe — a influencer E o
produto — tem que já estar no `start_image`. Por isso cada cena é **duas etapas**: um still
(`nano_banana_pro` com a âncora de rosto + a foto do produto, 2 cr) e depois o clipe guiado pela voz.

## As quatro armadilhas, todas medidas

1. **O prompt PRECISA dizer que ela fala.** Com o prompt da cena sozinho ("selfie, thoughtful
   expression") o clipe voltou com o áudio certo e a **boca praticamente parada** — o modelo animou
   alguém em silêncio ouvindo a própria voz. O sufixo `she is speaking to the camera, lips moving
   naturally in sync with her speech` resolveu.
2. **Nada de montagem viral.** Ela reaproveita o clipe de uma fala para cobrir outra e corta a cena
   em vários planos — com boca sincronizada, isso põe a pessoa articulando uma frase enquanto se
   ouve outra. Um clipe por fala, na ordem, e **toda cena precisa de prompt** (prompt vazio = reuso).
3. **`GAP` e cartão de abertura zerados.** A boca foi gerada a partir do áudio começando no quadro
   zero: os 0,175 s de respiro desencontram, e os 1,5 s mudos do cartão põem silêncio antes do
   gancho. No falado, `produce.py` zera os dois e a cena dura **exatamente o clipe**.
4. **O clipe volta mais longo que a fala.** A folga que garante a frase inteira vira ~1 s de
   silêncio por plano — 6 s num vídeo de 37 s. Corta-se em `fala + 0,3 s` depois de baixar.

E some o **"CONTINUA…"**: é gramática de novela, não existe episódio 2 de um perfume.

## Erro de medição que quase me enganou

Comparei o áudio devolvido com o nosso usando envelopes de **durações diferentes** (3,92 s contra
5,04 s) e obtive correlação 0,12 — parecia que o modelo tinha trocado o áudio. Na janela certa dá
**1,0**. **Comparar séries temporais de tamanhos diferentes inventa um defeito que não existe.**

## Custo real

6 falas ≈ 12 cr de stills + ~60 cr de clipes 720p + 1,8 de TTS ≈ **74 créditos** para 33 s.
Cerca de **2× o narrado**. 1080p sobe para ~120.
