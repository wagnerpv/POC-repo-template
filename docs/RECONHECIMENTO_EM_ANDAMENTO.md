# Reconhecimento em Andamento - Análise de Repositórios

**Data Inicial:** 2026-06-04
**Status:** Missão de Reconhecimento Ativa
**Objetivo:** Catalogar artefatos, packages e padrões dos repositórios de referência

---

## Repositórios a Analisar

### ✅ Concluído

#### POC-astro00
- **SSR com Astro compiler + Bun**
- Estrutura: /apps, /packages, /docs, /api
- Padrões: Monorepo workspace, TypeScript strict
- Artefatos: Compiler integration, SSR patterns, routing

#### box00-monorepo
- **Primeira tentativa de plataforma (refatoração em andamento)**
- Estrutura: /apps/associacao360, /packages/app00-core, /packages/app00-ui
- Status: Growing desordenadamente, refatoração em curso (Eco00)
- Padrões: CRUD modules, environment management, database patterns

#### brcitas
- **Monorepo full-stack (projeto, não produção)**
- Stack: Bun, Astro 5, MySQL 8
- Estrutura: /apps/br-citas-vitrine, /apps/vitrine-pdf, /docs
- Artefatos: Full-stack patterns, database schemas, deployment configs

#### cliente-tokke-agendamentos
- **Cliente em produção com padrões consolidados**
- Estrutura: /@DOCS, /@box00, /db, /public
- Artefatos: Feature patterns, API integration, deployment

### 🔄 Em Análise

#### POC-basta00 (IDP/Plataforma)
- **Status:** Analisando code artifacts e packages
- Relevância: Muito importante — tem estrutura profissional de plataforma
- Foco: `/standards`, `/packages`, `/apps` (não KB, não operações)
- Achados preliminares:
  - Estrutura muito bem organizada (standards/, ADRs, runbooks)
  - `incoming-original/` — artifact inbox (padrão interessante)
  - `wip/ssr-foundations/` — code artifacts importantes
  - `/standards/adrs/` — ADR 001: Bun over Node (validado)
  - `/standards/conventions/` — padrões de arquitetura, estrutura

#### POC-ssr-foundations (a criar)
- **Status:** Pendente — será extraído de POC-basta00
- Origem: `wip/ssr-foundations/` em POC-basta00
- Ação: Criar novo repositório POC com este conteúdo
- Relevância: Alta — contém foundations para SSR

### ⏳ Não Iniciado

#### POC-app00ui-astro
- **UI components reutilizáveis**
- Próximo: Analisar estrutura de componentes

#### POC-carteiro-service-2026
- **Serviço especializado (emails/formulários)**
- Próximo: Mapear padrões de serviço

#### backup-edge40
- **Repositório de backup**
- Status: Backlog — futuro repositório de análise
- Ação: A confirmar se merece análise

---

## Artefatos Identificados

### Code Artifacts em POC-basta00

#### Standards & Conventions
- `/standards/adrs/` — Architecture Decision Records
  - ADR-001: Bun over Node (decisão justificada)
  - Padrão interessante para template

- `/standards/conventions/` — Implementação de convenções
  - Repository structure
  - Architecture patterns
  - Naming conventions

#### Platform Packages
- `/packages/` — Estrutura para reutilização
- `/integrations/` — Adaptadores de serviços third-party
- `/mcps/` — MCP servers para agentes AI

#### Padrões de Operação
- `/operations/` — Task tracking, backlog management
- `/standards/runbooks/` — Deploy procedures
- `/standards/processes/` — PR review, task templates

#### Inbox de Artefatos
- `incoming-original/` — Raw artifacts waiting validation
- Padrão: Sanitize antes de promover
- Interessante: Poderia ser adotado no template

---

## Próximas Ações de Reconhecimento

- [ ] Detalhar POC-basta00: code artifacts por categoria
- [ ] Explorar POC-app00ui-astro: componentes reutilizáveis
- [ ] Explorar POC-carteiro-service-2026: padrão de serviço
- [ ] Criar POC-ssr-foundations a partir de wip/ssr-foundations
- [ ] Confirmar backup-edge40 no backlog
- [ ] Consolidar achados por categoria de artefato

---

## Notas

- POC-basta00 é muito importante — tem padrões profissionais consolidados
- `wip/ssr-foundations` em POC-basta00 tem artefatos valiosos
- Estrutura de `standards/` em POC-basta00 é referência para documentação
- Padrão de `incoming-original/` é interessante para validação de artefatos
