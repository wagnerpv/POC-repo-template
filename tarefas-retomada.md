# Tarefas — Retomada & Handover

**Para a próxima sessão do agente.**

Você está começando uma sessão nova, sem memória da sessão anterior. Este documento contém tudo que você precisa saber para continuar de onde paramos.

---

## 🎯 Status Atual (2026-06-05 pós-merge de PR #23)

### ✅ Concluído Nesta Sessão

**Framework Operacional Completo:**
- Criados 5 novos documentos (~2600 linhas)
  - `GUIA-OPERACIONAL.md` — procedimento dia a dia
  - `DASHBOARD-ARQUIVOS-CRITICOS.md` — mapa de documentação por Tier
  - `MAPA-VISUAL.md` — visualizações ASCII
  - `ONE-PAGE-REFERENCE.md` — cartão de referência rápida
  - `INDICE.md` — central de navegação
- Fluxo de trabalho estabelecido: **feature-branch → PR → main**
- Documentação viva sincronizada
- PR #23 mergeada com sucesso (commit `1645faa`)
- Repositório sincronizado: `local = remote`

### 🟢 Sistema Operacional

Tudo pronto para desenvolvimento normal. **Não há bloqueadores.**

---

## 📚 Como Iniciar Nova Sessão

### 1. Leitura Obrigatória (Tier 1 — 25 min)

Nesta ordem:
```
1. CLAUDE.md (5 min) — Regras do agente
2. mapa-executivo-plataforma.md (10 min) — Visão estratégica
3. tarefas-retomada.md (5 min) — Contexto da sessão anterior
4. tarefas.md (5 min) — Tarefas atuais
```

### 2. Referência Rápida

Abrir `INDICE.md` — central de navegação para todo o resto.

### 3. Começar Desenvolvimento

Seguir procedimento em `GUIA-OPERACIONAL.md` (seção "Procedimento Padrão de Sessão").

---

## 📋 Estado das Fases (tarefas.md)

### ✅ Phase 1: Fundações (COMPLETA)
- [x] Criar estrutura operacional
- [x] Documentar fluxo de trabalho
- [x] Central de navegação (INDICE.md)
- [x] Checklist de decisões
- [x] Referência rápida

### 🔴 Phase 2: Backend (NÃO INICIADO)
- [ ] Criar app de exemplo com Hono 4
- [ ] Adicionar padrão de validação (Zod)
- [ ] Exemplo de banco de dados

### 🔴 Phase 3: DevOps (NÃO INICIADO)
- [ ] Adicionar Docker configuration
- [ ] Setup CI/CD workflows
- [ ] Documentar deployment process

### 🔴 Phase 4: Documentation (PARCIAL)
- [x] Framework de documentação viva
- [ ] ADRs (Architecture Decision Records)
- [ ] API documentation pattern

---

## 🎯 Próximas Ações Imediatas

1. **Usar `INDICE.md` como ponto de entrada** para toda documentação
2. **Decidir:** Phase 2 (Backend) ou outra prioridade?
3. **Revisar `DASHBOARD-ARQUIVOS-CRITICOS.md`** mensalmente (métricas de saúde)
4. **Manter `ONE-PAGE-REFERENCE.md`** como cartão de bolso

---

## 📊 Documentos Críticos

### Tier 1 (Leitura obrigatória)
- `CLAUDE.md` — Regras do agente
- `mapa-executivo-plataforma.md` — Visão estratégica
- `tarefas-retomada.md` — Este arquivo
- `tarefas.md` — Tarefas atuais

### Tier 2 (Consultar conforme necessário)
- `GUIA-OPERACIONAL.md` — Procedimento operacional
- `tarefas-objetivo.md` — Objetivos da sprint
- `README.md` — Setup inicial

### Tier 3 (Referência)
- `INDICE.md` — Navegação central
- `DASHBOARD-ARQUIVOS-CRITICOS.md` — Mapa completo
- `MAPA-VISUAL.md` — Visualizações
- `ONE-PAGE-REFERENCE.md` — Cartão de bolso
- `docs/GIT-WORKFLOW-VERIFICAÇÃO.md` — Verificações Git obrigatórias

---

## 🔄 Fluxo de Trabalho Confirmado

**feature-branch → PR → main**

(Não há branch `dev` intermediária — termo foi genérico do Wagner)

### Checklist de Fim de Sessão (OBRIGATÓRIO)

Sempre fazer ao final de cada sessão:

```bash
# 1. Criar branch: git checkout -b chore/seu-escopo
# 2. Atualizar tarefas-log.md (append novo ## 2026-MM-DDTHH:MM-03:00)
# 3. Atualizar tarefas-retomada.md (reescrever estado)
# 4. Atualizar tarefas.md (marcar progresso)
# 5. Submeter PR
git add tarefas-log.md tarefas-retomada.md tarefas.md
git commit -m "chore: update session logs"
git push origin chore/seu-escopo
gh pr create --base main --head chore/seu-escopo
# 6. Esperar aprovação do Wagner
```

---

## ✅ Stack Canônico (não negociável)

- **Runtime:** Bun
- **Linguagem:** TypeScript strict
- **Frontend:** Astro (em transição para POC-astro00)
- **Backend:** eco00-event-system (via barramento, não APIs diretas)
- **Banco de Dados:** MySQL (produção) + SQLite (sandbox)
- **Infra:** Docker + Caddy (sem PM2)
- **HTTP Client:** Bun.fetch

**Regra:** Antes de propor tech diferente, consultar `mapa-executivo-plataforma.md`

---

## 🔗 Links Importantes

| Recurso | Link |
|---------|------|
| **Navegação Central** | `INDICE.md` |
| **Guia Operacional** | `GUIA-OPERACIONAL.md` |
| **Referência Rápida** | `ONE-PAGE-REFERENCE.md` |
| **Visão Estratégica** | `mapa-executivo-plataforma.md` |
| **Histórico** | `tarefas-log.md` |
| **Verificações Git** | `docs/GIT-WORKFLOW-VERIFICAÇÃO.md` |

---

## 📝 Notas Operacionais

- **Invariante Git:** `local = remote` sempre (verificado após cada PR)
- **Documentação viva:** tarefas-log (append-only), tarefas-retomada, tarefas
- **Sem bloqueadores:** Sistema operacional completo
- **Fluxo confirmado:** feature-branch → PR → main
- **Central de navegação:** INDICE.md para qualquer dúvida
- **IMPORTANTE:** Nunca commitar diretamente em main — sempre via branch + PR

---

## 🎓 Lembretes Críticos

- ❌ Nunca commitar direto em main
- ✅ Sempre criar branch: `git checkout -b chore/seu-escopo`
- ✅ Sempre PR com mensagem clara
- ✅ Sempre aguardar aprovação antes de mergear
- ✅ Sempre sincronizar e limpar branches após merge
- ✅ Sempre atualizar tarefas-log ao FIM de sessão (via PR)

---

**Status da Sessão 2026-06-05:** ✅ **Completa. Pronta para próxima operação.**

**Próxima sessão:** Abrir `INDICE.md` → seguir procedimento em `GUIA-OPERACIONAL.md`
