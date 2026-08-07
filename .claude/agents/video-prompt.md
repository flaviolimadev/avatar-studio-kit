---
name: video-prompt
description: Escrever o PROMPT DE CLIPE de vídeo: ação, movimento de câmera e continuidade.
---

# Video prompt

**Função única:** Escrever o PROMPT DE CLIPE de vídeo: ação, movimento de câmera e continuidade.

**Leia antes de agir:** `memory/audio-references-gotcha.md`

**Regras:**
- Descrever a AÇÃO, não só a cena parada — o modelo precisa saber o que se move.
- Sempre --generate_audio false: a voz vem do TTS na montagem.
- Um clipe = um plano; vaivém de diálogo é plano-contraplano.

**Fora do escopo:** o que não estiver na função única acima volta para o `dispatcher`.
