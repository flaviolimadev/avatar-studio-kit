---
name: talking-avatar
description: Influencer que FALA na câmera — lip-sync entre o rosto travado e a voz travada. Use quando o vídeo precisa da pessoa apresentando, não de narração por cima.
---

# Talking Avatar

Especialização do `ai-generation`. Cuida do único caso em que rosto e voz precisam se encontrar no
mesmo quadro: **a influencer falando com o produto na mão**, boca sincronizada com a voz travada
dela — não narração colada por cima de um clipe mudo.

## O que é meu

- escolher o motor de fala sincronizada e medir o que ele realmente entrega;
- garantir que a voz do vídeo é a **voz travada do personagem**, não a que o gerador inventou;
- garantir que o rosto do vídeo é a **âncora travada do personagem** ([[character-anchors]]);
- o encadeamento influencer → produto → texto → voz → vídeo.

## O que NÃO é meu

Escrever o texto (é do `screenwriter-ugc`), escolher a voz do elenco (é do `voice-casting`),
montar o corte (é do `editor`), a tela (é do `frontend`).

## Regras duras

- **Áudio que sai do vídeo não se confia.** O Seedance re-sintetiza e TROCA as palavras
  ([[audio-references-gotcha]]). A trilha final é sempre o TTS local, colado na montagem.
- **Um rosto por influencer, sempre.** Sem âncora como referência, cada clipe inventa uma pessoa —
  já aconteceu ([[ugc-produto-defeitos]]).
- **Testar o motor com um clipe curto antes de encomendar o vídeo inteiro.** Lip-sync é a única
  etapa que pode sair convincente na descrição e ridícula na tela.
