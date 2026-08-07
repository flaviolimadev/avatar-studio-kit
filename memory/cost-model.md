---
name: cost-model
description: Custos reais medidos por geração — imagem é 4x mais barata que clipe, e é isso que define o formato barato
metadata:
  type: reference
---

Medido com `higgsfield generate cost` em 2026-07-25 (plano Starter, 1 crédito ≈ US$ 0,071):

| Geração | Créditos |
|---|---|
| Imagem `nano_banana_pro` (qualquer resolução) | **2** |
| `seedance_2_0_mini` 480p 8s | **8** |
| `seedance_2_0` fast 480p 8s | 12 |
| `seedance_2_0_mini` 720p 5s | 12,5 |
| `seedance_2_0_mini` 720p 8s | 20 |
| `seedance_2_0` fast 720p 8s | 28 |
| `seedance_2_0` std 720p 8s | 36 |
| `seedance_2_0` std 1080p 15s | 165 |

**A consequência prática:** um vídeo "caro" de 3 min pode custar ~US$ 2 se for feito de IMAGENS com
movimento de câmera em vez de clipes (é o modelo M7). Sempre perguntar se a cena precisa mesmo de
vídeo. E 480p resolve pro TikTok (a plataforma recomprime; o upscale local é grátis).

Custos reais entregues: piloto M7 de 59,5s = **16 créditos** · episódio de novela de 30s = **32
créditos** (2 retratos + 4 clipes mini 480p).

Planos: Starter US$1=14cr · Plus US$49/1.000cr (US$1=26cr) · Ultra US$129/3.000cr (US$1=31cr, 8
paralelas). O preço por geração é IGUAL em todos — o plano só muda o preço do crédito e o paralelismo.

**Gasto por SCRIPT também vai no ledger.** O worker sempre registrou, porque gasto dele nasce de um
job. Mas quando scripts passaram a chamar a CLI direto — as amostras dos formatos e a foto de
produto da demo — **14 créditos sumiram do dashboard** em 2026-07-26. Custo invisível é pior que
custo alto: quem olha a tela decide com número errado, exatamente o que a regra do Radar proíbe
(`radar-produtos`). `api/lib/creditos.mjs` expõe `gastoAvulso({operacao, nota, projectId})` e a
regra é simples: **a linha que chama o Higgsfield chama isso na sequência.** `project_id` é
anulável de propósito — amostra de formato não pertence a projeto nenhum, e inventar um dono só
para caber na tabela sujaria o custo por projeto.

Ver [[higgsfield-cli]].
