---
name: voz-com-cara-de-ia
description: o Higgsfield não expõe os controles do ElevenLabs — quem humaniza a fala é o TEXTO, e a saída definitiva é o áudio nativo do vídeo
metadata:
  type: reference
---

Cliente em 2026-07-28: *"a voz tá muito com cara de IA, tem como deixar mais humana usando o
ElevenLabs da própria Higgsfield?"*

**Pelo ElevenLabs, não:** `text2speech_v2` aceita só `prompt`, `variant`, `voice_id`, `voice_type`.
*stability*, *similarity*, *style* e *speed* não existem aqui, e trocar de `variant` não muda a
cadência.

⚠️ **MAS eu concluí demais.** Respondi "não dá" tendo inspecionado **um único modelo**. `higgsfield
model list` mostra outros motores de áudio — `inworld_text_to_speech`, `qwen_audio_tts`,
`seed_audio`, `mirelo_text_to_audio` — e dois deles resolvem o problema. Lição: antes de dizer que a
plataforma não faz algo, **listar o catálogo**, não inspecionar o modelo que já se estava usando.

**O achado principal: vozes NATIVAS em português.** `inworld_text_to_speech` tem `Heitor (pt)` e
`Maitê (pt)`. Todas as vozes do ElevenLabs (Roman, Julian, Andre…) são **vozes inglesas lendo
português** — é daí que vem boa parte do sotaque de IA. O Heitor transcreveu perfeito, com 8 pausas.
Custa 2 créditos contra 0,3 (6,7×), irrelevante perto dos 8–22 de um clipe.

**`seed_audio` clona voz por amostra** (`--audio-references`, 0,3 crédito): manda um áudio real do
cliente e a fala sai com a voz dele — sem depender de clonagem pelo site.

**`qwen_audio_tts` tem `instruction`** (estilo em texto livre, teto de **128 caracteres**) e
`language=pt`, mas nos meus dois testes **quebrou palavras** ("vocês"→"Vox", "dúvida"→"de vida").
Ressalva: usei nele um `voice_id` do ElevenLabs, o que pode ser a causa — vale repetir com voz
própria antes de descartar.

**`cozy_voice` quebra o português.** A transcrição voltou *"Qualquer e dia sou chamar no provado que
eu respondo vial"* no lugar de *"Qualquer dúvida é só chamar no privado que eu respondo. Valeu!"*.
Descartado para PT-BR — junto com o Leo de [[vozes-elevenlabs-ptbr]].

## A alavanca que funciona é o TEXTO

Mesmo motor, mesma voz (`roman`), mudando só como o texto foi escrito:

| texto | duração | pausas >150ms |
|---|---|---|
| escrito | 7,8s | **3** |
| falado | 12,1s | **9** |

Três vezes mais respirações, transcrição continuou perfeita. O TTS lê o que está escrito — texto de
redação sai com ritmo de redação.

**How to apply:** ao escrever fala para TTS, usar reticências, interjeição ("ó", "olha"), repetição
("rapidinho, rapidinho mesmo"), travessão e pergunta-etiqueta ("tá?"). Cada um vira uma pausa. Custa
zero e é o maior ganho por crédito gasto. Vale instruir o roteirista (`escreverRoteiro`) a escrever
assim quando o destino é TTS.

## As duas saídas definitivas

1. **Voz clonada do próprio cliente** (`voice_type: element`). A CLI só lê e lista vozes — a clonagem
   é pelo site; depois de criada aparece em `voices list` e funciona igual às preset.
2. **Não usar TTS.** O `seedance_2_0` gera a fala junto do vídeo (`generate_audio`, fala dentro do
   prompt), já casada com a boca e com a acústica do ambiente — foi assim que o cliente gerou a
   referência que ele quer copiar. Ver [[seedance-2-audio-nativo]].

**Como medir sem ouvir:** contar silêncios >150ms (proxy de respiração) e transcrever com WhisperX
`--model medium --language pt` para pegar motor que quebra palavra. Ver [[voice-id-reuso]].
