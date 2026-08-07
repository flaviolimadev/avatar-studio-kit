---
name: perfil-de-fala-do-cliente
description: metade do que soa "IA" é o TEXTO, não o TTS — extrair o jeito de falar do cliente da transcrição real e dar isso ao roteirista
metadata:
  type: project
---

Clonar a voz não resolve sozinho. A frase que eu mesmo escrevi para testar TTS — *"Passando
rapidinho aqui pra dar um oi pra vocês"* — é um LLM escrevendo português. Com a voz clonada perfeita
ela continuaria soando errada, porque as **palavras** não são da pessoa.

**Receita:** transcrever um vídeo real com WhisperX (`--model medium --language pt`), contar
bordões por frequência, e ler a abertura e o fechamento — todo criador tem os dois fixos. Exemplo
trabalhado: `avatares/<seu-avatar>/perfil-de-fala/FORMATO-alerta-de-golpe.md`.

O que a contagem revela e o olho não pega: no vídeo de referência de 719 palavras, `olha` aparece
**6 vezes** — é o metrônomo do sujeito, abre frase e marca transição. Sem medir, eu teria escrito
"então" ou "gente", que aparecem 2 e 3 vezes.

**Perfil de FORMATO ≠ perfil de PESSOA.** Um vídeo de terceiro dá a estrutura do gênero (beats,
como se blinda uma acusação, como se fecha), mas o vocabulário e o ritmo só saem de um vídeo da
própria pessoa. Não confundir os dois arquivos.

**Why:** o roteirista (`escreverRoteiro`) escreve com o vocabulário do LLM por padrão. Dar o perfil
a ele é o que faz o roteiro sair com as palavras do cliente — e custa zero, ao contrário de trocar
de motor de TTS. Ver [[voz-com-cara-de-ia]].

⚠️ **Antes de clonar, confirmar de QUEM é a voz.** Um arquivo chegou aqui como "vídeo dele" e era de
outra pessoa — um comentarista que **denuncia** o esquema que o vídeo citava. Clonar teria posto
palavras na boca de um terceiro que não autorizou nada, e ainda invertido o lado dele. Transcrever
antes de clonar custa nada e é o que pega isso. Efeito sonoro e trechos de LEITURA em voz alta
também contaminam a clonagem — recortar só fala espontânea.
