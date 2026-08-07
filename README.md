# 🎬 Avatar Studio Kit

Transforme **um avatar que você cria por IA** em **vídeo dele falando — sem cara de IA**.

Um "estúdio" completo de **agentes + memória + ferramentas** para produção de vídeo falante, que roda
no **[Claude Code](https://claude.com/claude-code)** e gera com o **Higgsfield CLI**. Sem banco, sem
servidor: entra a imagem do avatar, sai vídeo.

> Cada regra deste kit foi descoberta **gastando crédito** e está **medida** — não é palpite. Elas
> vivem em `memory/` como fatos persistentes que fazem o próximo vídeo sair melhor que o anterior.

---

## O que você recebe

- **21 agentes especialistas** — roteiro, prompt de imagem, prompt de vídeo, voz, consistência de
  personagem, controle de custo, QA… (em `.claude/agents/`).
- **28 memórias de aprendizado** — as armadilhas que custam crédito, já resolvidas: piscar,
  microexpressão dentro de cada beat, áudio nativo, o "truque da miopia", clipe longo em beats… (em `memory/`).
- **Scripts do pipeline** — cenário → voz → vídeo, com a receita anti-IA embutida (em `scripts/`).
- **O loop que se mantém sozinho** (conceito [claude-mind](https://github.com/flaviolimadev/claude-mind)):
  catálogo → agentes → memória → verificador → hooks. O agente carrega a memória ao abrir, roteia
  cada pedido pelo dono certo, e destila o que aprende de volta pra memória.
- **Um grafo ao vivo** da estrutura: `node viewer/server.mjs` → http://localhost:4173.

## Requisitos

- **Node 20+**, **uv** (para os scripts Python) e **ffmpeg**
- **Uma conta Higgsfield** (o motor de geração) — https://higgsfield.ai
- **Claude Code** — onde os agentes e os hooks rodam

## Começar

```bash
git clone https://github.com/flaviolimadev/avatar-studio-kit.git
cd avatar-studio-kit
cp .env.example .env        # preencha com a SUA credencial Higgsfield
./scripts/instalar.sh       # instala o CLI, autentica e confere as dependências
```

Depois, cole o conteúdo de **`PROMPT.txt`** como primeira mensagem do agente no Claude Code. Ele lê a
memória, se apresenta, e a partir daí você opera em quatro passos:

| # | passo | comando |
|---|---|---|
| 1 | **Imagem** | ponha a imagem do seu avatar (gerada por IA) em `avatares/<nome>/fotos_reais/` |
| 2 | **Cenários** | `./scripts/cenarios.sh <nome> sofa carro rede` — gera UM, você aprova, ancora o resto |
| 3 | **Voz** | `./scripts/voz.sh <nome> --testar` (ou use o áudio nativo do vídeo) |
| 4 | **Vídeo** | `./scripts/video.sh <nome> sofa 12 "a fala"` |

`DRY=1` na frente de qualquer script mostra o prompt e o custo **sem gastar nada**. Todo script
pergunta antes de gerar.

## Custo (medido, por 5 segundos)

| | fast | std |
|---|---|---|
| 480p | **7,5 cr** | 15 |
| 720p | 17,5 | 22,5 |

Linear no tempo: 12s em 480p fast = 18 créditos. **Itere em 480p; só suba a resolução no vídeo que
vai ao ar.** O preço por crédito depende do seu plano Higgsfield.

## A memória é o valor

Não há banco. O conhecimento são arquivos `.md` versionados — é isso que faz o agente melhorar a cada
job e permite compartilhar a mesma "cabeça" entre máquinas pelo git. `node scripts/check.mjs` mantém
catálogo, agentes e memória em sincronia (tem que fechar em **0 desvios**).

## Uso responsável

Os avatares são **criados por IA**. Se você basear a aparência ou a voz de um avatar em uma **pessoa
real**, só trabalhe **com o consentimento dela** — clonar voz permite pôr qualquer frase na boca de
alguém. E **nunca** versione seu `.env` (credencial) nem as pastas de avatar num repositório público
(o `.gitignore` já cuida disso).

## Créditos

Construído sobre o conceito **[claude-mind](https://github.com/flaviolimadev/claude-mind)** — memória
persistente + agentes + auto-aprendizado para assistentes de código. Licença **MIT**.
