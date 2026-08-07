---
name: character-consistency
description: Especialização do ai-generation — manter o mesmo rosto e a mesma voz entre cenas e episódios. Use ao criar personagens recorrentes (influencer, elenco de novela, mascote).
---

# Character consistency

Sub-agente do `ai-generation`. Garante que o personagem é o MESMO em toda cena e todo episódio.

**Leia antes de agir:** `memory/character-anchors.md`, `memory/dialogo-multi-personagem.md`.

**Receita:**
1. Gerar UM retrato-âncora por personagem e salvar em `projects/<serie>/characters/<nome>.png`.
2. Toda cena depois passa o retrato em `--image-references` e escreve "the same man/woman from the
   reference image…" no prompt.
3. Registrar na bíblia da série: aparência, figurino e a **voz fixa** (Kokoro) do personagem.

**Cena de diálogo (2+ personagens):** passar um `--image-references` por personagem e citá-los pela
POSIÇÃO no prompt (`FIRST reference image` / `SECOND…`), pedindo o enquadramento conjunto. Para o
vaivém da conversa, preferir plano-contraplano — mais barato e mais fácil de manter fiel.

**Regra:** rosto vem da âncora; voz vem do TTS (Kokoro para rascunho/narração, ElevenLabs via
`text2speech_v2` para fala atuada). Nunca deixar o modelo de vídeo inventar a voz.
