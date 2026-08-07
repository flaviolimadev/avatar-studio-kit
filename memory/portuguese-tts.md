---
name: portuguese-tts
description: Setup do TTS PT-BR nesta máquina — Kokoro precisa de kokoro-onnx e de espeak-ng, que aqui foi instalado sem Homebrew
metadata:
  type: reference
---

`npx hyperframes tts --provider kokoro` gera narração local e grátis, mas nesta máquina exigiu duas
coisas que não vinham de fábrica:

1. **`kokoro-onnx` + `soundfile`** — o CLI falha com "kokoro-onnx package is not installed". Venv
   persistente em `~/.cache/video-editor/kokoro-venv` (criado com `uv venv --python 3.11`); basta
   pôr `~/.cache/video-editor/kokoro-venv/bin` no PATH antes de chamar o CLI.
2. **`espeak-ng`** — obrigatório para fonemizar qualquer idioma que não seja inglês. **Não há
   Homebrew nesta máquina**: resolvido baixando o bottle do registro do Homebrew via ghcr, mais o
   `pcaudiolib`, e corrigindo os caminhos das dylibs com `install_name_tool` + `codesign -s -`.
   Fica em `~/.local/espeak-ng`; exportar `ESPEAK_DATA_PATH=~/.local/espeak-ng/share/espeak-ng-data`.

Chamada típica:

```bash
export PATH="$HOME/.cache/video-editor/kokoro-venv/bin:$HOME/.local/espeak-ng/bin:$PATH"
export ESPEAK_DATA_PATH="$HOME/.local/espeak-ng/share/espeak-ng-data"
npx hyperframes@0.7.3 tts texto.txt --provider kokoro --voice pm_santa --output narracao.wav
```

A inicial da voz define o idioma (`p` = português do Brasil). Kokoro não devolve tempo por palavra —
para legenda, transcrever o WAV gerado com WhisperX. Ver `audio-chain`, [[character-anchors]].
