---
name: voice-id-reuso
description: O voice_id é a identidade sonora reutilizável — a mesma voz fala qualquer texto, em qualquer episódio, sem custo de setup
metadata:
  type: reference
---

Confirmado por teste em 2026-07-25: um `voice_id` do Higgsfield é reusável indefinidamente. A mesma
voz preset ("John") gerou uma fala de novela raivosa, uma receita de pão de queijo e uma manchete de
jornal — texto exato em todas (conferido por transcrição), mesma identidade sonora.

**Consequência prática:** a voz do personagem não é "aquele arquivo de áudio", é o **`voice_id`
registrado na bíblia da série**. Guardado o id, o personagem fala qualquer roteiro futuro, em
qualquer episódio, sem re-treino e sem custo de setup — só os 0,3 crédito da fala.

**Regra da série:** cada personagem tem UM `voice_id` fixo. Trocar o id = trocar o ator.

**Limites:** 5.000 caracteres por chamada no elevenlabs/vibe_voice/cozy_voice, 10.000 no minimax,
15.000 no seed_speech. Falas de novela ficam muito abaixo disso — dividir por fala, nunca mandar o
roteiro inteiro numa chamada só (a divisão por fala é o que permite montar o vaivém do diálogo).

**Vozes clonadas (`voice_type: element`) existem no modelo, mas a CLI só lista e lê vozes** — não há
comando de clonagem. A conta hoje tem 57 vozes preset e 0 element. Para uma voz clonada (a voz do
próprio cliente, por exemplo), teria que ser criada pelo site e depois apareceria em `voices list`.

**Trocar a voz do personagem NÃO invalida o áudio já gerado.** A retomada do worker pula a fala se
o ARQUIVO existe (`if (fs.existsSync(wav) || fs.existsSync(mp3)) continue;`) — a trava é por nome de
arquivo, não por voz. Pego em 2026-07-26: dei `voice_id` do ElevenLabs a uma personagem que tinha
falado em Kokoro e reproduzi; sem apagar os `.wav` antigos o vídeo teria saído com a voz de rascunho
e **ninguém perceberia até ouvir**. Ao trocar a voz, `rm` o áudio daquele episódio antes de
reproduzir.

**Voz já validada se reusa entre projetos.** A Luna (`375a3398-…`) foi testada em português numa
série e foi direto para a personagem de outra — o `voice_id` é da conta, não do projeto, e
revalidar seria pagar de novo pelo que já se sabe ([[vozes-elevenlabs-ptbr]]).

Ver [[tts-elevenlabs]], [[character-anchors]].
