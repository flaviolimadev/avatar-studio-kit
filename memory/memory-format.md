---
name: memory-format
description: Como escrever uma memória — um arquivo por fato, com frontmatter e links entre fatos
metadata:
  type: reference
---

Cada memória é **um arquivo = um fato**, em `memory/`, com este frontmatter:

```markdown
---
name: <slug-curto-em-kebab-case>
description: <resumo em uma linha — é o que decide se este fato é relevante na hora de recuperar>
metadata:
  type: user | feedback | project | reference
---

<o fato. Ligue fatos com `nome`.>
```

Tipos: **user** (quem é o cliente e o que ele prefere) · **feedback** (como trabalhar aqui, com o
porquê) · **project** (trabalho em andamento, restrições) · **reference** (convenções, presets,
armadilhas técnicas, ponteiros).

Regras:
- Procure um arquivo que já cubra o fato — atualize em vez de duplicar.
- Ligue fatos com ``nome``; depois de criar/editar, ajuste a linha em `MEMORY.md`.
- Não guarde o que o `CLAUDE.md`, o `MODELOS.md` ou a estrutura de pastas já registram.
- **Aqui um fato vale memória quando:** um preset travou num valor e há um porquê; uma armadilha
  custou tempo ou crédito; o cliente decidiu algo de formato; um custo real foi medido.
