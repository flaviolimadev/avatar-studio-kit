---
name: vozes-elevenlabs-ptbr
description: Kokoro não serve para fala de personagem — e nem toda voz do ElevenLabs pronuncia português direito; testar antes de travar
metadata:
  type: reference
---

Retorno do cliente em 2026-07-25 sobre o primeiro vídeo com diálogo: *"o áudio não ficou bom, a
narração está estranha, não parece brasileiro"*. Estava certo — as falas tinham saído no **Kokoro**,
que lê o texto sem atuar e sem sotaque brasileiro.

**Regra que fica:** Kokoro é **rascunho e voz off técnica**. Fala de personagem em vídeo que vai ao
ar é **ElevenLabs** (`text2speech_v2 --variant elevenlabs`, 0,3 crédito por fala). Um episódio de 7
falas custa 2,1 créditos — irrelevante perto dos 8 por clipe.

**Nem toda voz pronuncia português corretamente.** Testado com a mesma frase
("E se der prejuízo, meu filho?"):

| Voz | Resultado |
|---|---|
| **Elena** | correta ✓ (adotada para Dona Rosa) |
| Isabella | pronunciou "prejuízo" partido, virou "ceder prejuízo" ✗ |
| Andre (Gabriel), Marcus (César) | corretos ✓ |
| **Julian** | correto ✓ — disse "PIX" (adotado para Biel) |
| Leo | leu **"Pix" como "picks"**, em inglês ✗ |
| **Luna** | correta ✓, preservou a entonação de pergunta (adotada para Larissa) |
| Sienna | correta ✓ (transformou a pergunta em afirmação na leitura) |

**Como validar sem ouvir:** gerar a fala e **transcrever com WhisperX** (`--model medium`, o `small`
erra demais em áudio curto). Se a transcrição não bate com o texto enviado, a voz está pronunciando
errado — troca a voz, não o texto. Amostras ficam em `projects/<slug>/vozes-teste/`.

**Onde a voz mora:** no personagem (`characters.voice_id`), não na cena. O worker resolve a voz pelo
personagem da cena; a cena só sobrescreve se quiser. Trocar a voz = apagar só as falas daquele
personagem e reenfileirar — **os clipes não são regerados**, então custa centavos.

**Armadilha de shell (custou uma rodada):** no zsh, `rm -f pasta/*.wav pasta/*.mp3` **aborta o
comando inteiro** se um dos globs não casar — os arquivos antigos ficam e o worker os reaproveita,
parecendo que a correção não funcionou. Usar `find ... -delete`.

Ver [[tts-elevenlabs]], [[voice-id-reuso]], `audio-chain`.

**O teste vale por sigla e estrangeirismo, não só por acento.** "Pix" derrubou uma voz que lia
português acentuado sem erro nenhum: Leo pronunciou *"picks"*, à inglesa — num vídeo brasileiro
sobre golpe de Pix. Frase de teste boa é a que carrega a palavra de marca do roteiro, não uma
frase bonita qualquer.
