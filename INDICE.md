# 📑 Índice de Navegação — Documentação Operacional

**Central de navegação para toda documentação do eco00-monorepo-template.**

Leia isto **primeiro** quando tiver dúvida de por onde começar.

---

## 🚀 Começando (Novo Membro)

1. **START HERE:** [`README.md`](./README.md) — O que é este repositório, requisitos, setup
2. **Entender visão:** [`mapa-executivo-plataforma.md`](./mapa-executivo-plataforma.md) — Stack canônico, decisões estratégicas
3. **Aprender workflow:** [`CLAUDE.md`](./CLAUDE.md) — Regras e responsabilidades do agente
4. **Procedimento dia a dia:** [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) — Como trabalhar, fazer PR, atualizar docs
5. **Referência rápida:** [`ONE-PAGE-REFERENCE.md`](./ONE-PAGE-REFERENCE.md) — Cartão de bolso, checklist rápido

**Total:** 1 hora de leitura. Depois estará pronto para começar.

---

## 📚 Por Situação — Ler O Quê?

### Situação: "Começando nova sessão"
```
1. CLAUDE.md (5 min) — refrescar regras
2. mapa-executivo-plataforma.md (10 min) — visão estratégica
3. tarefas-retomada.md (5 min) — onde paramos
4. tarefas.md (5 min) — tarefas atuais
```
**Resultado:** 25 min de contexto. Pronto para começar.

**Leitura:** [`CLAUDE.md`](./CLAUDE.md) → [`mapa-executivo-plataforma.md`](./mapa-executivo-plataforma.md) → [`tarefas-retomada.md`](./tarefas-retomada.md) → [`tarefas.md`](./tarefas.md)

---

### Situação: "Vou fazer um commit/PR"
```
1. GUIA-OPERACIONAL.md (checklist DoD) — está tudo pronto?
2. docs/GIT-WORKFLOW-VERIFICAÇÃO.md — passos + verificações
3. ONE-PAGE-REFERENCE.md — lembrar de git workflow
```
**Resultado:** 10 min. Pronto para push e PR.

**Leitura:** [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) → [`docs/GIT-WORKFLOW-VERIFICAÇÃO.md`](./docs/GIT-WORKFLOW-VERIFICAÇÃO.md) → [`ONE-PAGE-REFERENCE.md`](./ONE-PAGE-REFERENCE.md)

---

### Situação: "Finalizando sessão"
```
1. tarefas-log.md — adicionar entrada (append-only)
2. tarefas-retomada.md — reescrever estado
3. tarefas.md — marcar progresso
4. Commitar "chore: update session logs"
```
**Resultado:** 15 min. Próxima sessão começa com tudo atualizado.

**Leitura:** [`tarefas-log.md`](./tarefas-log.md) → [`tarefas-retomada.md`](./tarefas-retomada.md) → [`tarefas.md`](./tarefas.md) → [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) (seção "Procedimento Padrão de Sessão")

---

### Situação: "Tenho dúvida sobre arquitetura/stack"
```
1. mapa-executivo-plataforma.md — stack canônico, decisões
2. docs/DECISÕES/ADR-*.md — decisões específicas (se existir)
3. CLAUDE.md — regra "Stack Canônico"
```
**Resultado:** Entender contexto estratégico.

**Leitura:** [`mapa-executivo-plataforma.md`](./mapa-executivo-plataforma.md) → [`docs/`](./docs/) → [`CLAUDE.md`](./CLAUDE.md)

---

### Situação: "Preciso rastrear histórico (o que foi feito?)"
```
1. tarefas-log.md — histórico append-only
2. tarefas-retomada.md — status resumido
3. git log — verificar commits
```
**Resultado:** Ver exatamente o que foi feito e quando.

**Leitura:** [`tarefas-log.md`](./tarefas-log.md) → [`tarefas-retomada.md`](./tarefas-retomada.md) → bash: `git log --oneline -20`

---

### Situação: "Estou bloqueado (não posso avançar)"
```
1. tarefas.md — há bloqueadores documentados?
2. tarefas-retomada.md — há bloqueadores conhecidos?
3. GUIA-OPERACIONAL.md — seção "Situações Comuns"
4. Avisar Wagner — se não resolver em 1 hora
```
**Resultado:** Desbloquear ou escalar.

**Leitura:** [`tarefas.md`](./tarefas.md) → [`tarefas-retomada.md`](./tarefas-retomada.md) → [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) → chamar Wagner

---

### Situação: "Esqueci como fazer algo (git, PR, etc.)"
```
1. ONE-PAGE-REFERENCE.md — referência rápida
2. docs/GIT-WORKFLOW-VERIFICAÇÃO.md — detalhes Git
3. GUIA-OPERACIONAL.md — procedimento detalhado
```
**Resultado:** Lembrar do processo.

**Leitura:** [`ONE-PAGE-REFERENCE.md`](./ONE-PAGE-REFERENCE.md) → [`docs/GIT-WORKFLOW-VERIFICAÇÃO.md`](./docs/GIT-WORKFLOW-VERIFICAÇÃO.md) → [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md)

---

## 📂 Todos os Documentos (Referência Completa)

### 🔴 TIER 1 — Máxima Prioridade

| Documento | Propósito | Público | Frequência |
|-----------|-----------|---------|-----------|
| [`CLAUDE.md`](./CLAUDE.md) | Regras do agente + git workflow | Agente | Início de sessão |
| [`mapa-executivo-plataforma.md`](./mapa-executivo-plataforma.md) | Visão estratégica Eco Zero Zero | Tech Lead + Agente | Início de sessão |
| [`tarefas-retomada.md`](./tarefas-retomada.md) | Handover entre sessões | Agente | Início de sessão |
| [`tarefas.md`](./tarefas.md) | Checklist de tarefas | Agente | Início de sessão |

### 🟡 TIER 2 — Alta Prioridade

| Documento | Propósito | Público | Frequência |
|-----------|-----------|---------|-----------|
| [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) | Procedimento dia a dia | Agente | Início de sprint |
| [`tarefas-objetivo.md`](./tarefas-objetivo.md) | Objetivos da sprint | Tech Lead + Agente | Início de sprint |
| [`README.md`](./README.md) | Setup + overview | Novo membro | Uma vez |

### 🟢 TIER 3 — Média Prioridade

| Documento | Propósito | Público | Frequência |
|-----------|-----------|---------|-----------|
| [`DASHBOARD-ARQUIVOS-CRITICOS.md`](./DASHBOARD-ARQUIVOS-CRITICOS.md) | Mapa de todos os docs | Tech Lead + Agente | Mensal |
| [`MAPA-VISUAL.md`](./MAPA-VISUAL.md) | Visualização em ASCII | Tech Lead + Agente | Mensal |
| [`ONE-PAGE-REFERENCE.md`](./ONE-PAGE-REFERENCE.md) | Cartão de referência rápida | Agente | Contínuo |
| [`docs/GIT-WORKFLOW-VERIFICAÇÃO.md`](./docs/GIT-WORKFLOW-VERIFICAÇÃO.md) | Verificações Git obrigatórias | Agente | A cada PR |
| [`docs/DECISÕES/ADR-*.md`](./docs/DECISÕES/) | Architecture Decision Records | Tech Lead + Time | Por decisão |

---

## 🔍 Buscar por Tópico

### Git & Workflow
- **"Como fazer uma PR?"** → [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) (seção "Fluxo de Trabalho")
- **"Qual é o git workflow?"** → [`CLAUDE.md`](./CLAUDE.md) (seção "Git Workflow")
- **"Verificações após git push?"** → [`docs/GIT-WORKFLOW-VERIFICAÇÃO.md`](./docs/GIT-WORKFLOW-VERIFICAÇÃO.md)
- **"Fluxo padrão de PR completo?"** → [`docs/GIT-WORKFLOW-VERIFICAÇÃO.md`](./docs/GIT-WORKFLOW-VERIFICAÇÃO.md) (seção "Fluxo Padrão de PR")

### Stack Técnico
- **"Qual stack usar?"** → [`mapa-executivo-plataforma.md`](./mapa-executivo-plataforma.md) (seção "Stack Canônico")
- **"Posso usar X?"** → [`mapa-executivo-plataforma.md`](./mapa-executivo-plataforma.md) + [`CLAUDE.md`](./CLAUDE.md)
- **"Por que Bun e não Node?"** → [`mapa-executivo-plataforma.md`](./mapa-executivo-plataforma.md) ou ADR correspondente em [`docs/DECISÕES/`](./docs/DECISÕES/)

### Documentação Viva
- **"Que docs preciso atualizar?"** → [`DASHBOARD-ARQUIVOS-CRITICOS.md`](./DASHBOARD-ARQUIVOS-CRITICOS.md) (seção "Arquivos Críticos a Manter")
- **"Como atualizar tarefas-log?"** → [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) (seção "Fim de Sessão")
- **"Quando atualizar mapa executivo?"** → [`DASHBOARD-ARQUIVOS-CRITICOS.md`](./DASHBOARD-ARQUIVOS-CRITICOS.md) (seção "Tier 1")

### Operacional
- **"Procedimento padrão de sessão?"** → [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) (seção "Procedimento Padrão de Sessão")
- **"Checklist de fim de sessão?"** → [`ONE-PAGE-REFERENCE.md`](./ONE-PAGE-REFERENCE.md) (seção "Obrigações de Fim de Sessão")
- **"Cadência de trabalho?"** → [`MAPA-VISUAL.md`](./MAPA-VISUAL.md) (seção "Cadência Operacional")

### Troubleshooting
- **"Commitei em dev por acidente"** → [`ONE-PAGE-REFERENCE.md`](./ONE-PAGE-REFERENCE.md) (seção "Situações Comuns")
- **"main e dev dessincronizados"** → [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) (seção "Situações Comuns")
- **"Estou bloqueado"** → [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) (seção "Situações Comuns") + avisar Wagner

---

## 🎯 Fluxo de Leitura por Perfil

### Perfil: Tech Lead (Wagner)
```
1. Ler TUDO (visão estratégica)
2. Escrever: mapa-exec, tarefas-obj, ADR, CLAUDE.md
3. Revisar: tarefas-log, tarefas-retomada, PRs
4. Atualizar: DASHBOARD e MAPA-VISUAL (mensal)
```

### Perfil: Agente (Executor)
```
Início de sessão:
  1. CLAUDE.md (5 min)
  2. mapa-executivo-plataforma.md (10 min)
  3. tarefas-retomada.md (5 min)
  4. tarefas.md (5 min)

Durante trabalho:
  5. GUIA-OPERACIONAL.md (conforme necessário)
  6. ONE-PAGE-REFERENCE.md (consulta rápida)
  7. docs/GIT-WORKFLOW-VERIFICAÇÃO.md (a cada PR)

Fim de sessão:
  8. tarefas-log.md (append)
  9. tarefas-retomada.md (reescrever)
  10. tarefas.md (marcar progresso)
```

### Perfil: Novo Membro
```
Dia 1:
  1. README.md
  2. CLAUDE.md
  3. mapa-executivo-plataforma.md
  4. GUIA-OPERACIONAL.md

Dia 2:
  5. ONE-PAGE-REFERENCE.md
  6. MAPA-VISUAL.md
  7. DASHBOARD-ARQUIVOS-CRITICOS.md
  8. Conversar com Wagner (30 min): contexto, bloqueadores, próximos passos

Dia 3+:
  9. Começar com tarefas (ler tarefas-objetivo + tarefas.md)
```

---

## 📋 Checklist Rápida de Navegação

- [ ] Preciso entender a visão geral? → [`mapa-executivo-plataforma.md`](./mapa-executivo-plataforma.md)
- [ ] Preciso saber onde paramos? → [`tarefas-retomada.md`](./tarefas-retomada.md)
- [ ] Qual é a próxima tarefa? → [`tarefas.md`](./tarefas.md)
- [ ] Como fazer meu trabalho? → [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md)
- [ ] Preciso de referência rápida? → [`ONE-PAGE-REFERENCE.md`](./ONE-PAGE-REFERENCE.md)
- [ ] Preciso de verificações Git? → [`docs/GIT-WORKFLOW-VERIFICAÇÃO.md`](./docs/GIT-WORKFLOW-VERIFICAÇÃO.md)
- [ ] Preciso de história completa? → [`tarefas-log.md`](./tarefas-log.md)
- [ ] Preciso de decisão técnica? → [`docs/DECISÕES/`](./docs/DECISÕES/)

---

## 🚀 Links Importantes

| Link | Descrição |
|------|-----------|
| [`CLAUDE.md`](./CLAUDE.md) | Regras obrigatórias do agente |
| [`mapa-executivo-plataforma.md`](./mapa-executivo-plataforma.md) | Visão estratégica e stack |
| [`GUIA-OPERACIONAL.md`](./GUIA-OPERACIONAL.md) | Procedimento operacional |
| [`ONE-PAGE-REFERENCE.md`](./ONE-PAGE-REFERENCE.md) | Referência de bolso |
| [`DASHBOARD-ARQUIVOS-CRITICOS.md`](./DASHBOARD-ARQUIVOS-CRITICOS.md) | Mapa de todos os docs |
| [`MAPA-VISUAL.md`](./MAPA-VISUAL.md) | Visualizações em ASCII |
| [`docs/GIT-WORKFLOW-VERIFICAÇÃO.md`](./docs/GIT-WORKFLOW-VERIFICAÇÃO.md) | Git verificações |

---

## 💡 Dica de Ouro

**Não sabe por onde começar?**

1. Se é seu **primeiro dia:** Ler `README.md` → `CLAUDE.md` → `mapa-executivo-plataforma.md` → `GUIA-OPERACIONAL.md`
2. Se é **início de sessão:** Ler `CLAUDE.md` → mapa → `tarefas-retomada.md` → `tarefas.md`
3. Se é **dúvida rápida:** Consultar `ONE-PAGE-REFERENCE.md`
4. Se é **muito bloqueado:** Avisar Wagner (não espere > 1 hora)

---

**Versão:** 1.0  
**Próxima revisão:** Após primeiro ciclo operacional  
**Mantido por:** Wagner
