---
name: rosto-que-nao-pisca
description: o Seedance não pisca a menos que o prompt peça — e iterar naturalidade em 480p fast custa 3× menos
metadata:
  type: reference
---

Cliente sobre a primeira prévia: *"ficou com muita cara de IA, ele não piscava"*. Estava certo.

**Medido, não achado:** recortei a faixa dos olhos em 15 quadros ao longo de 5s
(`ffmpeg -vf "crop=iw*0.70:ih*0.09:iw*0.15:ih*0.375,select='not(mod(n\,8))',tile=1x15"`) e o olho
estava **aberto em 15 de 15**. Uma pessoa conversando pisca 1–2 vezes em 5 segundos.

**O que resolveu — pedir no prompt, explicitamente:**

> blinks naturally several times · eyebrows move as he speaks · subtle facial muscle activity around
> the eyes, cheeks and mouth · small involuntary micro-expressions · eyes shift slightly and glance
> away for an instant instead of staring fixed at the lens · natural breathing · tiny spontaneous
> head adjustments

Mesma imagem de partida, mesma fala: a v2 trouxe **piscada completa** (olho fechado) e duas parciais.

**Iterar barato:** `--resolution 480p --mode fast` custa **7,5 créditos** por 5s contra 22,5 do
720p std — 3×. Acertar o prompt no 480p e só depois subir a resolução no que vai ao ar.

| 5s | fast | std |
|---|---|---|
| 480p | **7,5** | 15 |
| 720p | 17,5 | 22,5 |

⚠️ **Não confie em detector automático de piscada.** Escrevi um (`workflows/piscada.py`, YuNet +
variação na região dos olhos) e ele acusou **5 piscadas no clipe que não tinha nenhuma** — três
delas em 0,4s, fisicamente impossível. Estava medindo movimento de cabeça. **A tira visual dos olhos
é o método que presta**; o script fica como rascunho, não como veredito.

**Outro detalhe:** pergunta no texto vira afirmação. "prometeu … ?" saiu como "prometer o" nas duas
gerações. Se a palavra exata importa, escrever sem interrogação. Ver [[seedance-2-audio-nativo]] e
[[cenario-story-do-cliente]].
