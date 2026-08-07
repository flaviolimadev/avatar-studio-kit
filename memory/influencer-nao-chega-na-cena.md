---
name: influencer-nao-chega-na-cena
description: três causas empilhadas faziam a influencer criada não aparecer no vídeo — e nenhuma reclamava
metadata:
  type: project
---

Cliente criou a influencer `sua-influencer` (mulher de óculos, rosto e voz travados) e o episódio
saiu com um homem genérico. Não era um defeito, eram **três**, e nenhum deles fazia barulho:

1. **O pedido não levou elenco.** `payload.elenco` veio vazio, então o roteirista caiu no caminho
   de INVENTAR quem fala — criou `o-criador-de-conteudo`, descrito como *"Young adult male"*. A tela
   manda `elenco` corretamente; ela simplesmente não foi marcada no passo Elenco.
2. **O rosto era um palpite de caminho.** O worker procurava `projects/<slug>/characters/<nome>.png`
   e, sem o arquivo, seguia sem referência. Personagem vindo de influencer tem a âncora em
   `influencers/<id>/<arquivo>.png` — o arquivo procurado **nunca existiu**. Ver `volume-do-worker`.
3. **O modelo era narrado.** M3 (`midia: clipe`) põe voz por cima de b-roll. Quem quer a pessoa
   falando com a boca sincronizada precisa de M14 (`midia: fala` → still com a âncora +
   `wan2_7 --start-image --audio-references`).

**Why:** cada camada degradava em silêncio e o vídeo saía pago e inútil. O custo de descobrir foi um
episódio inteiro; o de barrar é zero.

**How to apply:**
- A API recusa (400) `roteiro` de modelo `midia: 'fala'` sem `elenco` nem `criar_personagens`.
- O worker resolve o rosto por `characters.anchor_url` e rebaixa do CDN; âncora registrada que não
  desce **para o job** em vez de trocar a pessoa.
- Formato tipo referência (selfie falando, TikTok): M14 + elenco + `camera: 'selfie'` + `duracao`
  curta — 5s vira 1 cena (~9,8 créditos). Ver `duracao-vira-cenas` e [[lipsync-veo-vs-wan]].

⚠️ **A cadeia roteiro → episódio é disparada pela TELA, não pelo worker** (`produzir(s)` no Creator
Lab). Enfileirar um `roteiro` direto no banco deixa o job parado em `pronto` esperando um clique que
nunca vem — o `episodio` precisa ser criado à mão, com `script_id` preenchido.
