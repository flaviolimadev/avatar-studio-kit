---
name: lipsync-veo-vs-wan
description: Áudio e vídeo têm que nascer JUNTOS — o wan2_7 anima "falar" sem seguir os fonemas; o Veo 3.1 sincroniza de verdade
metadata:
  type: reference
---

O cliente viu na hora o que eu não tinha visto: *"o áudio não está casando com o vídeo, é como se
fossem feitos separados"*. Estavam. Medido em 2026-07-28.

## O teste que decide (e o que NÃO decide)

**Não serve:** correlação entre diferença de pixel quadro a quadro e energia da voz. Numa selfie na
mão, o **tremor de câmera domina** a diferença de pixel e afoga o movimento da boca. Deu 0,04 para o
wan e −0,08 para o Veo — e o Veo é o que funciona. Medidor errado inverte a conclusão.

**Serve:** achar no áudio os instantes de **vogal forte** e de **silêncio**, extrair o quadro exato
de cada um e olhar a boca.

| | vogais fortes | silêncios |
|---|---|---|
| **wan2_7** | boca **fechada** (3 de 4) | boca **aberta** (3 de 4) |
| **Veo 3.1** | boca **aberta** (4 de 4) | boca **fechada** (4 de 4) |

O wan2_7 está **anticorrelacionado**: ele preserva o nosso áudio (correlação de envelope 1,0) mas
anima um "movimento de falar" genérico que não olha os fonemas. Dá exatamente a sensação de dublagem.

## A escolha

| | `wan2_7` (áudio por fora) | **`veo3_1` (junto)** |
|---|---|---|
| lip-sync | decorativo | **real** |
| texto falado | o nosso TTS, exato | o do prompt — saiu exato, mas **gagueja às vezes** ("no outro dia aí dia") |
| voz | **a travada do personagem** (`voice_id`) | escolhida pelo modelo — timbre variou 8% entre clipes |
| resolução | 720p (1080p custa 2,5×) | **1080×1920 nativo** |
| duração máxima | 15 s | **8 s** |
| custo | 22,5 cr / 15 s | 22 cr / 8 s (~2× por segundo) |

**Para vídeo com pessoa falando, o Veo ganha** — sincronia é o que decide se parece real. O preço é
perder a voz travada e o teto de 8 s.

## O teto de 8 s e a emenda invisível

Um vídeo de 16 s são dois clipes. O truque: **extrair o último quadro do clipe 1 e usá-lo como
`start_image` do clipe 2** (`ffmpeg -sseof -0.1`). A emenda some — mesma pessoa, mesma roupa, mesmo
cômodo, mesmo frasco. Testado.

## O que eu errei antes

Eu tinha dito que o lip-sync do wan2_7 funcionava, olhando quadros com a boca aberta. **Boca aberta
não é sincronia** — só prova que ela se mexe. A pergunta certa é se a boca abre *no som certo*.
Ver `presets/ugc-cru.md` e `ugc-cru-take-unico`.

## Custo medido do entregável (2026-07-28)

Do extrato do Higgsfield, não de estimativa: **46 créditos por 16 s** — um still de partida
(`nano_banana_pro`, 2) + dois clipes de 8 s do Veo 3.1 (22 cada). São **2,87 cr/s**, ou
**US$ 2,25** no plano Plus (US$ 49 / 1.000 cr — ver [[cost-model]]).

Comparando os três caminhos do mesmo roteiro:

| versão | créditos | US$ | por segundo | sincronia |
|---|---|---|---|---|
| 6 clipes com cortes (33 s) | 74 | 3,63 | 2,23 cr/s | ✗ |
| wan2_7 take único (15 s) | 24,8 | 1,22 | 1,65 cr/s | ✗ |
| **Veo 3.1 (16 s)** | **46** | **2,25** | 2,87 cr/s | **✓** |

O Veo é o mais caro por segundo e o único que entrega. **Recusa por NSFW cobra e estorna** — no
extrato aparece `spend −2` seguido de `refund +2`; líquido zero, mas as duas pontas ficam no
histórico (eu tinha escrito que não chegava a cobrar).
