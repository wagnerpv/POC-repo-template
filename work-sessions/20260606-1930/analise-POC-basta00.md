# Análise — POC-basta00

**Data:** 2026-06-06
**Status:** IDP (Internal Developer Platform) monorepo — referência de estrutura

---

## O que é

Monorepo IDP completo — é a referência de arquitetura e estrutura para o eco00. Não tem código de produção ainda mas tem uma estrutura de pastas e documentação muito madura que serviu de base para o eco00-monorepo-template.

## Estrutura

```
POC-basta00/
├── apps/           ← Deployable applications
├── clis/           ← Command-Line tools
├── packages/       ← Shared libraries
├── services/       ← Backend daemons
├── mcps/           ← MCP servers para AI agents
├── integrations/   ← Third-party adapters
├── incoming-original/  ← Inbox de artefatos brutos
├── wip/            ← Work in progress
│   └── ssr-foundations/  ← @eco00/ssr-foundations (WIP)
├── operations/     ← Planejamento, backlog
├── standards/      ← ADRs, runbooks, convenções
│   ├── adrs/
│   │   └── ADR-001-bun-over-node.md
│   ├── conventions/
│   │   ├── architecture.md
│   │   └── repository-structure.md
│   └── processes/
│       ├── pr-review.md
│       ├── handover-validation.md
│       └── tasks.md
├── onboarding/     ← Documentação de onboarding
├── academy/        ← Material de treinamento
├── docs/           ← Documentação técnica
└── .agent/         ← Diretivas para AI agent
    └── skills/     ← Skills (matt-pocock: tdd, grill-me, etc.)
```

## Artefatos Críticos

### `wip/ssr-foundations/` — @eco00/ssr-foundations
O package mais importante: implementação de SSR foundations. Tem CHANGELOG, HANDOVER, engineering-decisions e exemplos. **Este é o candidato para `vendor/eco00-ssr-foundations/`.**

### `standards/` — ADRs e Convenções
- `ADR-001-bun-over-node.md` — Decision record de usar Bun
- `conventions/architecture.md` — Arquitetura eco00
- `conventions/repository-structure.md` — Estrutura de repositório
- `processes/pr-review.md` — Processo de PR review
- `processes/tasks.md` — Gestão de tarefas

### `.agent/skills/` — Skills do Agente
Skills de Matt Pocock: tdd, grill-me, caveman. São metodologias de desenvolvimento TypeScript.

### `incoming-original/` — Documentos Originais
PDFs e docs originais (BOX00 v1.1, DataStar, Pangolin, etc.)

## Avaliação

**Maturidade:** Média (estrutura madura, packages vazios ainda)
**Relevância para eco00:** Alta — é a referência de IDP estrutural
**Relação com template:** É o "pai" do eco00-monorepo-template

## Artefatos a Extrair

| Artefato | Destino |
|----------|---------|
| `wip/ssr-foundations/` | `vendor/eco00-ssr-foundations/v1.0.0/` |
| `standards/adrs/` | `docs/standards/adrs/` no template |
| `standards/conventions/repository-structure.md` | Referência para README/CONTRIBUTING |
| `.agent/skills/` | `docs/agent-skills/` para referência |

## Observações

- `clis/`, `services/`, `mcps/`, `integrations/` ainda vazios — estrutura proposta para futuro
- `OWNERS.md` é um padrão interessante: define ownership por pasta
- `incoming-original/` → `wip/` → `packages/` é o fluxo de promoção de artefatos — bom padrão
