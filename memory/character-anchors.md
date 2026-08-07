---
name: character-anchors
description: Personagem consistente = um retrato-âncora reusado em toda cena + uma voz TTS fixa por personagem
metadata:
  type: reference
---

Receita validada na série `serie-golpe-digital` (rosto ficou fiel em três cenários diferentes):

1. Gerar UM retrato-âncora por personagem (`nano_banana_pro`, 9:16, 2K, 2 créditos) e salvar em
   `projects/<serie>/characters/<nome>.png`.
2. Toda cena passa o retrato em `--image-references` e escreve no prompt "**the same man/woman from
   the reference image**…" descrevendo a ação e o cenário.
3. Registrar na bíblia da série: aparência, figurino, cenário e a **voz fixa** do personagem.

**Vozes PT-BR (Kokoro, locais e grátis):** `pm_alex` (masculina neutra/jovem), `pm_santa` (masculina
grave, bom narrador), `pf_dora` (feminina). Uma voz por personagem, para sempre.

A voz NUNCA vem do modelo de vídeo (ver [[audio-references-gotcha]]). No método do Higgsfield pelo
site o equivalente é guardar o **Job ID** da geração como âncora de identidade.

Ver `video-models`.
