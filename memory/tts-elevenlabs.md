---
name: tts-elevenlabs
description: O ElevenLabs já vem dentro do Higgsfield (text2speech_v2 --variant elevenlabs) por 0,3 crédito — não precisa de assinatura separada
metadata:
  type: reference
---

Descoberto em 2026-07-25: não é preciso assinar o ElevenLabs à parte. O modelo `text2speech_v2` da
CLI do Higgsfield tem `variant` com **elevenlabs, minimax, seed_speech, vibe_voice, cozy_voice**, e
custa **0,3 crédito por fala** (~US$ 0,02) — o mesmo pote de créditos das imagens e clipes.

```bash
higgsfield voices list                     # 57 vozes preset (id + voice_type)
higgsfield generate create text2speech_v2 \
  --variant elevenlabs --voice_id <id> --voice_type preset \
  --prompt "a fala" --wait
```

**Testado:** voz preset "John" falou português brasileiro com o texto EXATO (conferido por
transcrição). As vozes são multilíngues — a mesma voz atende PT/EN/ES, o que serve para versionar a
mesma série em outro idioma mantendo o personagem.

**Quando usar cada motor:**

| | Kokoro (local) | ElevenLabs (via Higgsfield) |
|---|---|---|
| Custo | grátis | 0,3 cr por fala |
| Consistência | total (determinístico) | total (mesmo voice_id) |
| Expressividade | neutra, "lê" o texto | atuação: raiva, choro, sussurro |
| Usar em | narração, voz off, rascunho | **diálogo de novela**, personagem em conflito |

Regra prática: rascunhar no Kokoro (grátis) e gravar a versão final das falas atuadas no ElevenLabs
— um episódio de novela com 8 falas custa ~2,4 créditos a mais, irrelevante perto dos clipes.

O `voice_id` de cada personagem entra na bíblia da série junto com a voz Kokoro de rascunho.
Ver [[character-anchors]], [[portuguese-tts]], [[cost-model]].
