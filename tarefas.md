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

### ✅ Fase 1: Exploração (CONCLUÍDA)

- [x] **Explorar estrutura atual do template**
  - [x] Listar arquivos `.md` e estrutura de diretórios
  - [x] Documentar estado atual

- [x] **Explorar estruturas dos repositórios de referência**
  - [x] Analisar POC-astro00 (principal)
  - [x] Analisar brcitas (full-stack)
  - [x] Analisar box00-carteiro-service (serviço especializado)
  - [x] Analisar box00-monorepo (infraestrutura)
  - [x] Analisar cliente-tokke-agendamentos (implementação cliente)
  - [x] Documentar padrões encontrados em cada um

- [x] **Mapear diferenças e melhorias disponíveis**
  - [x] Comparar estruturas dos repositórios
  - [x] Identificar gaps e oportunidades
  - [x] Priorizar melhorias por impacto

---

### 🔴 Fase 2: Implementação (INICIANDO)

**Phase 1: Fundações (Alta Prioridade)**

- [ ] **Adicionar estrutura de decisões de engenharia**
  - [ ] Criar `/docs/decisions/` directory
  - [ ] Adicionar template para ADR (Architecture Decision Records)
  - [ ] Documentar exemplo de decisão

- [ ] **Criar app de exemplo Astro**
  - [ ] Criar `apps/example-astro-app/`
  - [ ] Setup básico com componentes
  - [ ] Configurar TypeScript strict
  - [ ] Adicionar testes Vitest

- [ ] **Consolidar configurações de testing**
  - [ ] Verificar vitest.config.ts
  - [ ] Adicionar test helpers
  - [ ] Setup de coverage

- [ ] **Validar TypeScript strict em todos os pacotes**
  - [ ] Revisar tsconfig.json
  - [ ] Garantir strict mode ativo

**Phase 2: Backend (Média Prioridade)**

- [ ] **Criar app de exemplo com Hono 4**
  - [ ] Criar `apps/example-api/`
  - [ ] Setup Hono 4 basic
  - [ ] Documentar padrões de API

- [ ] **Adicionar padrão de validação (Zod)**
  - [ ] Setup Zod schemas
  - [ ] Integração com Hono

- [ ] **Exemplo de banco de dados**
  - [ ] Adicionar example database config
  - [ ] Documentar patterns

**Phase 3: DevOps (Média Prioridade)**

- [ ] **Adicionar Docker configuration**
  - [ ] Criar `docker-local/` example
  - [ ] Criar `docker-server/` pattern
  - [ ] Documentar setup local

- [ ] **Setup CI/CD workflows**
  - [ ] Criar `.github/workflows/` templates
  - [ ] Test automation
  - [ ] Build automation

- [ ] **Documentar deployment process**
  - [ ] Criar deployment guide
  - [ ] Environment variables pattern

**Phase 4: Documentation (Baixa Prioridade)**

- [ ] **Adicionar API documentation pattern**
  - [ ] Criar `/docs/api/` directory
  - [ ] API reference template
  - [ ] Exemplos de endpoints

- [ ] **Engineering decisions guidelines**
  - [ ] Como registrar decisões
  - [ ] Template completo
  - [ ] Exemplos práticos

- [ ] **Documentar padrões e conventions**
  - [ ] Code organization
  - [ ] Naming conventions
  - [ ] File structure patterns

---

## Notas de Progresso

- **2026-06-04:** Exploração completa dos 5 repositórios de referência
- **Achado principal:** Padrões são consistentes e validados em produção
- **Próximo passo:** Implementar melhorias Phase 1 (Fundações)
