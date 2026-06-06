# Análise — POC-app00ui-astro

**Data:** 2026-06-06
**Status:** UI component library para Astro — v1.4.0

---

## O que é

Monorepo Bun workspaces com biblioteca de componentes UI para Astro (`app00ui-astro`) + app de exemplo. Segue arquitetura atoms → molecules → organisms. CSS via custom properties (sem Tailwind).

## Estrutura

```
POC-app00ui-astro/
├── packages/app00ui-astro/
│   ├── src/
│   │   ├── components/
│   │   │   ├── atoms/      (Button, Checkbox, Icon, Input, Radio, Select, Textarea)
│   │   │   ├── molecules/  (CrudListFilters, Pagination, DarkModeToggle, NavToggle, SidebarItem)
│   │   │   └── organisms/  (AppShell, CrudDataTable, CrudListView, Main, Sidebar, Topbar)
│   │   └── styles/
│   │       ├── theme-vars.css     ← Design tokens (CSS custom properties)
│   │       ├── colors.css
│   │       ├── typography.css
│   │       ├── spacing.css
│   │       ├── forms.css
│   │       ├── tables.css
│   │       ├── data-tables.css
│   │       ├── display.css
│   │       └── responsive.css
│   └── stories/            ← Visual docs (Astro pages)
└── apps/example/           ← Demo app
```

## Artefatos Críticos

### `theme-vars.css` — Design System Canônico
CSS custom properties como design tokens. É a base do sistema visual eco00. Artefato de alto valor.

### Arquitetura de Componentes
- Atomic design: atoms → molecules → organisms
- Padrão `AppShell` + `Sidebar` + `Topbar` + `Main` — shell canônico para apps CRUD
- `CrudListView` + `CrudDataTable` — padrões CRUD reutilizáveis

### CHOICES_MADE_BY_DEVELOPERS.md
Documento de decisões de design. Valioso como referência de ADR (Architecture Decision Record).

## Stack

- Bun workspaces monorepo
- Astro (componentes .astro)
- CSS custom properties (sem framework CSS externo)
- Sem TypeScript nos componentes (apenas index.ts para exports)

## Avaliação

**Maturidade:** Alta (v1.4.0, stories, exemplo funcional)
**Relevância para eco00:** Alta — é o design system de referência
**Destino sugerido:** Evoluir para `@eco00/ui` como package canônico

## Artefatos a Extrair

| Artefato | Destino |
|----------|---------|
| `src/styles/theme-vars.css` | `vendor/eco00-app00ui/` ou `packages/@eco00/ui/` |
| `src/components/` (completo) | `packages/@eco00/ui/src/components/` |
| `CHOICES_MADE_BY_DEVELOPERS.md` | Referência para ADRs eco00 |
| Shell pattern (AppShell+Sidebar+Topbar) | Template de app CRUD |
