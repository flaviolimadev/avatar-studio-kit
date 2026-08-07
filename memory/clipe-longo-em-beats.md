---
name: clipe-longo-em-beats
description: acima de ~8s o prompt precisa dizer QUANDO cada coisa acontece — descrever um estado faz o modelo repetir a mesma coisa o clipe inteiro
metadata:
  type: reference
---

Num clipe de 5s dá para descrever um **estado** ("ele fala olhando na câmera"). Em 12s isso falha:
o modelo faz a mesma coisa do começo ao fim. Para clipe longo o prompt vira **roteiro com tempo**.

Funcionou em 2026-07-28, num vídeo de 12s de "lendo um comentário e respondendo":

> TIMING: For the first 4 seconds he is READING a comment off his phone screen — eyes lowered toward
> the screen, not at the lens, head tilts slightly down, eyebrows rise as he reads, half-smile of
> disbelief. Around 4 to 6 seconds he finishes reading, takes a visible breath in through the nose,
> gives a small sideways head shake, and RAISES his eyes back to the lens. From 6 seconds on he
> answers straight into the camera, pausing between phrases, gesturing once with his free hand.

Resultado conferido quadro a quadro: **0,5–5s cabeça baixa lendo, com o celular visível na mão;
6,5–11s olhar levantado respondendo.** A virada caiu dentro da janela pedida.

**O que faz a diferença:** verbo de AÇÃO com marca de tempo ("Around 4 to 6 seconds he finishes
reading, takes a visible breath"), não adjetivo de estado ("he looks natural"). E o modelo adiciona
o adereço sozinho — ninguém pediu o celular na mão, ele apareceu porque a ação "reading off his
phone screen" o exige.

**As reticências do texto viram pausa.** `"...desconfia. Sempre."` sai com a respiração no lugar
certo — mesmo efeito medido no TTS ([[voz-com-cara-de-ia]]).

**Custo:** 1,5 crédito por segundo em `480p --mode fast`. 12s = 18. Linear, então escrever curto é
o que economiza — não baixar resolução depois.

**A REGRA QUE VALE MAIS QUE TODAS: instrução genérica só age onde já existe ação descrita.** Numa
versão as microexpressões estavam num bloco geral e os beats em outro — o modelo aplicou expressão
só nos beats que tinham verbo, e o sujeito LEU DE CARA PARADA (sobrancelha idêntica em 14 quadros).
Movendo as expressões para DENTRO de cada beat, a sobrancelha ganhou vida: relaxa → vinca de
concentração → relaxa. Mesmo modelo, mesma fala, mesma imagem — mudou só onde a instrução estava.

**O truque da miopia rende três coisas numa instrução só** (`he SQUINTS and BRINGS THE PHONE CLOSER
to his face, tilting his head back, chin lifting`): movimento de braço que reenquadra o clipe
sozinho; o olho REAPARECE (lendo de cabeça baixa a pálpebra cobre tudo e nem dá para verificar
piscada); e uma microexpressão de esforço que "pareça natural" nunca produz.

Receita completa das 5 versões, com o defeito e a medição de cada uma:
`avatares/<seu-avatar>/previa/RECEITA-AVATAR-REAL.md`.

⚠️ **A tira de conferência precisa acompanhar o enquadramento.** Meu recorte fixo da faixa dos olhos
pegou a testa: na metade em que ele responde o rosto fica maior e mais centrado que na metade em que
lê. Use `workflows/tira-do-rosto.py`, que acha o rosto em CADA quadro (YuNet) e recorta olhos, sobrancelha ou boca em cima dele — errei o recorte fixo três vezes seguidas e quase reprovei um vídeo bom. Ver [[rosto-que-nao-pisca]].
