# Dashboard de Arquivos Críticos — eco00-monorepo-template

**Propósito:** Mapa visual de todos os documentos que precisam estar sempre atualizados, para quê servem, quem mantém, e frequência de atualização.

**Status:** Mapeado como de 2026-06-05  
**Proxima revisão:** Após primeira ciclo operacional completo

---

## 🔴 Tier 1 — Máxima Prioridade (Consultar Todo Início de Sessão)

### 1. `mapa-executivo-plataforma.md`
**Propósito:** Bússola estratégica — visão macro do que Eco Zero Zero é, stack canônico, decisões.  
**Público:** Tech Lead (Wagner), Agente, Qualquer um tomando decisão técnica  
**Frequência de atualização:** Após decisão estratégica (mensal mínimo)  
**Gatilhos de mudança:**
- [ ] Nova tecnologia adotada no stack
- [ ] Produto entrando em produção
- [ ] Decisão sobre qual package usar como canônico
- [ ] Mudança na arquitetura de serviços

**Seções críticas:**
- "Stack Canônico" — nunca propor tecnologia que contradiz
- "Produtos" — estado real de cada um
- "O que não existe ainda" — gaps de infra/testing/docs

**Leitura:** 10 min. Obrigatória.

---

### 2. `tarefas-retomada.md`
**Propósito:** Handover entre sessões — contexto necessário para agente continuar onde parou  
**Público:** Agente (leitor obrigatório), Tech Lead (escrita)  
**Frequência:** Ao final de cada sessão (obrigatória)  
**Conteúdo:**
- Resumo do que foi feito
- Estado de cada fase (Phase 1, 2, 3...)
- Bloqueadores atuais
- PRs em aberto esperando revisão
- Próximas ações imediatas
- Links relevantes

**Leitura:** 5 min. Obrigatória no início.

---

### 3. `tarefas.md`
**Propósito:** Checklist executável — fases de trabalho, cada tarefa, estado  
**Público:** Agente (leitor), Tech Lead (escritor durante planejamento)  
**Frequência:** Atualizar ao iniciar/concluir tarefa  
**Formato:**
```markdown
### ✅ Fase 1: Fundações (CONCLUÍDA)
- [x] Tarefa 1
- [x] Tarefa 2

### 🔴 Fase 2: Backend (INICIANDO)
- [ ] Tarefa 3
- [ ] Tarefa 4 (bloqueado por X)
```

**Leitura:** 5 min. Obrigatória.

---

### 4. `tarefas-log.md` (APPEND-ONLY)
**Propósito:** Histórico imutável — registro de tudo que foi feito, quando, e quem  
**Público:** Agente (escritor), Tech Lead (referência)  
**Frequência:** Atualizar ao final de cada sessão (obrigatória)  
**Formato:**
```markdown
## 2026-06-05T14:30-03:00

- Criada estrutura de Tier 1 docs
- Documentado mapa de arquivos críticos
- Iniciado procedimento operacional padrão
```

**Regra de ouro:** Nunca remover ou editar entradas antigas. Apenas APPEND.

**Leitura:** Consultar quando precisa rastrear o que foi feito.

---

## 🟡 Tier 2 — Alta Prioridade (Consultar Início de Sprint)

### 5. `CLAUDE.md`
**Propósito:** Regras operacionais do agente — git workflow, stack, documentos obrigatórios  
**Público:** Agente (leitor obrigatório)  
**Frequência:** Atualizar quando workflow mudar (ex: nova ferramenta)  
**Seções críticas:**
- "Leitura Obrigatória" — ordem de documentos
- "Git Workflow" — regras inegociáveis
- "Stack Canônico" — nunca contradizer sem sinalizar

**Leitura:** 5 min. Obrigatória (pelo menos skim).

---

### 6. `tarefas-objetivo.md`
**Propósito:** Objetivos da sessão/sprint — o que estamos tentando alcançar  
**Público:** Tech Lead (escritor), Agente (leitor)  
**Frequência:** Ao iniciar sprint (semanal)  
**Conteúdo:**
- Objetivo macro (1 frase)
- Escopo (o que entra, o que NÃO entra)
- Stack confirmado
- Decisões pendentes
- Definição de Pronto (DoD)

**Leitura:** 5 min.

---

### 7. `GUIA-OPERACIONAL.md`
**Propósito:** Procedimento dia a dia — como submeter PR, atualizar docs, fluxo de desenvolvimento  
**Público:** Agente (referência contínua), Tech Lead (quando questionar fluxo)  
**Frequência:** Atualizar quando processo muda  
**Seções principais:**
- Fluxo de trabalho (branch → PR → dev → main)
- Checklist de decisão
- Situações comuns & resoluções
- Cadência de revisão

**Leitura:** Conforme necessário (não é memorizar).

---

## 🟢 Tier 3 — Média Prioridade (Consultar Quando Relevante)

### 8. `docs/GIT-WORKFLOW-VERIFICAÇÃO.md`
**Propósito:** Verificações obrigatórias após cada operação Git crítica  
**Público:** Agente (referência durante git ops)  
**Frequência:** Atualizar quando git workflow muda  
**Seções críticas:**
- Verificação após `git push`
- Verificação após `gh pr create`
- Fluxo padrão de PR (zero até link confirmado)
- Fluxo pós-aprovação do TL

**Consultar:** Sempre que fazer push/PR.

---

### 9. `mapa-executivo-produto.md`
**Propósito:** Template para cada produto criar seu próprio mapa  
**Público:** Tech Lead de cada produto (escritor e leitor)  
**Frequência:** Criar novo ao iniciar novo produto  
**Diferença com mapa-executivo-plataforma:**
- Plataforma = "o que estamos construindo como Eco Zero Zero"
- Produto = "o que ESTE produto é, para quem, por quê"

**Exemplo:** brcitas tem seu próprio `brcitas/mapa-executivo-produto.md`

---

### 10. `docs/DECISÕES/ADR-*.md`
**Propósito:** Architecture Decision Records — rastreamento formal de decisões técnicas  
**Público:** Tech Lead (escritor), Time (leitor)  
**Frequência:** Criar novo quando há decisão importante  
**Formato:**
```markdown
# ADR-001: Escolha de ORM

## Contexto
Precisamos de acesso a banco de dados...

## Decisão
Escolhemos Drizzle porque...

## Consequências
Pros: ...
Cons: ...
```

**Listar em:** `tarafas-log.md` quando criado.

---

### 11. `README.md`
**Propósito:** Visão geral + setup do repositório  
**Público:** Novo desenvolvedor (leitor), Tech Lead (escritor)  
**Frequência:** Atualizar quando setup muda  
**Conteúdo obrigatório:**
- O que é este repositório
- Requisitos (Bun, Git, etc.)
- Session setup (export de PAT, etc.)
- Como autenticar `gh`
- Como clonar, instalar, rodar

---

## 📊 Matriz de Responsabilidades

| Documento | Quem Escreve | Quem Lê | Frequência | Atualizar quando |
|-----------|-------------|---------|-----------|------------------|
| mapa-executivo-plataforma.md | Wagner (TL) | Agente + TL | Mensal | Decisão estratégica |
| tarefas-retomada.md | Agente | Agente + Wagner | Fim de sessão | Fim de cada trabalho |
| tarefas.md | Wagner (TL) | Agente | Semanal | Novo sprint |
| tarefas-log.md | Agente | Wagner + Agente | Fim de sessão | Fim de cada trabalho |
| CLAUDE.md | Wagner (TL) | Agente | Conforme muda | Workflow muda |
| tarefas-objetivo.md | Wagner (TL) | Agente | Início de sprint | Nova sprint |
| GUIA-OPERACIONAL.md | Wagner (TL) | Agente | Conforme muda | Processo muda |
| GIT-WORKFLOW-VERIFICAÇÃO.md | Wagner (TL) | Agente | Conforme muda | Git workflow muda |
| ADR-*.md | Wagner (TL) | Time | Por decisão | Decisão importante |
| README.md | Agente | Novo dev | Conforme muda | Setup muda |

---

## 🔗 Fluxo de Leitura por Situação

### Situação 1: "Começando nova sessão"
```
1. CLAUDE.md (5 min)
2. mapa-executivo-plataforma.md (10 min)
3. tarefas-retomada.md (5 min)
4. tarefas.md (5 min)
```
**Total:** 25 min de contexto.

---

### Situação 2: "Pronto para começar a codificar"
```
1. tarefas.md (ver próxima tarefa)
2. tarefas-objetivo.md (o que estamos tentando)
3. GUIA-OPERACIONAL.md (checklist de decisão)
```
**Total:** 10 min.

---

### Situação 3: "Vou submeter PR"
```
1. GUIA-OPERACIONAL.md (checklist DoD)
2. docs/GIT-WORKFLOW-VERIFICAÇÃO.md (fluxo padrão de PR)
3. CLAUDE.md (git workflow)
```
**Total:** 10 min.

---

### Situação 4: "Finalizando sessão"
```
1. tarefas-log.md (adicionar entrada)
2. tarefas-retomada.md (atualizar estado)
3. tarefas.md (marcar progresso)
4. Fazer commit: "chore: update session logs"
```
**Total:** 15 min.

---

## 🎯 Checklist de Manutenção Mensal

- [ ] `mapa-executivo-plataforma.md` está refletindo decisões recentes?
- [ ] `tarefas.md` tem bloqueadores documentados?
- [ ] Há PRs muito antigas em aberto? (> 1 semana)
- [ ] Há branches stale localmente? (fazer prune)
- [ ] `tarefas-log.md` tem mínimo uma entrada por sessão?
- [ ] Faltam ADRs para decisões tomadas? (criar)
- [ ] `GUIA-OPERACIONAL.md` está atualizado com processo atual?

---

## 📈 Indicadores de Saúde

**Sinal Verde:**
- ✅ `tarefas-log.md` tem entrada no último dia
- ✅ `tarefas-retomada.md` é recente (< 1 dia)
- ✅ `mapa-executivo-plataforma.md` reflete stack atual
- ✅ Nenhuma PR > 3 dias sem revisão
- ✅ Branches locais sincronizadas com remote

**Sinal Amarelo:**
- ⚠️ `tarefas-log.md` sem entrada há 2+ dias
- ⚠️ `tarefas-retomada.md` > 1 semana desatualizado
- ⚠️ PR aguardando revisão > 3 dias
- ⚠️ Branches stale no local (não foram deletadas)
- ⚠️ `tarefas.md` com muitas tarefas bloqueadas

**Sinal Vermelho:**
- 🔴 `tarefas-log.md` sem entrada há 1+ semana
- 🔴 `mapa-executivo-plataforma.md` desatualizado (novidade não documentada)
- 🔴 PR > 1 semana sem revisão
- 🔴 main e dev dessincronizados
- 🔴 Múltiplas tarefas não começadas

---

## 🚀 Próximas Ações (Após Leitura)

1. [ ] Tech Lead revisar este dashboard
2. [ ] Agente criar branch: `feat/operational-framework`
3. [ ] Todos os documentos (GUIA-OPERACIONAL.md incluído) ficam em `main`
4. [ ] Ajustar cadência mensal de revisão conforme experiência
5. [ ] Adicionar ADRs para decisões já tomadas

---

**Versão:** 1.0  
**Mantido por:** Wagner + Agente  
**Próxima revisão:** 2026-06-12 (ou quando primeira sessão se completar)
