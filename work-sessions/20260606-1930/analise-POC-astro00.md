# Análise — POC-astro00

**Data:** 2026-06-06
**Status:** Runtime SSR customizado para Astro — 94% feature parity com Astro v5

---

## O que é

**Este é o coração técnico do eco00.** Runtime SSR próprio que usa `@astrojs/compiler` (WASM) + Bun sem depender do toolchain Astro completo (sem Vite, sem adapter, sem `astro` em runtime).

Objetivo: SSR com Astro compiler + Bun, totalmente sob controle do eco00.

## Stack

- Bun runtime
- `@astrojs/compiler` (WASM) — só o compiler, não o framework
- TypeScript strict
- Bun workspaces monorepo

## Estrutura

```
POC-astro00/
├── packages/astro-runtime/     ← Package principal (o artefato)
│   ├── router.ts               ← Discovery de páginas + render por request
│   └── runtime/
│       ├── index.ts            ← Exports do compiler (internalURL etc)
│       ├── escape.ts           ← HTMLString, escapeHTML, markHTMLString
│       ├── util.ts             ← addAttribute, spreadAttributes
│       ├── context.ts          ← RenderContext + objeto Astro real
│       ├── render.ts           ← renderTemplate, createComponent, renderToString
│       ├── cookies.ts          ← Cookie handling
│       ├── session.ts          ← Session management
│       ├── markdown.ts         ← Markdown rendering
│       ├── frontmatter.ts      ← Frontmatter parsing
│       └── sequence.ts         ← Render sequence helpers
├── server/
│   ├── index.ts                ← Bun.serve + createAstroRequestRenderer
│   ├── compiled.ts             ← Compiled pages server
│   └── node.ts                 ← Node.js compat server
├── src/                        ← Páginas de teste/demo
├── docs/agente/                ← Guias operacionais do agente
│   ├── PROTOCOLO.md
│   ├── SE-AGENT-OPERATIONAL-GUIDE.md
│   └── PR-PRE-SUBMISSION-CHECKLIST.md
└── .github/workflows/test.yml  ← CI com testes automáticos
```

## Características Técnicas

- **94% feature parity** com Astro v5 SSR
- Routing: `src/pages/` com `[slug].astro`, `[...slug].astro`
- RenderContext com objeto Astro real (props, slots, cookies, session)
- HTMLString seguro (escape automático)
- Suporte a markdown em pages
- WASM compiler (não precisa de Node.js/Vite)

## Avaliação

**Maturidade:** Alta (testes, CI, docs completas)
**Relevância para eco00:** CRÍTICA — é o `@eco00/astro-runtime` canonical
**Destino:** Este é o artefato mais importante. Deve virar `packages/@eco00/astro-runtime` no monorepo

## Artefatos a Extrair

| Artefato | Destino |
|----------|---------|
| `packages/astro-runtime/` (completo) | `vendor/eco00-astro-runtime/v1.x.x/` |
| `docs/agente/PROTOCOLO.md` | Referência para CLAUDE.md/CONTRIBUTING.md |
| `docs/agente/PR-PRE-SUBMISSION-CHECKLIST.md` | Incorporar em CONTRIBUTING.md |
| `.github/workflows/test.yml` | Template de CI para outros repos |

## Observações

- `docs/agente/` tem guias operacionais valiosos que complementam o que estamos construindo
- CI pipeline com `bun test` é o padrão a seguir em todos os repos eco00
- A abordagem de usar só o compiler (WASM) sem o framework completo é a direção estratégica do eco00
