# Changelog

Histórico de entregas mergeadas em `main`. Ordem cronológica reversa.

---

## [2026-06-06] Análise completa de 11 POCs + faxina geral + índice de repositórios

- Limpeza do template: 20 arquivos obsoletos removidos (-3458 linhas)
- `scripts/` canônico: `checkup-sandbox-claude.sh` movido de `.scripts/`
- `CLAUDE.md` reescrito, `GUIA-OPERACIONAL.md` patcheado
- 34 repositórios wagnerpv renomeados com prefixos de maturidade (POC-, MVP-, HOLD-, legado-, producao-, BACKUP-, 00-)
- `00-ECO00` criado: índice de repositórios com REPOS.md, estrutura canônica, scripts
- 32/33 descrições de repos aplicadas via API
- 11 POCs analisados — artefatos críticos identificados:
  - `POC-astro00` → `vendor/eco00-astro-runtime/` (runtime SSR WASM, 94% parity Astro v5)
  - `POC-ssr-foundations` → `vendor/eco00-ssr-foundations/v1.0.0/` (framework SSR + RBAC)
  - `POC-eco00-event-system` → segunda prioridade ativa (NATS/JetStream + SSE)
  - `POC-ssr-templates-engine` → 5 packages para vendor/ (html-parser, h-elements, etc.)
  - `POC-app00ui-astro` → design system theme-vars.css

**Branch:** work-session-20260606-1930
**PR:** #44

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
