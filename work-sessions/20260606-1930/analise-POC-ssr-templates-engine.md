# Análise — POC-ssr-templates-engine

**Data:** 2026-06-06
**Status:** Engine de templates HTML SSR para Bun — 195/195 testes ✅

---

## O que é

Sistema funcional de templating HTML para Bun. Packages: html-parser, h-elements, form-helpers, form-handlers, table-controller. É o repositório ativo de trabalho desta temporada.

## Stack

- Bun 1.3.14 workspaces
- TypeScript strict
- SSR (Server-Side Rendering)
- Custom HTML → AST parser
- bun:test (195/195 testes)

## Estrutura

```
POC-ssr-templates-engine/
├── packages/@eco00/
│   ├── html-parser/         ← Tokenizer + AST Builder + Transpiler (41 tests)
│   ├── h-elements/          ← Functional API para HTML elements (46 tests)
│   ├── form-helpers/        ← HTML escaping, field mapping (33 tests)
│   ├── form-handlers/       ← POST request parsing (18 tests)
│   └── table-controller/    ← DOM manipulation helpers (28 tests)
├── POCs/poc-mestre-detalhe-html/  ← POC concreta
├── sessions/                ← Sessões de trabalho (YYYYMMDD-HHNN)
├── scripts/repo-status.sh   ← Script canônico de status
├── REPO-STATUS.md           ← Gerado por script
├── CHANGELOG.md
└── CONTRIBUTING.md
```

## Artefatos Críticos

### `packages/@eco00/` — 5 packages
Todos os packages são candidatos para `vendor/` ou `packages/` do template:
- `html-parser` — parser customizado HTML → AST
- `h-elements` — API funcional para criar elementos HTML
- `form-helpers` + `form-handlers` — CRUD form handling
- `table-controller` — tabelas dinâmicas

### `sessions/YYYYMMDD-HHNN/` — Padrão de Sessões
Este é o repositório que originou o padrão de work-sessions que estamos canonizando. Branch `session-YYYYMMDD-HHNN` (que ajustamos para `work-session-YYYYMMDD-HHNN`).

### `scripts/repo-status.sh`
Script de geração de REPO-STATUS.md — foi adaptado para o template.

## Avaliação

**Maturidade:** Alta (195/195 testes, em uso ativo)
**Relevância para eco00:** Alta — packages de templating HTML
**Status:** Repositório ativo desta temporada

## Artefatos a Extrair

| Artefato | Destino |
|----------|---------|
| `packages/@eco00/html-parser` | `vendor/eco00-html-parser/v1.x.x/` |
| `packages/@eco00/h-elements` | `vendor/eco00-h-elements/v1.x.x/` |
| `packages/@eco00/form-helpers` | `vendor/eco00-form-helpers/v1.x.x/` |
| `packages/@eco00/form-handlers` | `vendor/eco00-form-handlers/v1.x.x/` |
| `packages/@eco00/table-controller` | `vendor/eco00-table-controller/v1.x.x/` |

## Observações

- Issues abertas (#14-#41) são o backlog atual de desenvolvimento
- POC mestre-detalhe-html é o exemplo mais completo de uso dos packages
- É aqui que os padrões de session de trabalho foram inventados antes de serem canonizados
