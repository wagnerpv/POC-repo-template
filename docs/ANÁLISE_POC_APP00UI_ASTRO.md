# Análise: POC-app00ui-astro

**Repositório:** `POC-app00ui-astro`
**Versão:** 1.4.0
**Data:** 2026-06-04

## Descrição
Biblioteca de componentes UI para Astro — Monorepo com Bun workspaces.
Atomic Design: Atoms → Molecules → Organisms.

## Stack
- **Runtime:** Bun workspaces
- **UI:** Astro components (`.astro`)
- **Icons:** `lucide-astro` v0.460.0
- **CSS:** Custom Properties (Tailwind-like, sem bundler)
- **Sem:** React, Tailwind JIT, TypeScript nos componentes

## Estrutura Real
```
packages/app00ui-astro/
├── src/
│   ├── index.ts               ← Exports públicos
│   ├── components/
│   │   ├── atoms/             ← Button, Input, Select, Textarea, Checkbox, Radio, Icon
│   │   ├── molecules/         ← NavToggle, SidebarItem, DarkModeToggle, CrudListFilters, CrudListPagination
│   │   └── organisms/         ← AppShell, Topbar, Sidebar, Main, CrudListView, CrudDataTable
│   └── styles/
│       ├── theme-vars.css     ← Design tokens (cores, espaçamento, tipografia, breakpoints)
│       ├── colors.css
│       ├── spacing.css
│       ├── display.css
│       ├── typography.css
│       ├── responsive.css
│       ├── forms.css
│       ├── tables.css
│       ├── data-tables.css
│       └── index.css          ← Import de todos os estilos
├── stories/                   ← Visual documentation (Astro pages)
│   └── pages/forms.astro, datatable.astro, crudview.astro
├── CHOICES_MADE_BY_DEVELOPERS.md ← 20 decisões documentadas
└── package.json

apps/example/                  ← Demo app usando a biblioteca
```

## API Pública (src/index.ts)

### Atoms
```typescript
Button, Input, Select, Textarea, Checkbox, Radio, Icon
```

### Molecules
```typescript
NavToggle, SidebarItem, DarkModeToggle, CrudListFilters, CrudListPagination
```

### Organisms
```typescript
AppShell, Topbar, Sidebar, Main, CrudListView, CrudDataTable
```

### Uso
```astro
import { Button, CrudDataTable, AppShell } from 'app00ui-astro';
import 'app00ui-astro/styles';
```

## Design Tokens (theme-vars.css)

Sistema completo de CSS Custom Properties:

- **Breakpoints:** Tailwind standard (640, 768, 1024, 1280, 1536px)
- **Colors:** Gray scale (50–900), primary/success/warning/danger/info (+ dark variants)
- **Spacing:** Tailwind scale base 4px (space-1 a space-32)
- **Typography:** font-family, font-size (xs–4xl), font-weight, line-height
- **Icons:** icon-xs/sm/md/lg/xl (16–48px)
- **Shadows:** sm/base/md/lg/xl
- **Border Radius:** none/sm/base/md/lg/xl/2xl/full
- **Transitions:** fast/base/slow (150/200/300ms)
- **Layout:** sidebar-width, topbar-height, main-max-width, z-index scale

### Dark Mode
- `[data-theme='dark']` attribute override
- `@media (prefers-color-scheme: dark)` fallback
- Grays invertidos (não apenas escurecidos)
- `prefers-reduced-motion`: transitions zeradas

## Decisões de Engenharia (20 documentadas)

| # | Decisão | Escolha |
|---|---------|---------|
| 1 | CSS Utilities | Custom Properties (não Tailwind JIT) — sem bundler lock-in |
| 2 | Styling | Scoped `.astro` + external utilities |
| 3 | Icons | `lucide-astro` (460+ icons, tree-shakeable) |
| 4 | NavToggle | `aria-expanded` + minimal JS (não CSS checkbox hack) |
| 5 | Sidebar | Drawer overlay no mobile (não push layout) |
| 6 | AppShell | Props pattern (não Astro slots) |
| 7 | Breakpoints | Tailwind standard como CSS custom properties |
| 8 | Accessibility | ARIA attributes (aria-expanded, aria-controls, aria-hidden, aria-current) |
| 9 | File structure | Flat styles/ por categoria |
| 10 | Package name | `app00ui-astro` sob scope `@box00` |
| 11 | TypeScript | Apenas em src/index.ts — componentes em JS puro |
| 12 | Testing | Sem unit tests — visual testing via Stories |
| 13 | Dark mode | V2 (placeholder CSS em V1) |
| 14 | Animation | prefers-reduced-motion respeitado globalmente |
| 15 | Export strategy | 3 paths: `.`, `./styles`, `./components` |
| 16 | Dark mode impl | data-theme + localStorage override (V1.1) |
| 17 | Form atoms | 5 componentes com WCAG AA (V1.1) |
| 18 | Organisms | Topbar/Sidebar/Main com `display: contents` |
| 19 | Dark mode colors | Inversão real (não apenas escurecimento) |
| 20 | Tests V1.1 | Accessibility checklist + contrast ratio validation |

## Artefatos Candidatos para Template

| Artefato | Importância | Ação |
|----------|-------------|------|
| `theme-vars.css` — Design tokens completos | 🔴 Crítico | Adotar como design system base |
| Atomic Design structure (atoms/molecules/organisms) | 🔴 Crítico | Adotar como estrutura padrão de UI |
| CHOICES_MADE_BY_DEVELOPERS.md pattern | 🟡 Importante | Adotar como template de decisões |
| CSS Custom Properties strategy (sem Tailwind JIT) | 🔴 Crítico | Alinha com stack canônico (sem bundler lock-in) |
| `lucide-astro` como padrão de icons | 🟡 Importante | Adotar como biblioteca de ícones |
| Stories pattern (Astro pages como documentação visual) | 🟡 Importante | Adotar para documentação de componentes |
| Dark mode via `[data-theme]` + media query | 🟡 Importante | Adotar como padrão de tema |
| ARIA accessibility patterns | 🔴 Crítico | Adotar como baseline de acessibilidade |
| Export strategy (3 paths) | 🟡 Importante | Adotar para packages de UI |

## Notas

- Sem Tailwind — CSS Custom Properties puras. Alinha com princípio "sem bundler lock-in"
- Componentes em `.astro` puro (não TSX) — decisão consciente e documentada
- `display: contents` nos organismos é padrão elegante (semântica sem layout overhead)
- `CHOICES_MADE_BY_DEVELOPERS.md` é um padrão excelente de documentação de decisões
