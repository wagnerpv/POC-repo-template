# Visão de Produto Global — eco00-monorepo-template

**Status:** Ativo | **Data:** 2026-06-05 | **Mantido por:** Wagner Vieira (Tech Lead)

---

## 🎯 Propósito

O `eco00-monorepo-template` é a **arquitetura base** para construção de aplicações web SSR-first da plataforma Eco Zero Zero. Serve como referência canônica de padrões, packages, decisões de stack e fluxo de trabalho para todos os produtos que emergem da plataforma.

**Não é um produto final**, mas a **fundação reutilizável** que permite a criação rápida e consistente de produtos novos (BrCitas, BitBox00, etc.) com padrões validados em produção.

---

## 📐 Arquitetura de Alto Nível

```
┌─────────────────────────────────────────────────────┐
│         eco00-monorepo-template (Base)              │
│                                                     │
│  ├─ packages/ (reutilizáveis)                       │
│  │  ├─ @eco00-zero-zero/ssr-foundations                      │
│  │  ├─ @eco00-zero-zero/html-ui                              │
│  │  ├─ @eco00-zero-zero/master-detail-html                   │
│  │  ├─ @eco00-zero-zero/database                             │
│  │  ├─ @eco00-zero-zero/carteiro-service                     │
│  │  └─ @eco00-zero-zero/eco00-event-system                   │
│  │                                                  │
│  ├─ apps/ (exemplos/referência)                     │
│  │  ├─ example-ssr-app                              │
│  │  ├─ example-api                                  │
│  │  └─ example-full-stack                           │
│  │                                                  │
│  └─ docs/ (produto + decisões técnicas)             │
│     ├─ produto/                                     │
│     │  ├─ VISAO-PRODUTO-GLOBAL.md (este)           │
│     │  ├─ VISAO-PRODUTO-FRAMEWORK-HTML.md          │
│     │  └─ [visões de outros sub-produtos]          │
│     │                                               │
│     ├─ decisões/ (ADRs)                             │
│     └─ [análises, referências]                     │
└─────────────────────────────────────────────────────┘
        ↓ (consumido por)
┌─────────────────────────────────────────────────────┐
│              Produtos Reais                          │
│                                                     │
│  • BrCitas (Portal — Espanha)                       │
│  • BitBox00 (Admin — Brasil)                        │
│  • [Futuros produtos]                               │
└─────────────────────────────────────────────────────┘
```

---

## 🔧 Stack Canônico (Não Negociável)

**Runtime:**
- Bun (sem exceção)

**Linguagem:**
- TypeScript strict mode (sem exceção)

**Web Framework:**
- Astro 6.3+ (SSR-first)
- Sem React puro; componentes via `@eco00-zero-zero/html-ui`

**Backend:**
- Hono 4 (HTTP routing + middleware)
- eco00-event-system (comunicação entre serviços via barramento de eventos)

**Banco de Dados:**
- MySQL 8+ (produção)
- SQLite (desenvolvimento/sandbox)
- Drizzle ORM (query builder tipado)

**Validação & Serialização:**
- Zod (runtime validation, TypeScript integration)

**Testing:**
- Vitest (unit + integration)
- Bun native test runner

**Infraestrutura:**
- Docker (containerização)
- Caddy (proxy reverso, TLS automático)
- NATS/JetStream (event streaming — Fase 3+)

**Cliente-side (Reatividade):**
- DataStar (signals, sem reinventar reatividade)
- Bootstrap 5 CSS-only (vendored, sem Tailwind)

**Não usamos:**
- ~~Node.js~~ (Bun é o padrão)
- ~~Vite~~ (Astro compiler em Bun)
- ~~Tailwind~~ (Bootstrap 5 CSS-only)
- ~~React puro~~ (Islands + componentes HTML)
- ~~PM2~~ (Docker native)

---

## 📦 Packages Essenciais (Roadmap)

### Fase 1: Fundações (Bloqueantes para BrCitas + BitBox00)

| # | Package | Propósito | Status | POC |
|----|---------|-----------|--------|-----|
| 1 | `@eco00-zero-zero/ssr-foundations` | Framework SSR base | POC | POC-ssr-foundations |
| 2 | `@eco00-zero-zero/html-ui` | Componentes UI reutilizáveis | POC | POC-app00ui-astro |
| 3 | `@eco00-zero-zero/master-detail-html` | Padrão mestre-detalhe | Novo | — |
| 4 | `@eco00-zero-zero/database` | ORM + migrations (Drizzle) | Novo | — |
| 5 | `@eco00-zero-zero/carteiro-service` | Envio de mensagens | POC | POC-carteiro-2026 |

**Timeline:** Q3 2026 (após framework operacional validado)

### Fase 2: Consumidores Reais (Validação do Template)

| Produto | Stack | Market | Timeline | Usa |
|---------|-------|--------|----------|-----|
| **BrCitas** | Astro + Hono + MySQL | Espanha | Q3 2026 | Phase 1 packages |
| **BitBox00** | Astro + Hono + MySQL | Brasil | Q4 2026 | Phase 1 packages |

**Propósito:** Validar arquitetura do template com produtos reais. Feedback loop para refinos.

### Fase 3: Pós-Consumidores (Após Estabilidade)

- `@eco00-zero-zero/eco00-event-system` (NATS/JetStream) — necessário para BitBox00+ multi-serviço
- Migração de legados (carteiro, tokke-agendamentos, site-ebpe)

**Timeline:** Q1 2027+

**Detalhes:** Ver `ROADMAP-PACKAGES-ECO00.md`

---

## 🎨 Visão de Produto — Framework de Templates HTML

O template suporta um **framework declarativo de componentes HTML** com suporte a:

- **Tags especializadas** (`<form>`, `<table>`, etc.) com renderers próprios
- **Companion files** (`.md`) com metadados e datasets
- **DataStar signals** para reatividade client-side
- **Padrão mestre-detalhe** (lista + detalhe) reutilizável
- **Lookups** com seleção automática ou modal (inspirado em Delphi)

**Documento detalhado:** `docs/produto/VISAO-PRODUTO-FRAMEWORK-HTML.md`

**Princípios:**
- SSR-first (renderização no servidor)
- HTML semântico (sem contaminação com metadados)
- Sem reinventar reatividade (delegado ao DataStar)
- Baby steps (refinamento incremental, não over-engineering)

---

## 📊 Modelo Operacional

### Fluxo de Trabalho

```
feature-branch → PR (base main) → Code Review → Merge
        ↓                              ↓
   Sempre criar                  Wagner aprova
   branch nova                   ou solicita mudanças
```

**Invariantes:**
- ❌ Nunca commitar direto em main
- ✅ Sempre PR com mensagem clara
- ✅ Sempre aguardar aprovação
- ✅ Sempre sincronizar `local = remote` após merge
- ✅ Sempre deletar branches após merge (local + remota)

### Documentação Viva

Três arquivos sincronizados ao final **obrigatoriamente** de cada sessão:

| Arquivo | Função | Frequência |
|---------|--------|-----------|
| `tarefas-log.md` | Histórico append-only do que foi feito | Fim de sessão |
| `tarefas-retomada.md` | Contexto para próxima sessão começar | Fim de sessão |
| `tarefas.md` | Checklist de tarefas + progresso | Semanal |

**Detalhes:** Ver `GUIA-OPERACIONAL.md`

---

## 🎯 Consumidores de Produto

### BrCitas (Portal de Anúncios Adultos)

**Market:** Espanha (Logroño)  
**Type:** Portal público + back-office  
**Tech Stack:** Astro 6.3 + Hono 4 + MySQL WAL + Zod + Vitest  
**Status:** MVP entregue em 2025, migra para template eco00  
**Propósito no Template:** Valida arquitetura real

**Módulos:**
- Listagem de anúncios (padrão mestre-detalhe)
- Perfil de usuário (criação + edição)
- Carrinho de compras (PIX payment)
- Back-office (gerenciamento, listagem, filtros)
- Notificações (carteiro-service)

---

### BitBox00 (Admin + Dashboard)

**Market:** Brasil (interno)  
**Type:** Admin + Dashboard (gerenciamento)  
**Tech Stack:** Astro + Hono + MySQL + TypeScript  
**Status:** Em especificação, aguardando template  
**Propósito no Template:** Segundo consumidor confirma padrões

**Módulos:**
- Dashboard com métricas
- Gerenciamento de usuários (mestre-detalhe)
- Gerenciamento de conteúdo
- Notificações globais (eco00-event-system)
- Relatórios

---

## 🔐 Controle de Acesso

Todos os produtos suportam **RBAC (5 roles padrão)**:

| Role | Descrição | Permissões |
|------|-----------|-----------|
| **admin** | Administrador total | Todas |
| **editor** | Editor de conteúdo | Ver, criar, editar próprio |
| **viewer** | Leitor | Ver apenas |
| **manager** | Gerenciador | Ver, criar, editar, deletar |
| **guest** | Visitante | Ver público |

**Implementação:** Front matter do `.md` + middleware Hono

---

## 🚀 Roadmap Executivo

### Q2 2026 (Agora)
- ✅ Framework operacional criado
- ✅ Roadmap de packages definido
- 🔄 Documentação de visão de produto (este doc + VISAO-PRODUTO-FRAMEWORK-HTML.md)

### Q3 2026
- Validar `@eco00-zero-zero/ssr-foundations` (POC → package)
- Refatorar `@eco00-zero-zero/html-ui` (POC → package)
- Criar `@eco00-zero-zero/master-detail-html` (novo)
- Criar `@eco00-zero-zero/database` (novo — Drizzle ORM)
- Refatorar `@eco00-zero-zero/carteiro-service` (POC → package)
- **Iniciar BrCitas** (consumidor real #1)

### Q4 2026
- **BrCitas em produção** (MVP validado)
- **Iniciar BitBox00** (consumidor real #2)
- Feedback loop do template (ajustes baseado em BrCitas real)

### Q1 2027+
- BitBox00 em produção
- `@eco00-zero-zero/eco00-event-system` POC
- Migração de legados (carteiro, tokke, ebpe)

---

## 📚 Documentação Crítica

### Tier 1 (Leitura Obrigatória)
- `CLAUDE.md` — Regras do agente
- `mapa-executivo-plataforma.md` — Visão estratégica
- `tarefas-retomada.md` — Contexto da sessão anterior
- `tarefas.md` — Tarefas atuais

### Tier 2 (Referência Frequente)
- `GUIA-OPERACIONAL.md` — Procedimento operacional
- `ROADMAP-PACKAGES-ECO00.md` — Packages a implementar
- `docs/produto/VISAO-PRODUTO-GLOBAL.md` (este)
- `docs/produto/VISAO-PRODUTO-FRAMEWORK-HTML.md`

### Tier 3 (Consulta Conforme Necessário)
- `INDICE.md` — Navegação central
- `ONE-PAGE-REFERENCE.md` — Cartão de bolso
- `MAPA-VISUAL.md` — Visualizações ASCII

---

## 🎓 Decisões de Escopo

### ✅ In Scope
- SSR-first rendering (servidor renderiza, cliente reage com DataStar)
- HTML semântico com tags especializadas
- Padrão mestre-detalhe reutilizável
- RBAC integrado
- Event-driven architecture (Fase 3)
- Database abstraction (Drizzle)
- Message service (email, SMS, webhooks)

### ❌ Out of Scope
- Islands architecture (contradiz SSR-first)
- React puro (usamos componentes HTML + DataStar)
- Tailwind (Bootstrap 5 CSS-only é decisão consciente)
- Real-time collaboration (futuro, não agora)
- GraphQL (REST via Hono é suficiente atualmente)

---

## 🔄 Backlog do Arrependimento

**Itens que poderiam ser boas práticas, mas que adiamos conscientemente:**

- Blindagem excessiva de APIs internas do framework
- Otimização antecipada de queries SQL
- Endurecimento de segurança além do necessário para aplicações atuais
- Abstrações para problemas que ainda não existem

**Regra:** Quando virar problema concreto, passa para backlog ativo. Não antes.

---

## ✅ Critérios de Sucesso (por Fase)

### Phase 1: Packages
- ✓ 5 packages funcionais e documentados
- ✓ Testes: 100% cobertura em packages críticos
- ✓ Exemplo funcional de cada package
- ✓ README + ADR para cada decisão

### Phase 2: Consumidores
- ✓ BrCitas em produção com template (valida stack)
- ✓ BitBox00 em produção com template (confirma padrões)
- ✓ Feedback loop processado (melhorias no template)
- ✓ Documentação de padrões consolidada

### Phase 3: Ecossistema
- ✓ eco00-event-system POC funcional
- ✓ Legados em migração com novo stack
- ✓ Performance + observability estabelecidos

---

## 📞 Governança

**Tech Lead:** Wagner Vieira  
**Code Review:** Sempre obrigatório antes de merge  
**Stack Decisions:** Documentar em `docs/decisões/ADR-*.md`  
**Releases:** Semantic versioning após cada fase validada

---

## 🔗 Documentos Relacionados

- `ROADMAP-PACKAGES-ECO00.md` — Detalhes de cada package
- `docs/produto/VISAO-PRODUTO-FRAMEWORK-HTML.md` — Framework de templates
- `GUIA-OPERACIONAL.md` — Procedimentos operacionais
- `mapa-executivo-plataforma.md` — Decisões estratégicas
- `tarefas.md` — Fases 0-3 de implementação

---

**Versão:** 1.0  
**Data:** 2026-06-05  
**Próxima revisão:** Após BrCitas Fase 1 (validação real)  
**Mantido por:** Wagner Vieira (Tech Lead)
