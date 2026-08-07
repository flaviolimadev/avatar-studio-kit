---
name: audio-references-gotcha
description: ARMADILHA — o Seedance re-sintetiza a fala e TROCA as palavras quando recebe audio-references
metadata:
  type: reference
---

Teste real (2026-07-25): passei ao `seedance_2_0_mini` um WAV com a fala
*"Me manda quinhentos reais que em uma semana eu multiplico a tua banca"* via `--audio-references`.
O clipe voltou com a boca sincronizada, mas o áudio dizia
*"Mande um comentário aí que em uma semana eu multiplico a sua renda"* — texto reescrito.

**Regra que ficou:** para diálogo, gerar o clipe com `--generate_audio false` e colar a narração/fala
TTS na montagem local. É o que garante (a) o texto exato do roteiro e (b) a MESMA voz em toda a série.

`--audio-references` só é útil quando se quer o movimento de boca acompanhando o tempo de um áudio —
mas mesmo aí a trilha final tem que ser substituída na edição.

Ver [[character-anchors]], [[higgsfield-cli]].
