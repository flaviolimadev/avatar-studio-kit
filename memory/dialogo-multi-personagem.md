---
name: dialogo-multi-personagem
description: Cena com dois personagens interagindo funciona — passar os dois retratos-âncora como image-references e dizer FIRST/SECOND no prompt
metadata:
  type: reference
---

Testado em 2026-07-25 (`projects/serie-golpe-digital/tests/two-shot.mp4`, 8 créditos): o
`seedance_2_0_mini` aceita **vários `--image-references`** e mantém os DOIS personagens fiéis no
mesmo quadro. O limite do modelo é 9 imagens de referência (12 arquivos no total).

**Receita:**
```bash
higgsfield generate create seedance_2_0_mini --aspect_ratio 9:16 --resolution 480p --duration 8 \
  --genre drama --generate_audio false \
  --image-references characters/a.png --image-references characters/b.png \
  --prompt "...the young man from the FIRST reference image ... the older man from the SECOND
            reference image ... Both fully visible in the same frame, medium two-shot..."
```

**O que faz funcionar:** referenciar cada personagem pela POSIÇÃO da imagem (`FIRST` / `SECOND`) e
descrever roupa e traço marcante de cada um; pedir explicitamente o enquadramento conjunto
("both fully visible in the same frame, medium two-shot").

**Gramática de cena de diálogo** (é como as referências M5/M8 do cliente fazem):
- **two-shot** para o confronto e o contexto;
- **plano-contraplano** (um clipe por personagem falando) para o vaivém do diálogo — mais barato e
  mais fácil de manter fiel, porque cada clipe carrega uma âncora só.

A fala continua vindo do TTS colado na montagem, nunca do modelo de vídeo
(ver [[audio-references-gotcha]]). Ver [[character-anchors]], [[tts-elevenlabs]].
