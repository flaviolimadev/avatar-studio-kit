---
name: cenario-story-do-cliente
description: receita do cenário "gravando story" — a imagem APROVADA é a âncora, e três palavras no prompt estragam tudo
metadata:
  type: reference
---

Gerar o mesmo cliente em vários cenários (carro, banheiro, rede, sofá) para vídeos em que ele parece
estar gravando um story. Exemplo trabalhado e prompt completo:
`avatares/<seu-avatar>/cenarios/README.md`.

**A técnica que trava o rosto: aprove UMA imagem, depois ancore as outras nela.** As fotos reais do
cliente **não bastam** — rede e sofá saíram com outra pessoa mesmo com três fotos como referência.
O que resolveu foi passar as imagens já aprovadas (`carro.png`, `banheiro.png`) como
`--image-references`, **antes** das fotos de origem. O rosto aceito se propaga; a foto real sozinha
deixa margem para o modelo reinterpretar.

**Três coisas no prompt que estragam a imagem:**

1. **`instagram story`** faz o modelo DESENHAR a interface: nome de usuário inventado, "23h", botão
   de fechar, "Enviar mensagem". Nunca citar a rede social — descrever só o enquadramento.
2. **`filming himself with his phone`** põe o celular no quadro, virando "alguém filmando ele". O
   celular **é** a câmera: não aparece. Descrever como selfie de câmera frontal.
3. **`seen from above his face`** (o ângulo natural de quem está deitado) encurta o rosto e o modelo
   troca de pessoa. Manter o mesmo ângulo de selfie dos cenários que ficaram bons.

E sem `VESTE` explícito (camiseta com manga, gola e ombros visíveis, `no bare skin`) ele sai **sem
camisa** — aconteceu no carro e no banheiro.

**Why:** cada um desses saiu sem erro nenhum do CLI — a imagem volta bonita e errada. Só aparece
olhando. Foram 24 créditos até acertar quatro imagens que custariam 8.

**How to apply:** blocos `QUEM` (rosto por extenso) · `VESTE` · `POV` · `LOOK` (amador, `not
cinematic`) · `IMPORTANT: <proibições>`. Identidade só trava mesmo com **Soul ID**
(~25 créditos) — ver [[influencer-nao-chega-na-cena]] e [[character-anchors]].
