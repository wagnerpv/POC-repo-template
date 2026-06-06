# Work Sessions

Registro de sessões de trabalho do agente neste repositório.

## Estrutura

```
work-sessions/
└── YYYYMMDD-HHNN/          ← Uma pasta por sessão (timestamp Brasil, -03:00)
    └── scratchpad.md        ← Notas, progresso e tarefas da sessão
```

## Naming Convention

- **Formato:** `YYYYMMDD-HHNN`
- **Fuso:** Brasil (-03:00)
- **Exemplo:** `20260606-1700` (06 de junho de 2026, 17:00 Brasil)

Coerente com o nome da branch de trabalho: `work-session-YYYYMMDD-HHNN`

## Ciclo de Vida de uma Sessão

1. **Início:** Criar pasta `work-sessions/YYYYMMDD-HHNN/` e `scratchpad.md`
2. **Durante:** Atualizar `scratchpad.md` com progresso e decisões
3. **Fim:** Resultado final da sessão vai para `CHANGELOG.md`

## scratchpad.md

Cada sessão tem um `scratchpad.md` com:

- Status da sessão (início, branch, repo)
- Tarefas planejadas
- Progresso (checklist)
- Decisões tomadas
- Bloqueadores

## Resultado Final → CHANGELOG.md

Ao fechar a sessão, o que foi entregue deve ser registrado no `CHANGELOG.md` raiz.
O `scratchpad.md` é atômico e pertence à sessão — o `CHANGELOG.md` é o histórico global do repositório.

## Observação

O estado ao vivo do repositório (PRs abertos, issues, último commit) está em `REPO-STATUS.md`,
gerado automaticamente por `scripts/repo-status.sh`.
