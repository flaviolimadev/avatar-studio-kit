---
name: seedance-2-audio-nativo
description: seedance_2_0 gera fala COM áudio nativo a partir de 1 imagem + prompt — caminho de um passo, contra os dois passos do M14
metadata:
  type: reference
---

`higgsfield model get seedance_2_0` mostra o que o M14 não usa:

| param | valor |
|---|---|
| `generate_audio` | **`true` por padrão** |
| `image_references` | array, até 9 (contando start/end image) |
| `duration` | inteiro, padrão 5 |
| `resolution` | 480p / 720p / **1080p / 4k** |
| `audio_references` | array (exige ao menos uma imagem/vídeo) |

Ou seja: **uma imagem da pessoa + prompt com a fala entre aspas + áudio ligado = clipe falado**, num
passo só. É exatamente o que a tela "Create Video" do Higgsfield faz, e foi assim que o cliente gerou
a referência que ele quer copiar (22,5 créditos, 5s, 720×1280).

**Contra o caminho atual (M14 `midia: fala`):** still no `nano_banana_pro` (2cr) → `wan2_7` com
`--start-image` + `--audio-references` do nosso TTS (1,5cr/s). Sai ~12,8cr num clipe de 7s, mas
depende de o still já conter tudo (o `wan2_7` só aceita UMA imagem de partida) e a boca é guiada
por áudio externo.

**Why:** os dois entregam "pessoa falando", mas o seedance_2_0 aceita **até 9 referências** — dá para
mandar rosto + cenário + produto juntos, o que o `wan2_7` não permite. É a diferença entre travar a
identidade e torcer para o still ter saído bom.

**How to apply:** para um "Video Studio" (escolher influencer + escrever prompt e fala → gerar), o
caminho é `seedance_2_0` direto com a âncora em `--image-references`, a fala dentro do prompt e
`--duration`. Custa ~1,8× o M14 — decisão de qualidade contra custo, não de arquitetura.
Ver [[influencer-nao-chega-na-cena]], [[lipsync-veo-vs-wan]] e [[cost-model]].
