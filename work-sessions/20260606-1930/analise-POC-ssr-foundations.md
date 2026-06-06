# Análise — POC-ssr-foundations

**Data:** 2026-06-06
**Status:** Framework SSR production-grade — `@box00/ssr-monoliths-foundations` v0.1.0 MVP

---

## O que é

**Este é o framework SSR canônico do eco00.** Production-grade SSR framework em Bun com filesystem routing, middleware pipeline e RBAC built-in. Usa Preact JSX para rendering, compatível com routing Astro, zero bundler.

Nota: Publicado como `@box00/ssr-monoliths-foundations` mas será rebranded para `@eco00/ssr-foundations`.

## Stack

- Bun runtime
- Preact JSX (rendering)
- Filesystem routing (Astro-compatible)
- Zero bundler
- TypeScript strict

## Estrutura

```
POC-ssr-foundations/
├── src/
│   ├── index.ts              ← Entry point + exports
│   ├── server.ts             ← startSsrServer()
│   ├── astro/object.ts       ← Astro compat primitives
│   ├── error/                ← Error pages (defaults, custom)
│   ├── filesystem/           ← Discovery, paths, validator
│   ├── http/dispatcher.ts    ← HTTP request dispatch
│   ├── middleware/
│   │   ├── pipeline.ts       ← Middleware pipeline
│   │   └── rbac.ts           ← RBAC (Role-Based Access Control)
│   ├── rendering/
│   │   ├── component.ts      ← Component rendering
│   │   ├── frontmatter.ts    ← Frontmatter parsing
│   │   ├── layout.ts         ← Layout rendering
│   │   └── markdown.ts       ← Markdown rendering
│   ├── routing/
│   │   ├── router.ts         ← Main router
│   │   ├── parameters.ts     ← Route params ([slug], [...slug])
│   │   └── precedence.ts     ← Route precedence rules
│   └── specialists/logger/   ← Logger
├── examples/
│   ├── blog-app/             ← Blog com auth, middleware, layouts
│   └── taskboard/            ← Taskboard com RBAC
├── engineering-decisions.md  ← ADR do framework
├── HANDOVER.md               ← Handover completo
└── CHANGELOG.md
```

## API Principal

```typescript
import { startSsrServer } from '@box00/ssr-monoliths-foundations';

const server = await startSsrServer({
  appBaseFolder: import.meta.dir,
  port: 3000,
});
```

App structure:
```
my-app/
├── index.ts       ← entry
├── boot.ts        ← setup (DB, auth, etc.)
├── middleware.ts  ← global middleware
├── pages/         ← filesystem routing (.tsx)
├── layouts/       ← layout components
├── error-pages/   ← 404, 403, 500
└── public/        ← static files
```

## Avaliação

**Maturidade:** Alta (MVP completo, exemplos funcionais, HANDOVER completo)
**Relevância para eco00:** CRÍTICA — é o framework SSR canônico
**Destino:** `vendor/eco00-ssr-foundations/v1.0.0/` (já estava identificado como artefato prioritário)

## Artefatos a Extrair

| Artefato | Destino |
|----------|---------|
| `src/` completo | `vendor/eco00-ssr-foundations/v1.0.0/src/` |
| `examples/` | `vendor/eco00-ssr-foundations/v1.0.0/examples/` |
| `engineering-decisions.md` | `docs/standards/adrs/` |
| `HANDOVER.md` | Referência de documentação de handover |

## Observações

- Já existe placeholder `vendor/eco00-ssr-foundations/v1.0.0/` no template — pronto para receber
- `engineering-decisions.md` é um ADR nativo do framework — padrão a seguir
- RBAC built-in é diferencial: roles e permissions na camada de routing
- Middleware pipeline é o padrão eco00 para auth, logging, etc.
