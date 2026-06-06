# Changelog

Histórico de entregas mergeadas em `main`. Ordem cronológica reversa.

---

## [2026-06-06] Auditoria e limpeza do repositório template

- Removidos 20 arquivos obsoletos: análises de referência, artefatos de sessão, lixo acumulado (-3458 linhas)
- `checkup-sandbox-claude.sh` movido de `.scripts/` para `scripts/` (canônico)
- `CLAUDE.md` reescrito: alinhado ao workflow atual, sem referências a arquivos deletados
- `GUIA-OPERACIONAL.md` patcheado: todas referências obsoletas substituídas

**Branch:** work-session-20260606-1930
**PR:** #43

## [2026-06-06] Canonização de work sessions e padrões de repositório

- Estrutura canônica de sessões: `work-sessions/YYYYMMDD-HHNN/scratchpad.md`
- `CONTRIBUTING.md` com protocolo completo (branch naming, session lifecycle, CHANGELOG format)
- `REPO-STATUS.md` template + `scripts/repo-status.sh` adaptado (sem hardcode de repo)
- `tarefas-log.md` e `tarefas-retomada.md` removidos (obsoletos)

**Branch:** chore/canonize-work-session-structure
**PR:** #41

## [2026-06-06] Filesystem conventions standard

- `docs/standards/FILESYSTEM-CONVENTIONS.md` — documento atômico, autossuficiente
- 8 subdiretórios canônicos: config, secrets, data, state, cache, logs, tmp, run
- Naming: `/home/claude/envs/dev-<7chars>/`
- Inclui scripts de setup/cleanup, policy de permissões, variáveis de ambiente padrão

**Branch:** docs/filesystem-conventions
**PR:** #40

---

<!-- Adicionar entradas aqui seguindo o formato abaixo:

## [YYYY-MM-DD] Título da entrega

- O que foi feito
- Pacote ou feature entregue
- Testes: X/X ✅

**Branch:** feat/nome-semantico
**PR:** #N

-->
