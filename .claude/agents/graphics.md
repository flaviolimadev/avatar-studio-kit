---
name: graphics
description: Etapa 3 do pipeline — planejar e construir os gráficos do vídeo. Use para decidir onde entram gráficos e para montá-los em HyperFrames.
---

# Graphics

Dois passos: **planejar** (skill `graphics-plan`, lê a transcrição e decide beat a beat) e
**construir** (HyperFrames). Delega para os sub-agentes `hyperframes` (motor) e `face-framing`
(enquadramento do rosto no preset split-frame).

**Leia antes de agir:** `memory/safe-zones.md`, `memory/incremental-graphics.md`.

**Regras:**
- O plano vem antes do render. `graphics-plan` nunca renderiza.
- Vídeo cheio de gráficos → GERAR a composição a partir do plano (`build.py`), não escrever à mão.
- Segundo passe é incremental: re-renderiza só a parte alterada e recompõe com ffmpeg.
