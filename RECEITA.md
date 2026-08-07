# Receita do avatar que não parece IA

Cinco versões, 12s cada, `seedance_2_0 --resolution 480p --mode fast` (1,5 crédito/segundo).
Prompt final em `prompt-v5.txt`. Cada defeito abaixo foi **medido**, não achado —
`uv run workflows/tira-do-rosto.py <video> --regiao olhos|sobrancelha|boca --de X --ate Y`.

## O que cada versão consertou

| v | defeito | correção | como se comprovou |
|---|---|---|---|
| v1 | não piscava | pedir piscada explicitamente | olho aberto em **15/15** quadros |
| v2 | — | microexpressões genéricas | piscada completa aos ~4,3s |
| v3 | **sobrancelha parada na leitura** | — | **14 quadros idênticos** |
| v4 | idem | **amarrar expressão a cada beat** | relaxa → vinca → relaxa |
| v5 | olho invisível lendo | miopia: aproximar o celular | olhos visíveis, aperto nos quadros 6–11 |

## A regra que vale mais que todas

**Instrução genérica só age onde já existe ação descrita.** Na v3 as microexpressões estavam num
bloco geral e os beats em outro — o modelo aplicou expressão só no beat que tinha verbo, e leu de
cara parada. Na v4 cada beat passou a carregar as próprias expressões e a sobrancelha ganhou vida.

Corolário: **verbo de ação com marca de tempo**, nunca adjetivo de estado. `"Around 2 seconds he
squints and brings the phone closer"` funciona; `"he looks natural"` não faz nada.

## O truque da miopia — três ganhos de uma instrução

> at around 2 seconds he SQUINTS, narrowing his eyes, and BRINGS THE PHONE CLOSER to his face,
> tilting his head back a little to focus, chin lifting

1. **movimento de braço** — o enquadramento muda junto, reforçando o "gravado na mão"
2. **o olho reaparece** — lendo com a cabeça baixa a pálpebra cobre tudo, e nem dá para verificar
   piscada; ao levantar o queixo o olho volta ao quadro
3. **microexpressão de esforço** que nenhuma instrução genérica produz

## Armadilha de verificação

Recorte por coordenada fixa **não serve**: o enquadramento muda dentro do próprio clipe. Errei três
vezes seguidas e quase reprovei um vídeo bom. Use `workflows/tira-do-rosto.py`, que acha o rosto em
cada quadro. O `workflows/piscada.py` (detector automático) **deu 5 falsos positivos** num clipe sem
nenhuma piscada — é rascunho, não veredito.

## Custo

| 5s | fast | std |
|---|---|---|
| 480p | **7,5** | 15 |
| 720p | 17,5 | 22,5 |

Linear no tempo: 12s em 480p fast = 18. Iterar prompt em 480p e só subir a resolução no final.
