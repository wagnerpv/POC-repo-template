# Tarefa: Análise Detalhada de POC-basta00

**Assignee:** Software Engineer (haiku-git-agent)
**Revisor:** Tech Lead (wagnerpv)
**Status:** ⏳ Em Andamento
**Data Início:** 2026-06-04

---

## Objetivo

Catalogar todos os code artifacts de POC-basta00 para identificar padrões, pacotes e estruturas reutilizáveis que possam ser incorporados ao `agente-monorepo-template`.

---

## Escopo

### O QUE ANALISAR ✅
- RMs (Architecture Decision Records)
- Conventions & Standards
- Platform Packages (`/packages/`)
- Services (`/services/`)
- CLIs (`/clis/`)
- MCPs (`/mcps/`)
- Integration Adapters (`/integrations/`)
- Database patterns & access
- Renderizadores (SSR patterns)
- UI Libraries & Components
- Specs & Documentation
- Runbooks & Processes

### O QUE NÃO ANALISAR ❌
- Applications específicas em `/apps/`
- Knowledge bases em `/academy/`
- Conteúdo operacional puro
- Material de onboarding genérico

---

## Metodologia

1. **Exploração Estruturada:** Diretório por diretório
2. **Catalogação:** Listar cada artefato encontrado
3. **Qualificação:** Avaliar importância e candidatura
4. **Documentação:** Registrar em `ANÁLISE_DETALHADA_BASTA00_ARTEFATOS.md`
5. **Consolidação:** Criar matriz de candidatos

---

## Deliverables

- ✅ `docs/ANÁLISE_DETALHADA_BASTA00_ARTEFATOS.md` — Catalogação completa
- ✅ `docs/TAREFA_ANÁLISE_BASTA00.md` — Este documento
- 🔄 Análise de `/packages/` 
- 🔄 Análise de `/services/`
- 🔄 Análise de `/clis/`
- 🔄 Análise de `/mcps/`
- 🔄 Análise de `/integrations/`
- 📋 Matriz final de candidatos (em ANÁLISE_DETALHADA_BASTA00_ARTEFATOS.md)

---

## Critérios de Seleção

### Importância 🔴 Crítico
- Padrões fundamentais ao monorepo
- Stack canonical (Bun, Astro, TypeScript, MySQL)
- ADRs e conventions de alto nível

### Importância 🟡 Importante
- Packages reutilizáveis
- CLIs e ferramentas dev
- Padrões de API/database
- MCPs e integrações

### Importância 🔵 Futuro
- Skills de agentes AI
- Integrações experimentais
- Padrões em evolução

---

## Status de Análise

| Componente | Status | Achados |
|---|---|---|
| `/standards/adrs/` | ✅ Completo | ADR-001 (Bun over Node) |
| `/standards/conventions/` | ✅ Completo | 3 conventions principais |
| `/standards/runbooks/` | ✅ Completo | Deploy, PR, Task templates |
| `/packages/` | 🔄 Pendente | A explorar |
| `/services/` | 🔄 Pendente | A explorar |
| `/clis/` | 🔄 Pendente | A explorar |
| `/mcps/` | 🔄 Pendente | A explorar |
| `/integrations/` | 🔄 Pendente | A explorar |
| `/wip/ssr-foundations/` | 🔄 Pendente | Crítico — futura POC |
| `/incoming-original/` | ✅ Completo | Padrão de inbox |
| Specs | 🔄 Parcial | SSR architecture spec encontrada |

---

## Próximas Ações (Ordem)

1. Explorar e documentar `/packages/` 
2. Explorar e documentar `/services/`
3. Explorar e documentar `/clis/`
4. Explorar e documentar `/mcps/`
5. Explorar e documentar `/integrations/`
6. Analisar padrões de código comuns
7. Consolidar matriz de candidatos
8. Priorizar por valor e complexidade
9. Criar guias de adaptação para template
10. Apresentar ao TL para planejamento

---

## Notas para o Engineer

- POC-basta00 é um **IDP maduro**, não um simples POC
- Foco em **patterns reutilizáveis**, não em código específico
- Documentar **interfaces públicas**, não implementações internas
- Marcar **dependências** claramente (o que precisa de quê)
- Indicar **complexidade de adaptação** (fácil, médio, difícil)

---

## Revisão

**TL (wagnerpv):** [ ] Revisar quando completo

