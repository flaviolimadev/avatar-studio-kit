---
name: roteamento-de-tarefas
description: Toda tarefa passa pelo dispatcher e só roda com um dono declarado — nenhuma ação é executada "por conta própria"
metadata:
  type: feedback
---

Decisão do cliente em 2026-07-25: **cada ação precisa de um responsável**. Nada é feito solto.

**O protocolo:**
1. O pedido é decomposto em **ações** (verbos), não em assuntos. "Fazer um vídeo de novela" não é uma
   ação — é escrever roteiro + gerar imagem + gerar clipe + escolher voz + montar + verificar, cada
   uma com dono diferente.
2. Cada ação vai ao **domínio** dono e desce até o **sub** que cobre aquele recorte.
3. Não existe sub para o recorte? **Cria-se antes de executar** — ver [[especializacao-sob-demanda]].
4. Executa e **registra** (`scripts/log.mjs <agente> executou "..."`), para haver rastro de quem fez.

**Why:** um agente que faz tudo não é especialista em nada. Recorte estreito é o que permite regra
específica, memória específica e qualidade previsível — e é o que torna a estrutura utilizável por
uma API depois, onde cada agente vira um prompt de sistema enxuto.

**How to apply:** antes de agir, pergunte "qual a ação e quem é o dono?". Se a resposta for "eu
mesmo, direto", falta um agente — criá-lo é parte da tarefa, não desvio dela.

Ver [[how-it-works]], [[the-loop]].
