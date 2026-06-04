# Análise Detalhada de POC-basta00 - Artefatos de Código

**Data:** 2026-06-04
**Repositório Analisado:** `POC-basta00` (IDP monorepo — Internal Developer Platform)
**Objetivo:** Catalogar code artifacts reais e candidatos para incorporação ao template
**Foco:** Code artifacts, packages, patterns — NÃO applications, NÃO knowledge base

---

## NOTA IMPORTANTE

Os diretórios `/packages/`, `/services/`, `/clis/`, `/mcps/`, `/integrations/` estão **vazios** (apenas `.gitkeep` e `README.md`). POC-basta00 é uma **plataforma scaffolded** — a estrutura é o artefato. O código real está em `wip/ssr-foundations/`.

---

## 1. `@box00/ssr-foundations` — Pacote de SSR (CRÍTICO)

**Localização:** `wip/ssr-foundations/`
**Nome npm:** `@box00/ssr-foundations`
**Versão:** `0.1.0`
**Status:** WIP, pronto para extração como POC próprio

### Descrição
Framework SSR production-grade sobre Bun com filesystem routing, middleware pipeline e RBAC. Sem Astro em runtime. Sem Vite. Sem adapter. Bun nativo.

### Stack de Dependências
```json
dependencies:
  preact: ^10.19.0              ← UI rendering (renderToString)
  preact-render-to-string: ^6.2.0
  zod: ^3.22.0                  ← Validação de schemas

devDependencies:
  @types/bun: latest
  @types/node: ^20.0.0

peerDependencies:
  bun: >=1.0.0
```

### Estrutura de Código Real
```
wip/ssr-foundations/
├── src/
│   ├── index.ts                  ← Public API (entry point)
│   ├── types.ts                  ← Todos os tipos públicos
│   ├── server.ts                 ← startSsrServer() — bootstrap principal
│   ├── astro/
│   │   └── object.ts             ← buildAstroObject() — contexto por request
│   ├── error/
│   │   ├── defaults.ts           ← HTML defaults para 400/401/403/404/500
│   │   └── pages.ts              ← renderErrorPage()
│   ├── filesystem/
│   │   ├── discovery.ts          ← discoverPrimitives() — filesystem walker
│   │   ├── paths.ts              ← fileToRoutePath(), layouts, extensions
│   │   └── validator.ts          ← validateFolderStructure()
│   ├── http/
│   │   └── dispatcher.ts         ← dispatchRequest() — GET/POST/PUT/DELETE
│   ├── middleware/
│   │   ├── pipeline.ts           ← executeMiddleware() — async pipeline
│   │   └── rbac.ts               ← verifySessionAccess() — RBAC por route
│   ├── rendering/
│   │   ├── component.ts          ← renderComponent() via Preact
│   │   ├── frontmatter.ts        ← parseStaticPage() — YAML subset parser
│   │   ├── layout.ts             ← resolveLayout(), renderWithLayout()
│   │   └── markdown.ts           ← Markdown renderer adapter (swappable)
│   ├── routing/
│   │   ├── parameters.ts         ← parseParamSegment(), [id], [...rest]
│   │   ├── precedence.ts         ← compareRoutePrecedence()
│   │   └── router.ts             ← matchRoute() — route matching com cache
│   ├── specialists/
│   │   ├── index.ts              ← loadSpecialists(), runSpecialistHooks()
│   │   ├── logger/index.ts       ← Logger, ConsoleLogAdapter
│   │   ├── session-manager/index.ts ← SessionManager, MemoryStoreAdapter
│   │   └── validation/index.ts   ← Validator, ZodValidator
│   └── utils/
│       └── errors.ts             ← SsrError, BootError, RenderingError, etc.
├── tests/
│   ├── integration/
│   │   └── full-request.test.ts
│   └── unit/
│       ├── astro.test.ts
│       ├── error-pages.test.ts
│       ├── filesystem.test.ts
│       ├── frontmatter.test.ts
│       ├── http.test.ts
│       ├── middleware.test.ts
│       ├── rbac.test.ts
│       ├── routing.test.ts
│       ├── specialists.test.ts
│       └── types.test.ts
├── examples/
│   ├── blog-app/                 ← Exemplo real com boot.ts, middleware, layouts
│   └── taskboard/                ← Exemplo completo com RBAC, auth, CRUD pages
├── specs/                        ← Documentação técnica completa
│   ├── SPEC.SSR-MONOLITHS-FOUNDATIONS-REFINED.md
│   ├── SPECIALIST-CONTRACTS.md
│   ├── IMPLEMENTATION-GUIDE.md
│   ├── PRD.SSR-MONOLITHS-FOUNDATIONS-REFINED.md
│   └── ELEVATOR-PITCH.md
├── engineering-decisions.md      ← 20+ decisões de engenharia documentadas
├── HANDOVER.md
├── CHANGELOG.md
└── package.json
```

### API Pública (src/index.ts)

#### Entry Point Principal
```typescript
startSsrServer(opts: StartOptions): Promise<SsrServer>
```

#### Tipos Core
```typescript
Astro           // Contexto por request (params, session, logger, server)
Session         // Interface de sessão (login, logout, regenerate)
User / UserData // Usuário autenticado
Logger          // debug/info/warn/error
SsrServer       // Servidor (port, url, close())
PageComponent   // Tipo de componente TSX
HttpHandler     // Handler GET/POST/etc.
MiddlewareOnRequest // Tipo de middleware
ErrorPage       // Componente de error page
Frontmatter     // Metadados YAML de páginas .md
DiscoveryResult // Resultado do filesystem walker
```

#### Specialists (Injetados no Astro)
```typescript
// Logger
createLogger(config?: LoggerConfig): Logger
ConsoleLogAdapter                         // Implementação padrão

// Session
createSessionManager(config?): Promise<SessionManager>
MemoryStoreAdapter                        // Implementação padrão (in-memory)

// Validation
createValidator(): Promise<Validator>
ZodValidator                              // Implementação padrão
```

#### Lower-level utilities (exportadas para uso avançado)
```typescript
discoverPrimitives(appBaseFolder)         // Filesystem walker
matchRoute(pathname, routes)              // Route matcher com cache
buildAstroObject(...)                     // Contexto por request
dispatchRequest(...)                      // HTTP dispatcher
executeMiddleware(...)                    // Middleware pipeline
verifySessionAccess(...)                  // RBAC check
renderErrorPage(...)                      // Error page renderer
```

### Pipeline de Request
```
Bun.serve.fetch(request)
  → buildAstroObject()          [session, logger, server injected]
  → runSpecialistHooks()        [validator injected]
  → executeMiddleware()         [app middleware.ts]
    → staticAssets check        [public/ non-routable files]
    → public router             [public/ routes, no RBAC]
    → RBAC check                [verifySessionAccess]
    → pages router              [pages/ routes, RBAC-protected]
    → 404 error page            [fallback]
  → finalizeResponse()          [Set-Cookie se necessário]
```

### Sistema de Filesystem Routing
- **`public/`** — Rotas sem autenticação (`.tsx`, `.jsx`, `.md`, `.html`)
- **`pages/`** — Rotas protegidas por RBAC
- **`layouts/`** — Layouts reutilizáveis (TSX)
- **`error-pages/`** — Páginas de erro customizadas (`403.tsx`, `404.tsx`, `500.tsx`)
- **`middleware.ts`** — Middleware global (executado antes de todo request)
- **`boot.ts`** — Bootstrap da aplicação (executado 1x na inicialização)
- **Rotas dinâmicas:** `[id].tsx`, `[...rest].tsx` (rest params)
- **Prioridade:** static > dynamic, `.tsx` > `.jsx` > `.md` > `.html`

### Sistema de Sessão (SessionManager)
```typescript
interface SessionManager {
  getOrCreate(request: Request): Promise<Session>
  getPendingSetCookie(session: Session): string | null
  shutdown?(): Promise<void>
}

interface Session {
  id: string
  user: User | null
  roles: string[]
  permissions: string[]
  data: Record<string, any>
  login(userData: UserData): Promise<void>
  logout(): Promise<void>
  regenerate(): Promise<void>
}
```
- Cookie-based, HTTP-only, Secure por padrão
- Regenera session ID no login (proteção contra session fixation)
- Adapter pattern: `StoreAdapter` permite swap para Redis, SQL, etc.
- Default: `MemoryStoreAdapter` (in-memory, para dev/sandbox)
- Timeout: 24h padrão, configurável

### RBAC
```typescript
// Em pages TSX:
export const requiredPermissions = ['admin:read']
export const requiredRoles = ['admin']

// Em pages .md (frontmatter):
---
requiredPermissions: [admin:read]
requiredRoles: [admin]
---
```
- **`public/`** = sem RBAC (sempre acessível)
- **`pages/`** = RBAC obrigatório via `verifySessionAccess()`
- Roles e permissions verificadas por `AND` (todas devem estar presentes)

### Sistema de Rendering
- **TSX/JSX:** Preact `renderToString()` — SSR completo, sem hydration
- **Markdown:** Renderer próprio in-house (subset: headings, bold, italic, links, code, lists, blockquotes). Adaptável via `setMarkdownRenderer()`
- **HTML:** Servido como-is (GET only)
- **Layouts:** TSX com `children` prop (Markdown injeta HTML como children)
- **Frontmatter:** Parser YAML subset próprio (key: value, arrays, bool, number)

### Decisões de Engenharia Documentadas
`engineering-decisions.md` documenta 20+ decisões:
- **ED-001:** Specialists in-tree (não pacotes externos) — extractáveis depois
- **ED-003:** HTML files = static (sem frontmatter, GET only)
- **ED-004:** Static assets = qualquer extensão não-routable em `public/`
- **ED-005:** Markdown renderer in-house (subset, sem dependência externa)
- **ED-006:** Frontmatter parser in-house (subset YAML)
- **ED-007:** Built-in error pages — HTML mínimo, sem CSS externo

### Scripts
```bash
bun run dev          # bun --watch src/index.ts
bun run build        # build JS + declaration types
bun run test         # bun test tests/**/*.test.ts
bun run type-check   # sem emit, verifica types
```

### Candidatura para Template
**Status:** ✅ CRÍTICO — Extrair como `POC-ssr-foundations`
**Ação:** Criar repositório POC com este conteúdo integral
**Complexidade:** Baixa — código está completo e testado

---

## 2. Architecture Decision Records (ADRs)

**Localização:** `standards/adrs/`
**Arquivos:** `ADR-001-bun-over-node.md`

### ADR-001: Bun as Primary Runtime over Node.js
**Status:** Accepted

**Decisão:**
- Bun como runtime E package manager principal
- `bun install` obrigatório (lockfile: `bun.lockb`)
- Usar built-ins do Bun: test runner, bundler, task runner
- Node.js como fallback apenas para incompatibilidades

**Razões documentadas:**
- Performance: startup/execution significativamente mais rápido
- All-in-one: elimina npm/pnpm + jest + esbuild separados
- Agent-friendly: testes mais rápidos para AI agents
- Simplicidade cognitiva para humanos e agentes

**Consequências:**
- `bun.lockb` obrigatório no repo
- Proibido `package-lock.json` ou `pnpm-lock.yaml`
- Projetos Node-only devem ser marcados explicitamente

**Candidatura:** ✅ SIM — adaptar diretamente para template

---

## 3. Repository Structure Convention

**Localização:** `standards/conventions/repository-structure.md`

### Diretórios Canônicos Definidos
```
apps/           → End-user applications e public services
packages/       → Shared libraries, utilities, internal engines
mcps/           → Model Context Protocol servers
services/       → Internal microservices e backend logic
clis/           → Command-line tools e orchestration scripts
standards/      → Regras de engenharia (ADRs, conventions, processes)
academy/        → Material educacional e engineering knowledge
operations/     → Task management (current/, backlog/, ended/)
incoming-original/ → Staging area para artefatos não validados
```

### Regras Definidas
1. **`.gitkeep` Rule:** Todo diretório canônico DEVE ter `.gitkeep` (preserva estrutura mesmo vazio)
2. **Nesting Limits:** Evitar nesting redundante
3. **README Requirements:** Todo top-level dir DEVE ter `README.md` com: bird's eye view, purpose, local rules

**Candidatura:** ✅ SIM — adotar como estrutura canônica do template

---

## 4. Architecture Convention

**Localização:** `standards/conventions/architecture.md`

### Princípios Core ("The Grill")
1. **Packages are General:** Tudo em `packages/` DEVE ser general-purpose e reutilizável
2. **MCPs are Implementation:** MCPs consomem packages — são adapters/thin wrappers
3. **Zero Specificity:** Um package NUNCA deve conhecer o consumidor (MCP, app, CLI)

**Exemplo:** Um `color-palette` package deve funcionar em CLI, web app ou MCP sem modificação.

**Candidatura:** ✅ SIM — princípio fundamental para template

---

## 5. Naming Convention

**Localização:** `standards/conventions/README.md` + convenções nos arquivos de código

### Padrões Observados
- **Files:** `kebab-case.ts` (e.g. `session-manager/index.ts`)
- **Exports:** `camelCase` para funções, `PascalCase` para classes/interfaces
- **Packages:** `@box00/nome-do-pacote`
- **Environments:** `<tenantId>-<envId>` (e.g. `tokke-production`)
- **Databases:** `<tenantId>_<envId>` (e.g. `tokke_production`)
- **Containers:** `<tenantId>-<envId>` (e.g. `tokke-production`)
- **ADRs:** `ADR-NNN-descricao-kebab.md`

**Candidatura:** ✅ SIM — adotar convenções de naming

---

## 6. PR Review Process

**Localização:** `standards/processes/pr-review.md`

### Critérios de "Production Grade"
1. ❌ Nenhum `DIAGNOSTIC.md` ativo (issues resolvidos)
2. ✅ Estrutura canônica (follow directory layouts)
3. 🇬🇧 Code e docs em inglês
4. ✅ Test coverage completo e passando em CI
5. ✅ Docs em `docs/` presentes e claros

### Responsabilidades do Reviewer
- Gatekeeper final contra código não-confiável
- Rejeitar com referência específica ao standard violado

**Candidatura:** ✅ SIM — adotar como processo de PR do template

---

## 7. Task Template

**Localização:** `standards/processes/task-template.md`

```markdown
# Task: [Nome]

## Status
- State: Not Started / In Progress / Blocked / Completed
- Owner: [Name]

## Objective
[Uma a duas frases]

## Deliverables / Acceptance Criteria
- [ ] Critério 1
- [ ] Critério 2

## Checklist
- [ ] Sub-task 1

## Notes / Context
[Contexto adicional]
```

**Candidatura:** ✅ SIM — adotar como template de task padrão

---

## 8. Runbook: Deploy Production

**Localização:** `standards/runbooks/deploy-production.md`

### Conceito: `install.yaml`
Source of Operational Truth declarativo — descreve runtime, dependências, env config.

### Identification de Ambiente
`<tenantId>-<envId>` (e.g. `tokke-production`)

### Regras Operacionais
1. **Fixed Versions:** Runtime e containers com versões fixas (nunca ranges)
2. **Container Isolation:** Comandos Bun DENTRO do container, nunca no host
3. **Container Naming:** App: `<tenantId>-<envId>`, DB: `<database>-<version>-<envId>`
4. **Data Persistence:** `~/box00/<envId>/...`

### CLI box00 (referenciado, não implementado aqui)
```bash
box00 setup    # Lê install.yaml → gera compose.yaml
box00 up       # Docker Compose up
box00 down     # Docker Compose down (sem deletar volumes)
```

**Candidatura:** ✅ PARCIAL — conceito de `install.yaml` e naming conventions são valiosos. CLI `box00` não existe ainda como artefato neste repo.

---

## 9. Handover Validation Process

**Localização:** `standards/processes/handover-validation.md`

### Padrão `incoming-original/`
- Staging area para artefatos brutos/não validados
- Processo: receber → validar → promover para canonical location
- Evita promoção direta de código não auditado

**Candidatura:** ✅ SIM — padrão útil para gestão de artefatos externos

---

## 10. Exemplos de Aplicação (dentro de ssr-foundations)

**Localização:** `wip/ssr-foundations/examples/`

### Blog App
```
examples/blog-app/
├── boot.ts                 ← DB connection ou setup inicial
├── middleware.ts           ← Auth check global
├── index.ts                ← startSsrServer({ appBaseFolder })
├── layouts/base.tsx        ← Layout HTML base
├── pages/
│   ├── admin.tsx           ← Rota protegida RBAC
│   └── dashboard.tsx       ← Dashboard autenticado
├── public/
│   ├── index.tsx           ← Home pública
│   ├── login.tsx           ← Login page
│   └── blog/
│       ├── index.tsx       ← Lista de posts
│       └── hello-world.md  ← Post em Markdown com frontmatter
└── error-pages/
    ├── 403.tsx
    └── 404.tsx
```

### Taskboard App (mais completo)
```
examples/taskboard/
├── boot.ts
├── middleware.ts
├── index.ts
├── layouts/base.tsx
├── lib/
│   ├── auth.ts             ← Helpers de autenticação
│   ├── demo-data.ts        ← Dados de seed para demo
│   └── rbac.ts             ← Helpers RBAC
├── pages/
│   ├── admin/
│   │   ├── index.tsx       ← Admin dashboard
│   │   └── users.tsx       ← Gestão de usuários
│   ├── tasks/
│   │   ├── index.tsx       ← Lista de tasks
│   │   ├── [id].tsx        ← Detalhe de task (rota dinâmica)
│   │   └── [id]/delete.tsx ← Delete de task
│   └── dashboard.tsx
├── public/
│   ├── index.tsx
│   └── login.tsx
├── error-pages/
│   ├── 403.tsx
│   ├── 404.tsx
│   └── 500.tsx
└── tests/
    └── e2e.test.ts.txt     ← Testes E2E (draft)
```

**Candidatura:** ✅ CRÍTICO — exemplos reais de uso do `@box00/ssr-foundations`

---

## 11. Especificações Técnicas (dentro de ssr-foundations)

**Localização:** `wip/ssr-foundations/specs/`

| Arquivo | Conteúdo |
|---------|----------|
| `SPEC.SSR-MONOLITHS-FOUNDATIONS-REFINED.md` | Spec completa do framework |
| `SPECIALIST-CONTRACTS.md` | Contratos de interface dos specialists |
| `IMPLEMENTATION-GUIDE.SSR-MONOLITHS-FOUNDATIONS-REFINED.md` | Guia de implementação |
| `PRD.SSR-MONOLITHS-FOUNDATIONS-REFINED.md` | Product Requirements Document |
| `ELEVATOR-PITCH.md` | Visão executiva do produto |
| `FINAL-CHANGES-SUMMARY.md` | Resumo de mudanças finais |
| `README-HANDOFF.md` | Handoff document |

**Candidatura:** ✅ SIM — templates de spec/PRD/handoff reutilizáveis

---

## Matriz de Candidatos Final

| # | Artefato | Tipo | Localização Real | Importância | Ação |
|---|----------|------|-----------------|-------------|------|
| 1 | `@box00/ssr-foundations` | Package (framework SSR) | `wip/ssr-foundations/src/` | 🔴 Crítico | Criar POC-ssr-foundations |
| 2 | Exemplos taskboard + blog | Code examples | `wip/ssr-foundations/examples/` | 🔴 Crítico | Incluir no POC |
| 3 | Specs técnicas completas | Documentation | `wip/ssr-foundations/specs/` | 🔴 Crítico | Incluir no POC |
| 4 | Engineering decisions (20+) | Documentation | `wip/ssr-foundations/engineering-decisions.md` | 🔴 Crítico | Incluir no POC |
| 5 | ADR-001: Bun over Node | ADR | `standards/adrs/ADR-001-bun-over-node.md` | 🔴 Crítico | Adaptar para template |
| 6 | Repository Structure Convention | Standard | `standards/conventions/repository-structure.md` | 🔴 Crítico | Adotar no template |
| 7 | Architecture Convention | Standard | `standards/conventions/architecture.md` | 🔴 Crítico | Adotar no template |
| 8 | PR Review Process | Process | `standards/processes/pr-review.md` | 🟡 Importante | Adaptar para template |
| 9 | Task Template | Process | `standards/processes/task-template.md` | 🟡 Importante | Adotar no template |
| 10 | Deploy Runbook + `install.yaml` concept | Runbook | `standards/runbooks/deploy-production.md` | 🟡 Importante | Adotar conceito |
| 11 | Naming Conventions | Convention | (observado no código) | 🟡 Importante | Documentar no template |
| 12 | Incoming-original pattern | Pattern | `incoming-original/` | 🟡 Importante | Avaliar adoção |
| 13 | `.gitkeep` rule | Convention | `standards/conventions/` | 🟢 Baixo | Adotar no template |
| 14 | SessionManager (MemoryStore + cookie) | Code | `src/specialists/session-manager/` | 🔴 Crítico | Parte do POC |
| 15 | RBAC middleware | Code | `src/middleware/rbac.ts` | 🔴 Crítico | Parte do POC |
| 16 | Filesystem router | Code | `src/routing/` | 🔴 Crítico | Parte do POC |
| 17 | Markdown renderer (swappable) | Code | `src/rendering/markdown.ts` | 🟡 Importante | Parte do POC |
| 18 | Frontmatter YAML parser | Code | `src/rendering/frontmatter.ts` | 🟡 Importante | Parte do POC |
| 19 | Error pages system | Code | `src/error/` | 🟡 Importante | Parte do POC |
| 20 | Specialist plugin system | Code | `src/specialists/` | 🟡 Importante | Parte do POC |

---

## O que NÃO existe (ainda) em POC-basta00

- ❌ Nenhum package em `/packages/` (vazio)
- ❌ Nenhum service em `/services/` (vazio)
- ❌ Nenhum CLI em `/clis/` (vazio — `box00 CLI` mencionado no runbook mas não implementado aqui)
- ❌ Nenhum MCP em `/mcps/` (vazio)
- ❌ Nenhuma integration em `/integrations/` (vazio)
- ❌ Sem ORM/database access pattern (não existe neste repo)
- ❌ Sem MySQL driver ou connection pool
- ❌ Sem UI library ou componentes visuais

---

## Próximas Ações

1. ✅ Criar `POC-ssr-foundations` a partir de `wip/ssr-foundations/` (prioridade máxima)
2. ✅ Incorporar ADR-001 ao template (adaptar para BOX00)
3. ✅ Adotar repository structure convention como padrão do template
4. ✅ Adotar architecture convention (packages general, MCPs específicos)
5. ✅ Adotar task template e PR review process
6. ⏳ Analisar POC-app00ui-astro (UI components)
7. ⏳ Analisar POC-carteiro-service-2026 (service patterns)
8. ⏳ Confirmar backup-edge40 para análise futura
