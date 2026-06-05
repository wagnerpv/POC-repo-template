# Roadmap de Packages — Monorepo eco00 Canônico

**Definição de quais packages são essenciais para o template eco00-monorepo e ordem de prioridade.**

**Versão:** 1.0  
**Data:** 2026-06-05  
**Mantido por:** Wagner Vieira (Tech Lead)  
**Status:** Planned

---

## 📋 Visão Geral

O `eco00-monorepo-template` deve conter uma estrutura de packages que seja:
- **Mínima mas completa:** Suficiente para produtos reais (BrCitas, BitBox00)
- **Reutilizável:** Cada package serve múltiplos produtos
- **Evolucionário:** Começa simples, cresce conforme necessidade

---

## 🎯 Roadmap de Implementação

### **FASE 1: Fundações (POCs — Criar/Validar)**

Packages que precisam ser criados ou validados como POCs antes de serem incluídos no template.

#### 1️⃣ `@eco00/ssr-foundations` 
**Repositório Real:** `POC-ssr-foundations` (https://github.com/wagnerpv/POC-ssr-foundations)

**Propósito:** Framework SSR base para Astro + Bun + TypeScript  
**Escopo:**
- SSR runtime (Bun native)
- Request/Response handling
- Context management (AsyncLocalStorage)
- Slot routing
- Mutually recursive parser para templates
- Async component rendering

**Status:** ✅ Já existe como POC (extraído de POC-basta00)  
**Ação:** Validar, refinar, documentar para template  
**Prioridade:** 🔴 CRÍTICA — Bloqueante para UI + BrCitas

**Consumidores:**
- BrCitas (portal)
- BitBox00 (admin)
- Outros produtos SSR

---

#### 2️⃣ `@eco00/html-ui`
**Derivação:** POC-app00ui-astro (refatorar/estender)

**Propósito:** Componentes HTML com template directives (v-for, v-if, v-else, etc.)  
**Escopo:**
- Componentes reutilizáveis (buttons, cards, forms, tables, modals, etc.)
- Template directives para loops (`v-for`), condicionais (`v-if`, `v-else`), slots (`<slot />`)
- Bootstrap 5 CSS-only (vendored, sem Tailwind)
- DataStar integration para reatividade client-side
- Accessibility (a11y) built-in
- Stories/examples

**Status:** 🟡 POC existe (POC-app00ui-astro), precisa refatoração para monorepo  
**Ação:** Refatorar como package reutilizável + documentação + exemplos  
**Prioridade:** 🔴 ALTA — Bloqueante para UI em BrCitas + BitBox00

**Consumidores:**
- BrCitas (back-office)
- BitBox00 (admin UI)
- Qualquer produto com UI

**Template Directives Esperadas:**
```html
<!-- Loops -->
<div v-for="item in items" :key="item.id">{{ item.name }}</div>

<!-- Condicionais -->
<div v-if="isVisible">Visível</div>
<div v-else-if="isLoading">Carregando...</div>
<div v-else>Oculto</div>

<!-- Slots -->
<component-name>
  <template #header>Custom Header</template>
  <template #default>Content</template>
</component-name>

<!-- Event handling -->
<button @click="handleClick">Click me</button>

<!-- Props binding -->
<my-component :disabled="isDisabled" :label="'Submit'"></my-component>
```

---

#### 3️⃣ `@eco00/master-detail-html`
**Novo** — Criar baseado em padrão mestre-detalhe

**Propósito:** Padrão UI reutilizável (lista + detalhe)  
**Escopo:**
- Componente master (lista, busca, paginação)
- Componente detail (form, visualização, edição)
- State management (seleção, modo edit/view)
- Responsividade (side-by-side desktop, stacked mobile)
- Exemplos com dados reais

**Status:** 🔴 NÃO EXISTE — Precisa ser criado  
**Ação:** Criar como POC, testar com BrCitas  
**Prioridade:** 🔴 ALTA — Padrão usado em múltiplos produtos

**Consumidores:**
- BrCitas (listagem de anúncios + detalhe)
- BitBox00 (listagem de usuários + detalhe)
- Qualquer produto com listagens

---

#### 4️⃣ `@eco00/carteiro-service`
**Repositório Real:** Derivar de `POC-carteiro-service-2026` ou `box00-carteiro` (legado)

**Propósito:** Serviço de envio de mensagens (email, SMS, webhooks)  
**Escopo:**
- Provider abstraction (SMTP, SendGrid, Twilio, etc.)
- Template rendering (Handlebars, Liquid)
- Queue management (async jobs)
- Retry logic + backoff
- Logging + monitoring
- TypeScript strict

**Status:** 🟡 Existe em produção (legado) + POC 2026  
**Ação:** Refatorar como package reutilizável conforme `POC-carteiro-service-2026`  
**Prioridade:** 🟡 MÉDIA — Necessário para notificações em BrCitas

**Consumidores:**
- BrCitas (confirmação de anúncio, mensagens)
- BitBox00 (notificações de admin)
- Portal EBPE (confirmação de inscrição)

---

#### 5️⃣ `@eco00/database`
**Novo** — Criar do zero

**Propósito:** ORM/query builder + migrations para MySQL + SQLite  
**Escopo:**
- Drizzle ORM (confirmado em stack canônico)
- Schema definition
- Migrations (up/down)
- Seeds (dados iniciais)
- Query builder + type safety
- Transactions
- Connection pooling
- Logging

**Status:** 🔴 NÃO EXISTE — Bloqueante para todos os produtos  
**Ação:** Criar como POC com exemplos de schema BrCitas  
**Prioridade:** 🔴 CRÍTICA — Bloqueante para todo desenvolvimento

**Consumidores:**
- BrCitas (listagem, usuários, anúncios, etc.)
- BitBox00 (admin data)
- Todos os produtos

**Exemplo esperado:**
```typescript
// schema.ts
export const users = sqliteTable('users', {
  id: text('id').primaryKey(),
  email: text('email').notNull().unique(),
  createdAt: integer('created_at').notNull(),
});

// migrations
export async function migrate(db: Database) {
  await db.execute(sql`CREATE TABLE users (...)`);
}

// usage
const user = await db.select().from(users).where(eq(users.id, '123'));
```

---

### **FASE 2: Consumidores (Em Desenvolvimento — Aguardando Template)**

Produtos que aguardam o template + packages da Fase 1 estar pronto.

#### 🏗️ **BrCitas**
**Tipo:** Portal + Back-office (listagem de anúncios de adultos)  
**Market:** Espanha (Logroño)  
**Stack:** Astro 6.3 + Hono 4 + SQLite WAL + Zod + Vitest  
**Necessita:**
- ✅ ssr-foundations
- ✅ html-ui
- ✅ master-detail-html
- ✅ carteiro-service (notificações)
- ✅ database

**Status:** MVP entregue em 2025, agora migrando para eco00 template  
**Timeline:** Início assim que template estiver pronto (Fase 1 completa)

---

#### 🏗️ **BitBox00**
**Tipo:** Admin + Dashboard (gerenciamento de usuários, conteúdo, etc.)  
**Market:** Brasil (interno)  
**Stack:** Astro + Bun + MySQL + TypeScript  
**Necessita:**
- ✅ ssr-foundations
- ✅ html-ui
- ✅ master-detail-html
- ✅ carteiro-service (notificações admin)
- ✅ database

**Status:** Em especificação, aguardando template  
**Timeline:** Após BrCitas (segunda prioridade)

---

### **FASE 3: Pós-BrCitas (Após Consumidores Reais)**

#### 6️⃣ `@eco00/eco00-event-system`
**Propósito:** Barramento de eventos para comunicação entre serviços  
**Escopo:**
- Event producer + consumer
- Topic-based routing
- NATS/JetStream backend
- Async event processing
- Dead letter queues
- Observability (tracing)

**Status:** 🟡 Existe em produção em box00-monorepo, pronto para POC  
**Ação:** Criar POC para monorepo, documentar padrões  
**Prioridade:** 🟡 MÉDIA — Necessário após BrCitas para BitBox00 + sistema distribuído

**Consumidores:**
- BitBox00 (eventos entre serviços)
- Qualquer produto multi-serviço
- Admin (notificações globais)

---

## 📊 Dependências Entre Packages

```
database (BLOQUEANTE)
  ↓
  ├─→ carteiro-service
  └─→ master-detail-html

ssr-foundations (BLOQUEANTE)
  ↓
  └─→ html-ui

html-ui
  ↓
  └─→ master-detail-html

master-detail-html
  ↓
  └─→ BrCitas, BitBox00

BrCitas (consumidor real)
  ↓
  └─→ eco00-event-system (segunda geração)

BitBox00 (consumidor real)
  ↓
  └─→ eco00-event-system (segunda geração)
```

---

## 🚀 Ordem de Implementação (Estrita)

1. **Validar + Refinar `@eco00/ssr-foundations`** (POC existe, pronto)
2. **Validar + Refatorar `@eco00/html-ui`** (POC existe, refatorar)
3. **Criar `@eco00/master-detail-html`** (novo)
4. **Criar `@eco00/database`** (novo, bloqueante)
5. **Refatorar `@eco00/carteiro-service`** (existe, refatorar)
6. **Integrar BrCitas** (consumidor real — valida tudo)
7. **Integrar BitBox00** (segundo consumidor real)
8. **Criar `@eco00/eco00-event-system`** (Fase 2)

---

## 📝 Legados em Produção (A Atualizar)

Produtos existentes que serão **eventualmente** migrados para eco00, mas não são bloqueantes:

| Produto | Stack Atual | Status | Timeline |
|---------|------------|--------|----------|
| **carteiro** | Node.js | Em produção | Pós-BrCitas |
| **tokke-agendamentos** | Node.js | Em produção | Pós-BitBox00 |
| **site-ebpe** | Node.js | Em produção (eventos/inscrições) | Pós-BitBox00 |

**Abordagem:** Não migrar até que eco00 esteja estável em BrCitas + BitBox00.

---

## ✅ Critério de Sucesso (por Package)

### `@eco00/ssr-foundations`
- [ ] Tests: 100% cobertura
- [ ] Documentação: README + exemplos funcionais
- [ ] Performance: SSR em <200ms
- [ ] TypeScript: strict mode
- [ ] Usado com sucesso em BrCitas

### `@eco00/html-ui`
- [ ] 20+ componentes básicos (button, card, form, table, modal, etc.)
- [ ] v-for, v-if, v-else directives funcionais
- [ ] Acessibilidade (WCAG 2.1 AA)
- [ ] Bootstrap 5 CSS-only
- [ ] Storybook ou exemplos
- [ ] Usado em BrCitas + BitBox00

### `@eco00/master-detail-html`
- [ ] Componente reutilizável 100%
- [ ] Responsivo (desktop + mobile)
- [ ] Exemplo funcional com dados reais
- [ ] Usado em BrCitas listagem

### `@eco00/database`
- [ ] Schema para BrCitas (users, anúncios, etc.)
- [ ] Migrations automáticas
- [ ] Seeds funcionais
- [ ] Tests: migrations + queries
- [ ] Usado em BrCitas + BitBox00

### `@eco00/carteiro-service`
- [ ] Suporta SMTP + SendGrid (múltiplos providers)
- [ ] Template rendering
- [ ] Queue async
- [ ] Retry logic
- [ ] Usado em BrCitas notificações

### `@eco00/eco00-event-system`
- [ ] NATS/JetStream backend
- [ ] Topic-based routing
- [ ] Exemplo: BitBox00 notificações globais
- [ ] Documentado + exemplos

---

## 🎯 Próximas Ações (Imediatas)

1. **Validar `POC-ssr-foundations`**
   - Clonar repositório
   - Revisar código, testes, documentação
   - Integrar como `@eco00/ssr-foundations` no template

2. **Refatorar `POC-app00ui-astro`**
   - Clonar repositório
   - Extrair componentes essenciais
   - Adaptar directives (v-for, v-if, etc.)
   - Documentar uso

3. **Especificar `@eco00/database`**
   - Schema para BrCitas (users, ads, etc.)
   - Decisão: Drizzle ORM (confirmado)
   - Criar POC com schema funcional

4. **Iniciar BrCitas**
   - Assim que Fase 1 (packages) estiver ~80% pronto
   - Validar com produto real
   - Feedback loop para ajustes

---

## 📊 Matriz de Pacotes

| # | Package | Tipo | Repo/POC | Status | Prioridade | Bloqueante |
|---|---------|------|----------|--------|-----------|-----------|
| 1 | ssr-foundations | Framework | POC-ssr-foundations | POC ✅ | 🔴 CRÍTICA | Sim |
| 2 | html-ui | UI Library | POC-app00ui-astro | POC ✅ (refatorar) | 🔴 ALTA | Sim |
| 3 | master-detail-html | Pattern | Novo | NÃO EXISTE | 🔴 ALTA | Sim |
| 4 | database | ORM | Novo | NÃO EXISTE | 🔴 CRÍTICA | Sim |
| 5 | carteiro-service | Service | POC-carteiro-2026 | POC ✅ | 🟡 MÉDIA | Não |
| 6 | eco00-event-system | Barramento | box00-monorepo | Existe | 🟡 MÉDIA | Não (pós-BrCitas) |

---

## 📌 Observações Importantes

- **Ordem é estrita:** Cada package bloqueante deve estar funcional antes do próximo
- **BrCitas é validador:** Produto real testa arquitetura do template
- **BitBox00 é confirmador:** Segundo consumidor confirma padrões
- **Legados não migram imediatamente:** Apenas após estabilidade em novos produtos
- **Documentação viva:** Cada package precisa de README + exemplos + ADR

---

**Versão:** 1.0  
**Próxima revisão:** Após Fase 1 ~50% pronto  
**Mantido por:** Wagner Vieira (Tech Lead)  
**Data:** 2026-06-05
