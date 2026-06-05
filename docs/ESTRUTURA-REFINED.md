# Estrutura Refinada — eco00-monorepo-template

**Baseada em:** POC-astro00  
**Data:** 2026-06-05  
**Status:** Proposta para implementação

---

## Princípios

1. **Organização por Tipo, Não por Projeto**
   - `src/` → código-fonte do runtime/core
   - `apps/` → aplicações (full-stack, SSR, APIs)
   - `packages/` → packages reutilizáveis
   - `vendor/` → dependencies versionadas
   - `sandbox/` → ambientes isolados de teste
   - `docs/` → documentação
   - `scripts/` → scripts operacionais
   - `tests/` → testes do projeto (não de packages)

2. **Nomes Sempre em Minúsculas**
   - Nunca usar maiúsculas em nomes de pastas
   - Exemplo correto: `vendor/eco00-ssr-foundations/v1.0.0/`

3. **Estrutura Plana para vendor**
   - Nível 1: nome do package (ex: `eco00-ssr-foundations`)
   - Nível 2: versão (ex: `v1.0.0`)
   - Sem intermediários (`versions/`, `current`, `VERSION`)

---

## Estrutura Proposta

```
eco00-monorepo-template/
├── src/                        # Runtime/core do eco00
│   ├── plugin.ts               # Bun plugin (ex: para compilação)
│   ├── router.ts               # Router/matching
│   ├── runtime/                # APIs de runtime
│   │   ├── context.ts
│   │   ├── render.ts
│   │   ├── session.ts
│   │   └── ...
│   ├── layouts/
│   └── pages/                  # Páginas de exemplo
│
├── apps/                       # Aplicações
│   ├── doc-site/              # Documentação da plataforma
│   └── [app-name]/            # Aplicações do template
│
├── packages/                   # Packages reutilizáveis
│   ├── @eco00/
│   │   ├── ssr-foundations/
│   │   ├── html-ui/
│   │   └── ...
│   └── [other scopes]/
│
├── vendor/                     # Dependencies versionadas
│   └── eco00-ssr-foundations/
│       ├── v1.0.0/
│       └── v1.1.0/
│
├── sandbox/                    # Ambientes isolados
│   ├── dev/
│   ├── test/
│   └── README.md
│
├── docs/                       # Documentação
│   ├── deploy/
│   ├── produto/
│   ├── runtime/
│   ├── api/
│   ├── guides/
│   ├── testes/
│   └── troubleshooting/
│
├── scripts/                    # Scripts operacionais
│   ├── checkup-sandbox-claude.sh
│   ├── setup-tools.sh
│   └── ...
│
├── tests/                      # Testes do projeto
│   ├── router.unit.test.ts
│   ├── runtime.unit.test.ts
│   ├── integration.test.ts
│   └── ...
│
├── .github/                    # GitHub actions/workflows
├── .vercel/                    # Vercel config
├── .local/                     # Local artifacts (gitignored)
├── public/                     # Assets estáticos
│
├── bun.lock
├── package.json
├── tsconfig.json
├── .gitignore
├── README.md
├── CONTRIBUTING.md
├── SETUP.md
└── [backlog files]
```

---

## Diferenças Chave vs. Antes

| Antes | Depois | Motivo |
|-------|--------|--------|
| Sem `src/` | + `src/` para runtime | Separação clara: runtime vs. aplicações |
| `.scripts/` | → `scripts/` | Convenção padrão (sem ponto) |
| Sem `tests/` | + `tests/` | Testes do projeto no nível raiz |
| Sem `public/` | + `public/` | Assets estáticos servidos |
| `.local/` (gitignored) | ✓ mantém | Local artifacts |
| `vendor/` complexo | `vendor/` simples (2 níveis) | Simplificar estrutura |
| `sandbox/` vazio | `sandbox/` com estrutura | Ambientes isolados (dev, test) |

---

## Convenções de Backlog

Copiar do astro00:

- `features-do-release.md` — backlog para release atual
- `features-fora-do-release.md` — backlog pós-release
- `features-fora-do-projeto.md` — fora de escopo deliberadamente

---

## Estrutura de `src/` (Exemplo: SSR Runtime)

```
src/
├── plugin.ts                   # Bun plugin para .astro
├── router.ts                   # Routing + matching
├── runtime/
│   ├── index.ts                # Exports publicos
│   ├── context.ts              # Astro global
│   ├── render.ts               # Template rendering
│   ├── session.ts              # Session management
│   ├── cookies.ts              # Cookie handling
│   ├── escape.ts               # HTML escaping
│   └── util.ts                 # Utilities
├── layouts/
│   └── base.astro
└── pages/
    ├── index.astro
    └── about/
        └── index.astro
```

---

## Estrutura de `apps/` (Exemplo: Full-Stack)

```
apps/
├── doc-site/                   # Documentação
│   ├── src/
│   │   ├── pages/
│   │   ├── layouts/
│   │   └── components/
│   ├── package.json
│   └── tsconfig.json
│
└── example-brcitas/            # App exemplo
    ├── src/
    │   ├── api/                # Hono API routes
    │   ├── pages/              # Astro SSR pages
    │   ├── db/                 # Database queries
    │   └── components/
    ├── package.json
    └── tsconfig.json
```

---

## Estrutura de `packages/` (Exemplo: Scoped)

```
packages/
├── @eco00/
│   ├── ssr-foundations/
│   │   ├── src/
│   │   ├── dist/
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   └── tests/
│   ├── html-ui/
│   ├── database/
│   └── ...
└── @custom/
    └── [other-scope]/
```

---

## Decisões Tomadas

1. **Nomes sempre minúsculos** — padronização, compatibilidade cross-platform
2. **`vendor/` em 2 níveis** — simplicidade vs. anterior `versions/current/VERSION`
3. **`src/` para runtime** — separação clara de código-core vs. apps
4. **`scripts/` em vez de `.scripts/`** — convenção standard (sem ponto)
5. **`tests/` na raiz** — testes do projeto centralizado (não dentro de packages)
6. **`sandbox/` estruturado** — dev, test, staging ambientes isolados
7. **Backlog em 3 arquivos** — clara separação: release / pós-release / fora-de-escopo

---

## Próximos Passos

1. Implementar esta estrutura no eco00-monorepo-template
2. Validar com brcitas (full-stack reference)
3. Documentar padrões em CONTRIBUTING.md
4. Criar templates para novos packages e apps

---

**Status:** Pronto para PR
