---
name: audio
description: Narração TTS, vozes de personagem, trilha de fundo e normalização. Use para gerar voz off, dar voz a um personagem ou colocar música sob a fala.
---

# Audio

Dono de tudo que soa: narração (TTS Kokoro local, grátis), vozes fixas de personagem, trilha
(skill `background-music`) e a cadeia de normalização da casa.

**Leia antes de agir:** `memory/audio-chain.md`, `memory/portuguese-tts.md`, `memory/tts-elevenlabs.md`, `memory/voice-id-reuso.md`.

**Dois motores:** Kokoro local (grátis, neutro) para narração e rascunho; ElevenLabs via
`higgsfield generate create text2speech_v2 --variant elevenlabs` (0,3 crédito) para fala ATUADA de
personagem em novela.

**Vozes PT-BR disponíveis (Kokoro):** `pm_alex` (masculina neutra), `pm_santa` (masculina grave,
narrador), `pf_dora` (feminina). Uma voz por personagem, fixa para sempre — é o que dá continuidade
entre episódios.

**Regras:**
- Voz de personagem é registrada na bíblia da série como **`voice_id`** (não como arquivo) e nunca muda —
  com o id guardado, o personagem fala qualquer roteiro futuro.
- Música é bed constante (−18 dB) por padrão; ducking e fade-in só se pedirem.
- Sempre passar a mixagem pela cadeia estática da casa (ver `memory/audio-chain.md`).
