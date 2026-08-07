## A estrutura (meta)

- [Roteamento de tarefas](roteamento-de-tarefas.md) — toda ação passa pelo dispatcher e só roda com dono declarado
- [Especialização sob demanda](especializacao-sob-demanda.md) — recorte novo cria especialista novo, antes de executar

- [Como funciona](how-it-works.md) — a estrutura em uma página: catálogo → agentes → memória → verificador → grafo
- [Formato da memória](memory-format.md) — um arquivo = um fato, com frontmatter e links `[[nome]]`
- [O verificador](the-check.md) — `scripts/check.mjs` cruza catálogo ↔ agentes ↔ memória e aponta desvios
- [O loop de auto-aprendizado](the-loop.md) — toda entrega passa por memória, agentes e verificação
- [O loop é automático](auto-loop-hooks.md) — três hooks do harness carregam, relembram e barram o encerramento com desvio


## O pipeline

- [Safe zones](safe-zones.md) — nada essencial no topo 200 px nem na base 300 px

## Geração por IA

- [CLI do Higgsfield](higgsfield-cli.md) — instalação, workspace, comandos e a armadilha do login localhost
- [Job cobrado é recuperável](job-cobrado-recuperavel.md) — se o --wait desiste mas o crédito saiu, baixe pelo job_id em vez de re-gerar
- [Token do Higgsfield rotaciona](token-do-higgsfield-rotaciona.md) — copiar credentials.json por cima de sessão viva MATA a autenticação
- [Modelo de custos](cost-model.md) — custos reais medidos; imagem é 4x mais barata que clipe
- [Armadilha do audio-references](audio-references-gotcha.md) — o Seedance reescreve a fala; gerar sem áudio
- [Âncoras de personagem](character-anchors.md) — um retrato reusado + voz TTS fixa por personagem
- [Cenário "gravando story"](cenario-story-do-cliente.md) — a imagem aprovada vira âncora; "instagram story" no prompt desenha a interface
- [TTS em português](portuguese-tts.md) — setup do Kokoro e do espeak-ng nesta máquina (sem Homebrew)
- [Vozes PT-BR no ElevenLabs](vozes-elevenlabs-ptbr.md) — Kokoro só rascunho; testar pronúncia antes de travar a voz
- [Voz com cara de IA](voz-com-cara-de-ia.md) — Higgsfield não expõe os controles do ElevenLabs; quem humaniza é o TEXTO (3→9 pausas)
- [Perfil de fala do cliente](perfil-de-fala-do-cliente.md) — metade do que soa "IA" é o TEXTO; medir bordões da transcrição real
- [ElevenLabs incluso](tts-elevenlabs.md) — vem dentro do Higgsfield por 0,3 crédito; quando usar em vez do Kokoro
- [Reuso do voice_id](voice-id-reuso.md) — a voz do personagem é um id reutilizável: fala qualquer texto, sempre igual
- [Diálogo multi-personagem](dialogo-multi-personagem.md) — dois personagens fiéis no mesmo quadro com dois image-references

## Plataforma

- [Influencer falando](influencer-falando.md) — lip-sync com wan2_7; o prompt precisa pedir que ela fale
- [Influencer não chega na cena](influencer-nao-chega-na-cena.md) — três causas empilhadas escondiam a influencer criada; nenhuma reclamava
- [Lip-sync: Veo vs Wan](lipsync-veo-vs-wan.md) — só o Veo 3.1 sincroniza de verdade; como testar sem se enganar
- [Seedance 2.0 com áudio nativo](seedance-2-audio-nativo.md) — 1 imagem + prompt com a fala = clipe falado num passo; até 9 referências
- [Rosto que não pisca](rosto-que-nao-pisca.md) — Seedance só pisca se o prompt pedir; iterar em 480p fast custa 3× menos
- [Clipe longo em beats](clipe-longo-em-beats.md) — acima de 8s o prompt precisa dizer QUANDO cada coisa acontece, não como o sujeito é
