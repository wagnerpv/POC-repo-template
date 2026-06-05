# Análise Consolidada de Repositórios de Referência e Artefatos Candidatos

**Data:** 2026-06-05  
**Status:** Análise Completa de Documentos Existentes  
**Escopo:** eco00-monorepo-template (foco em zero00, backup-edge40, DG40)

---

## 1. REPOSITÓRIOS ANALISADOS

### 1.1 POC-astro00 (Clonado em /tmp/)
**Tipo:** POC/Foundation  
**Stack:** Bun + Astro compiler (WASM, sem Vite/adapter)  
**Status:** ✅ Lido + Clonado

**Artefatos Críticos:**
- `src/runtime/` — APIs de runtime (context, render, cookies, session)
- `src/router.ts` — Router funcional
- `src/plugin.ts` — Bun plugin para .astro
- Padrão: File-based routing + middleware pipeline

---

### 1.2 POC-basta00 (IDP Monorepo)
**Tipo:** Plataforma interna  
**Stack:** Bun, Astro SSR, Preact, Zod  
**Status:** ✅ Analisado

**Artefatos Críticos:**
- `@box00/ssr-foundations` (em `wip/ssr-foundations/`)
  - Framework SSR production-grade
  - Bun nativo, sem Astro em runtime
  - Preact para renderização, Zod para validação
- `/standards/adrs/` — Architecture Decision Records
- `/standards/conventions/` — Padrões consolidados
- Estrutura profissional de plataforma (incoming-original/, structure clara)

**Artefatos Importantes:**
- Estrutura ADR (Architecture Decision Records)
- Convenções de engenharia
- Patterns de organização monorepo

---

### 1.3 POC-app00ui-astro (UI Library)
**Tipo:** Component Library  
**Stack:** Bun workspaces, Astro components, CSS Custom Properties  
**Status:** ✅ Analisado

**Artefatos Críticos:**
- `theme-vars.css` — Design token system completo
  - Sem Tailwind JIT (puro CSS Custom Properties)
  - Breakpoints, colors, spacing, typography
  - Dark mode via `[data-theme]` + media query
- Atomic Design structure (atoms/ → molecules/ → organisms/)
- `lucide-astro` como padrão de icons

**Artefatos Importantes:**
- CHOICES_MADE_BY_DEVELOPERS.md (20 decisões documentadas)
- Stories pattern (Astro pages como documentação visual)
- ARIA accessibility baseline
- Export strategy (3 paths: `/`, `/styles`, `/components`)

---

### 1.4 POC-carteiro-service-2026 (v3 - Form-to-Email Gateway)
**Tipo:** Serviço especializado  
**Stack:** Bun + Astro SSR, flat-file JSON, Resend/SendGrid  
**Status:** ✅ Analisado

**Artefatos Críticos:**
- `db.ts` — Standalone JSON store (sem deps externas)
  - Wire-compatible com qqdb diskStore
  - CRUD: insertOne, getAll, getById, updateOne, deleteOne
  - Auto-increment `id`
- Routing pattern: Todas rotas em `middleware.ts` (sem `/api/` files)
- `sendFormEmail.ts` — Multi-provider email dispatcher (Resend/SendGrid)

**Artefatos Importantes:**
- `queryParser.ts` — GitHub-style query parser para JSON
- `verifyCaptcha.ts` — reCAPTCHA validation (v2/v3)
- Self-hosted assets (DataStar, DaisyUI)
- Persistência: flat-file JSON em `/var/databases/`
- pm2.yaml com `interpreter: bun`

---

### 1.5 backup-edge40 (Backup Pessoal)
**Tipo:** Repositório de backup (não produto)  
**Conteúdo:** Artefatos de sessões com agentes AI  
**Status:** ⏳ Análise parcial (ZIPs pendentes)

**Estrutura:**
```
backup-edge40/
├── agents/
│   ├── FILESYSTEM-CONVENTIONS.md (⭐ CRÍTICO)
│   ├── PSP/ (Payment Service Provider)
│   ├── br-citas/
│   ├── dd-norm/ (Data Dictionary + Validation)
│   ├── dev/ (ferramentas)
│   ├── docs-site/ (site renderer CMS)
│   ├── edge40-2026-04-20/ (sessão: basta00, astro-renderer, eco00)
│   ├── edge40-2026-04-23/ (sessão: browser-engine, router-engine, web-api)
│   ├── edge40-2026-05-05/ (sessão: taskboard, browser-automation, ssr-runtime)
│   ├── edge40-2026-05-23/ (sessão: Valeska, app-spec, astro-renderer)
│   ├── edge40-2026-05-24/ (sessão: Valeska HTML)
│   ├── edge40-2026-05-27/ (sessão: tokke-monorepo)
│   ├── mcp-foundations/
│   └── misc--app00-deploy-guidelines/
├── scripts/ (gestão de arquivos grandes)
└── zona/ (rascunhos)
```

**Artefatos Críticos:**
- `agents/FILESYSTEM-CONVENTIONS.md` — **Convenção canônica de filesystem**
  - Deve ser lido e incorporado no ESTRUTURA-REFINED.md

**Artefatos com Análise Pendente (ZIPs):**
- Sessões em `edge40-2026-XX-XX/` podem conter ZIPs com contexto parcial
- ⚠️ **Requer esclarecimento:** Qual é o propósito de cada sessão? Quais ZIPs são relevantes?

---

### 1.6 Referências Secundárias (Mencionadas, não clonadas)

#### brcitas (Full-stack Produção)
**Stack:** Bun, Astro 5, Hono 4, MySQL 8  
**Padrões:**
- Full-stack SSR + API
- Database schemas
- Docker + Caddy deployment

#### box00-monorepo (Infraestrutura - Predecessor)
**Status:** Predecessor do eco00 (refatoração em curso)  
**Padrões:** CRUD modules, environment management, database patterns

#### cliente-tokke-agendamentos (Produção)
**Padrões:** Feature modules, API integration, deployment

---

## 2. PACOTES E ARTEFATOS CANDIDATOS A INCORPORAR

### 🔴 CRÍTICOS (Incorporar Obrigatoriamente)

| Artefato | Origem | Tipo | Descrição | Ação |
|----------|--------|------|-----------|------|
| `@eco00/ssr-foundations` | POC-basta00/wip/ | Package | Framework SSR production-grade | **Extrair como package** |
| `db.ts` | carteiro-service/src/lib/ | Utilitário | JSON Store standalone | **Extrair como @eco00/json-store** |
| `FILESYSTEM-CONVENTIONS.md` | backup-edge40/agents/ | Docs | Convenção canônica FS | **Ler e incorporar em docs/** |
| `theme-vars.css` | app00ui-astro/src/styles/ | CSS System | Design tokens completos | **Adotar como design base** |
| Routing via middleware | carteiro-service/src/ | Padrão | POST routes em middleware.ts | **Incorporar em template** |

### 🟡 IMPORTANTES (Considerar)

| Artefato | Origem | Tipo | Descrição |
|----------|--------|------|-----------|
| `@eco00/app00ui-astro` | app00ui-astro/packages/ | Package | UI components Atomic Design |
| `sendFormEmail.ts` | carteiro-service/src/lib/ | Utilitário | Email dispatcher multi-provider |
| `queryParser.ts` | carteiro-service/src/lib/ | Utilitário | GitHub-style query parser |
| `CHOICES_MADE_BY_DEVELOPERS.md` | app00ui-astro/ | Docs | Template de decisões |
| Astro runtime exports | astro00/src/runtime/ | APIs | Context, render, cookies, session |
| ADR pattern | basta00/standards/adrs/ | Docs | Architecture Decision Records |

---

## 3. SESSÕES DE EDGE40 - CONTEXTUALIZAÇÃO NECESSÁRIA

### Sessões Identificadas

| Sessão | Data | Artefatos Mencionados | Status |
|--------|------|---|---|
| `edge40-2026-04-20/` | 20/04 | basta00, astro-renderer, eco00 | ⏳ Pendente |
| `edge40-2026-04-23/` | 23/04 | browser-engine, router-engine, web-api | ⏳ Pendente |
| `edge40-2026-05-05/` | 05/05 | taskboard, browser-automation, ssr-runtime | ⏳ Pendente |
| `edge40-2026-05-23/` | 23/05 | Valeska, app-spec, astro-renderer | ⏳ Pendente |
| `edge40-2026-05-24/` | 24/05 | Valeska HTML | ⏳ Pendente |
| `edge40-2026-05-27/` | 27/05 | tokke-monorepo | ⏳ Pendente |

**Requer esclarecimento:**
- ❓ Qual é o propósito real de cada sessão?
- ❓ Quais ZIPs são relevantes para eco00?
- ❓ backup-edge40 deve ser clonado para análise profunda?

---

## 4. PADRÕES CONSOLIDADOS

### Estrutura Monorepo (Padrão Universal)
```
├── apps/          (aplicações)
├── packages/      (libraries @eco00/*)
├── vendor/        (dependencies versionadas)
├── sandbox/       (ambientes de test/dev)
├── docs/          (documentação)
├── scripts/       (operacionais)
└── tests/         (do projeto)
```

### Stack Confirmado
- **Runtime:** Bun (universal)
- **Frontend:** Astro SSR (com/sem adapter)
- **UI Components:** CSS Custom Properties (sem Tailwind JIT)
- **Persistence:** Flat-file JSON (db.ts)
- **Email:** Resend/SendGrid (multi-provider)
- **Process Manager:** PM2 com `interpreter: bun`
- **Reverse Proxy:** Caddy

### Padrões de Código
1. **Routing:** Middleware central (não `/api/` files)
2. **Design System:** CSS Custom Properties (theme-vars.css)
3. **Components:** Atomic Design (atoms/molecules/organisms)
4. **Documentation:** CHOICES_MADE_BY_DEVELOPERS.md
5. **Decisões:** ADR pattern (/standards/adrs/)

---

## 5. DOCUMENTOS EXISTENTES NO REPOSITÓRIO

### Análises Detalhadas
- ✅ ANÁLISE-DETALHADA-BACKUP-EDGE40-ARTEFATOS.md
- ✅ ANÁLISE-DETALHADA-BASTA00-ARTEFATOS.md
- ✅ ANÁLISE-POC-APP00UI-ASTRO.md
- ✅ ANÁLISE-POC-CARTEIRO-SERVICE-2026.md

### Roadmaps/Status
- ✅ ANÁLISE-REFERÊNCIAS.md (índice)
- ✅ RECONHECIMENTO-EM-ANDAMENTO.md (status misto)
- ✅ EXPLORAÇÃO-REFERÊNCIAS-SECUNDÁRIAS.md
- ✅ CONSOLIDAÇÃO-ACHADOS.md (padrões + gaps)

### Estrutura
- ✅ ESTRUTURA-REFINED.md (proposta baseada em astro00)
- ✅ TEMPLATE-ESTRUTURA-ATUAL.md (status)
- ✅ MINI-SPEC-RELEASE-VENDOR-DEPLOY.md (operacional)

### Operacional
- ✅ GIT-WORKFLOW-VERIFICAÇÃO.md (checklist)

---

## 6. PRÓXIMAS AÇÕES RECOMENDADAS

### Imediato (Deve fazer agora)
1. **Ler FILESYSTEM-CONVENTIONS.md** de backup-edge40/agents/
2. **Extrair ssr-foundations** como pacote separado
3. **Extrair db.ts** como @eco00/json-store

### Curto Prazo (Esta semana)
1. **Clonar POC-basta00** para análise profunda
2. **Criar packages no template:**
   - `@eco00/ssr-foundations`
   - `@eco00/json-store`
   - `@eco00/app00ui-astro` (opcional)
3. **Documentar ADR pattern** em /standards/adrs/

### Médio Prazo
1. **Clarificar contexto de edge40** (qual sessão = qual ZIP?)
2. **Decidir sobre backup-edge40** (clonar ou não?)
3. **Validar padrões com brcitas**

---

## 7. QUESTÕES PENDENTES

❓ **Para Wagner/Tech Lead:**
1. O que é "DG40"? (mencionado no brief, não encontrado em docs)
2. backup-edge40/agents/edge40-2026-XX-XX/ contém ZIPs relevantes?
3. Qual é a prioridade: ssr-foundations vs. app00ui-astro vs. json-store?
4. Devemos clonar POC-basta00 inteira ou focar em wip/ssr-foundations/?

---

**Status:** Pronto para implementação  
**Artefatos Identificados:** 15+ candidatos críticos  
**Análise Completa:** ✅ Sim
