# Avatar Studio

> **Antes de qualquer coisa, leia `memory/MEMORY.md`** — é o índice do que já foi aprendido aqui, e
> evita repetir erro que já custou crédito. No Claude Code um hook faz isso sozinho; em runtimes sem
> hook (OpenClaw), esta linha é o gatilho.

Sistema **autônomo** para transformar **o avatar que você cria** (imagem gerada por IA) em **vídeo
dele falando que não parece IA**. Nada aqui depende de banco, servidor ou plataforma: entra a imagem do avatar, sai vídeo.

Motor único: **Higgsfield CLI**. Custo real de tudo está medido abaixo — nenhuma estimativa.

## O conhecimento vive em ARQUIVO, não em banco

Este estúdio não tem banco de dados e não precisa. O Claude lê arquivos:

| onde | o quê |
|---|---|
| `memory/MEMORY.md` | índice — o hook de sessão faz `cat` dele automaticamente ao abrir |
| `memory/*.md` | 28 fatos, um por arquivo, ligados entre si por `[[nome]]` |
| `.claude/agents/*.md` | 21 agentes especialistas (image-prompt, video-prompt, voice-casting…) |
| `catalog.json` | quem é dono de qual memória |
| `.claude/hooks/` | três hooks: carrega o índice ao abrir, lembra o protocolo a cada pedido e barra o encerramento com desvio |

**Ao aprender algo que se perderia entre sessões**, escreva `memory/<slug>.md` (com frontmatter
`name`/`description`/`type`, e **Why:** / **How to apply:** no corpo), indexe em `memory/MEMORY.md`,
dê um dono em `catalog.json`, e rode `node scripts/check.mjs` — precisa fechar em 0 desvios.

É assim que o próximo avatar sai melhor que este.

---

## O trabalho, em quatro passos

Cada avatar é uma pasta em `avatares/<nome>/`. Copie `avatares/_MODELO/` para começar.
Comece copiando o modelo `avatares/_MODELO/` para `avatares/<seu-avatar>/`.

| # | passo | comando | custo |
|---|---|---|---|
| 1 | **Imagens** | o dono põe as imagens do avatar (geradas por IA) em `fotos_reais/` | — |
| 2 | **Cenários** | `./scripts/cenarios.sh "<avatar>" carro banheiro rede sofa` | 2 cr/cenário |
| 3 | **Voz** | `./scripts/voz.sh "<avatar>" --testar` · depois `--clonar <audio>` | 0,3 cr/amostra |
| 4 | **Vídeo** | `./scripts/video.sh "<avatar>" <cenario> <segundos> "<fala>"` | 1,5 cr/segundo |

**Sempre confira antes de aprovar** — a verificação é visual, não automática:

```bash
uv run workflows/tira-do-rosto.py <video> --regiao sobrancelha --de 0 --ate 5
uv run workflows/tira-do-rosto.py <video> --regiao olhos --de 6 --ate 12
```

---

## As regras que custaram crédito para descobrir

**1. A imagem APROVADA é a âncora, não a foto real.** Gere UM cenário, mostre ao dono, e só então
gere os outros passando o aprovado como `--image-references` **antes** das fotos de origem. Com as
fotos sozinhas o rosto muda entre cenários — aconteceu, e custou refazer dois.

**2. Nunca escreva "instagram story" no prompt.** O modelo DESENHA a interface: nome de usuário
inventado, "23h", botão de fechar. Descreva o enquadramento, jamais a rede social.

**3. O celular é a câmera — ele não aparece.** "filming himself with his phone in his hand" produz
alguém filmando o sujeito de fora. Peça selfie de câmera frontal.

**4. Sem dizer que está vestido, sai sem camisa.** Bloco `VESTE` obrigatório: camiseta com manga,
gola e ombros visíveis, `no bare skin`.

**5. Instrução genérica só age onde já existe verbo.** Esta é a mais importante. "Ele parece
natural" não faz nada. As microexpressões precisam morar **dentro de cada beat**, com marca de
tempo — num teste, a sobrancelha ficou **idêntica em 14 quadros** enquanto lia, porque a instrução
de expressão estava num bloco separado dos beats.

**6. O modelo não pisca se você não pedir.** Um clipe saiu com o olho aberto em **15 de 15**
quadros. Uma pessoa pisca 1–2 vezes a cada 5 segundos.

**7. Acima de ~8s o prompt vira roteiro com tempo.** Descrever um estado faz o modelo repetir a
mesma coisa o clipe inteiro. Use "0 to 2s — … / 2 to 4s — …".

**8. Reticências viram respiração.** `"...desconfia. Sempre."` sai com a pausa no lugar certo.
Pergunta com "?" tende a virar afirmação — se a palavra exata importa, escreva sem interrogação.

**9. O truque da miopia rende três coisas numa instrução.** `he SQUINTS and BRINGS THE PHONE CLOSER
to his face, tilting his head back, chin lifting`: move o braço (reenquadra o clipe sozinho), faz o
olho reaparecer (lendo de cabeça baixa a pálpebra cobre tudo) e cria esforço no rosto.

**10. Itere em 480p `fast`.** 3× mais barato. Só suba a resolução no vídeo que vai ao ar.

---

## Voz

| opção | custo | quando |
|---|---|---|
| **áudio nativo do vídeo** (`seedance_2_0`) | incluso | padrão — nasce casado com a boca |
| `seed_audio --audio-references <audio>` | 0,3 cr | voz clonada de um áudio de referência |
| `inworld_text_to_speech --voice "Heitor (pt)"` | 2 cr | voz **nativa em português** |
| `text2speech_v2 --variant elevenlabs` | 0,3 cr | vozes preset (inglesas lendo pt) |

**O Higgsfield não expõe os controles do ElevenLabs** (stability/style/speed). O que humaniza é o
TEXTO: escrever como se fala triplicou as pausas (3 → 9) na mesma voz.

**`cozy_voice` quebra o português** — devolveu "Qualquer e dia sou chamar no provado". Não use.

**Se for clonar uma voz de referência:** 30–60s de áudio limpo, sem música e sem TV, fala natural
(não lendo). ⚠️ **Se a voz for de uma pessoa real, confirme que você tem consentimento** — clonar
voz põe qualquer frase na boca de alguém; um arquivo já chegou aqui como "vídeo dele" e era de outra pessoa.

---

## Custo (medido, 5 segundos)

| | fast | std |
|---|---|---|
| 480p | **7,5** | 15 |
| 720p | 17,5 | 22,5 |

Linear no tempo: 12s em 480p fast = 18 créditos. Escrever curto é o que economiza.
Imagem (`nano_banana_pro`): 2 créditos. Crédito ≈ US$ 0,049.

---

## Regras de conduta

- **Avatares são criados por IA, não pessoas reais.** Mas se a aparência ou a voz de um avatar for
  baseada em uma pessoa real, tenha o consentimento dela — clonar voz põe qualquer frase na boca de alguém.
- **Não invente número em tela de decisão.** Custo se consulta com `higgsfield generate cost`.
- **Não gaste crédito sem o dono presente.** Cada vídeo de 12s custa ~US$ 0,88.
- `avatares/` (assets dos avatares) e o `.env` (credencial) não vão para repositório público nem CDN aberto.
