# Tarefas - Aprimoramento do Monorepo Template

**Data de Início:** 2026-06-04
**Status:** Exploração Concluída → Implementação Iniciando
**Objetivo:** Ver `tarefas-objetivo.md`

---

## Repositórios de Referência

| Repositório | Tipo | Utilidade |
|---|---|---|
| **POC-astro00** | POC (Principal) | SSR com Astro compiler, Bun e runtime próprio. Referência principal — mais maduro |
| **brcitas** | Produção | Monorepo full-stack maduro: Bun, Astro 5, Hono 4, MySQL 8 |
| **box00-carteiro-service** | Produção | Padrão de serviço especializado: emails transacionais e formulários de contato |
| **box00-monorepo** | Infraestrutura | Estrutura de monorepo consolidada |
| **cliente-tokke-agendamentos** | Produção | Implementação cliente com padrões de agendamento |

---

## Status das Tarefas

### ✅ Fase 0: Framework Operacional (CONCLUÍDA)

- [x] Criar estrutura operacional completa
- [x] Documentar fluxo de trabalho (branch → PR → main)
- [x] Central de navegação (INDICE.md)

---

### ✅ Fase 1: Exploração (CONCLUÍDA)

- [x] **Explorar estrutura atual do template**
  - [x] Listar arquivos `.md` e estrutura de diretórios
  - [x] Documentar estado atual

- [x] **Explorar estruturas dos repositórios de referência**
  - [x] Analisar POC-astro00, brcitas, box00-carteiro-service
  - [x] Documentar padrões encontrados

- [x] **Mapear diferenças e melhorias**
  - [x] Comparar estruturas dos repositórios
  - [x] Identificar gaps e oportunidades

---

### 🔴 Fase 2: Packages Essenciais (INICIANDO)

**Phase 1: Fundações (Alta Prioridade)**

- [ ] **@box00/ssr-foundations**
  - [ ] Validar POC-ssr-foundations
  - [ ] Documentação + exemplos
  - [ ] Tests: 100% cobertura
  - [ ] Integrar ao template

- [ ] **@box00/html-ui**
  - [ ] Refatorar POC-app00ui-astro
  - [ ] 20+ componentes essenciais
  - [ ] Directives: v-for, v-if, v-else
  - [ ] Bootstrap 5 CSS-only

- [ ] **@box00/master-detail-html**
  - [ ] Criar padrão mestre-detalhe
  - [ ] Responsivo
  - [ ] Exemplo funcional

- [ ] **@box00/database**
  - [ ] Drizzle ORM setup
  - [ ] Schema BrCitas
  - [ ] Migrations + seeds

- [ ] **@box00/carteiro-service**
  - [ ] Refatorar POC-carteiro-2026
  - [ ] Múltiplos providers
  - [ ] Queue async

---

**Phase 2: Consumidores Reais (Validação)**

- [ ] **BrCitas Integration**
  - [ ] Template + todos os packages Phase 1
  - [ ] MVP validado

- [ ] **BitBox00 Integration**
  - [ ] Segundo consumidor confirma padrões
  - [ ] Feedback loop

---

**Phase 3: Pós-Consumidores**

- [ ] **@box00/eco00-event-system**
  - [ ] POC: NATS/JetStream
  - [ ] Documentação

---

**Para detalhes completos, ver:** `ROADMAP-PACKAGES-ECO00.md`

---

## Notas de Progresso

- **2026-06-04:** Exploração completa dos 5 repositórios de referência
- **Achado principal:** Padrões são consistentes e validados em produção
- **Próximo passo:** Implementar melhorias Phase 1 (Fundações)
