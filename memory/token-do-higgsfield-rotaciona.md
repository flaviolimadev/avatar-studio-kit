---
name: token-do-higgsfield-rotaciona
description: o token do Higgsfield rotaciona — copiar credentials.json por cima de uma sessão viva MATA a autenticação
metadata:
  type: reference
---

O CLI do Higgsfield autentica por **OAuth PKCE** e guarda a sessão em
`~/.config/higgsfield/credentials.json` (`access_token`, `refresh_token`, `expires_at`). Quando o
`access_token` vence, **o CLI renova sozinho e reescreve o arquivo — consumindo o `refresh_token`
antigo**, que deixa de valer.

`HIGGSFIELD_CREDENTIALS` no `.env` é o conteúdo desse arquivo. É uma **fotografia**, não uma chave.

**O que aconteceu em 2026-07-29:** um script de instalação escrevia a fotografia do `.env` por cima
do `credentials.json`. A sequência foi:

1. comparei `.env` × arquivo vivo — idênticos, token vencido às 01:07;
2. rodei um comando qualquer → o CLI **renovou** e gravou um token novo (a consulta de custo passou);
3. rodei o instalador → ele **sobrescreveu o token novo com o vencido do `.env`**;
4. o refresh antigo já tinha sido consumido → **tudo parou de autenticar**, e só voltou com
   `higgsfield auth login` pelo navegador.

**Why:** o modo de falha é traiçoeiro porque a comparação "os dois arquivos são iguais" dá verde um
minuto antes de a cópia virar veneno. E a mensagem de erro (`request failed (no response received)`)
parece problema de rede, não de credencial.

**How to apply:**
- **Nunca sobrescrever um `credentials.json` que já existe.** A semente do `.env` serve para o
  PRIMEIRO login de uma máquina nova, e só. `[ -s "$CRED" ] && preservar`.
- **A mesma semente não serve para duas máquinas.** Assim que uma renovar, a fotografia morre para
  todas as outras. Máquina nova = `higgsfield auth login` próprio, ou uma conta separada.
- Um `.env` versionado em git envelhece sozinho: o token que está lá hoje pode já não valer amanhã.
  Ver `deploy-verificavel` — mesma classe de erro: dar por bom o que não foi verificado.
