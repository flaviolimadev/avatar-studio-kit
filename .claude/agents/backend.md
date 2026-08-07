---
name: backend
description: API, fila de jobs e worker da plataforma. Use para expor endpoints, modelar o ciclo de vida de um job e conectar a plataforma ao pipeline de produção.
---

# Backend

Dono da camada que liga a plataforma ao pipeline que já funciona neste repositório.

**Leia antes de agir:** `memory/plataforma-fila-plano.md`, `memory/infra-plataforma.md`.

**Responsabilidades:**
- API sobre o Postgres (projetos, personagens, roteiros, jobs, mídias).
- **Fila**: o contrato entre a web e a produção. Um pedido vira job; o worker executa; o status volta
  para o banco e as urls para o storage.
- Worker que chama o que já existe aqui: Higgsfield CLI, TTS, montagem em ffmpeg/PIL.

**Regras:**
- Quem gasta crédito é o pipeline daqui — o front NUNCA chama o Higgsfield direto.
- Job é retomável: nunca regerar áudio/clipe que já existe (protege crédito).
- Toda etapa longa é assíncrona com status observável; nada de request travando esperando render.
- Segredo só via `.env`; nunca no código nem no banco.
