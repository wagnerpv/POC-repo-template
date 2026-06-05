# One-Page Reference — eco00-monorepo-template

**Cartão de referência rápida.** Imprima ou pin na aba do navegador.

---

## 📚 Tier 1 — Ler Todo Início (25 min)

| Arquivo | O Quê | Quem | Quando |
|---------|-------|------|--------|
| **CLAUDE.md** | Regras do agente + git | Agente | Sempre |
| **mapa-executivo-plataforma.md** | Visão estratégica BOX00 | Agente + Wagner | Sempre |
| **tarefas-retomada.md** | Onde paramos | Agente | Sempre |
| **tarefas.md** | Tarefas + progresso | Agente | Sempre |

---

## 🔄 Git Workflow em 6 Passos

```bash
# 1. Começar nova feature
git checkout dev && git pull --ff-only origin dev
git checkout -b feat/seu-feature

# 2. Trabalhar + commitar (com mensagem clara)
git commit -m "feat: descrição"

# 3. Verificar que está tudo ok
git log origin/dev..HEAD --oneline          # commits novos
git status                                  # nada em staging

# 4. Push para remoto
git push origin feat/seu-feature
git log origin/feat/seu-feature --oneline -1  # verificar

# 5. Criar PR (base: dev, não main!)
gh pr create --title "feat: ..." --base dev

# 6. Esperar Wagner aprova + merge
# Depois:
git checkout dev
git pull --ff-only origin dev
git branch -D feat/seu-feature
git push origin --delete feat/seu-feature
```

**REGRA DE OURO:** Nunca commitar em `main` ou `dev`. Sempre `feat/xxx → PR → dev`.

---

## 📋 Stack Canônico (Não Desviar)

| Camada | Stack | Alternativa | Nota |
|--------|-------|-------------|------|
| **Runtime** | Bun | ~~Node.js~~ | Sem exceção |
| **Linguagem** | TypeScript strict | ~~JS~~ | Sem exceção |
| **Frontend** | Astro | POC-astro00 em transição | Sem React puro |
| **Backend** | eco00-event-system | Sem APIs diretas entre serviços | Via barramento |
| **Banco** | MySQL (prod) + SQLite | Não mudar | ACID sempre |
| **Infra** | Docker + Caddy | Sem PM2, sem Node | `unless-stopped` |
| **HTTP Client** | Bun.fetch | ~~Axios~~ | Nativo |

**Regra:** Propor tech diferente? Avisar Wagner + justificar contra mapa-executivo.

---

## ✅ Checklist Antes de Submeter PR

```
[ ] Código em branch feat/xxx (não main/dev)
[ ] Tests passando (bun test)
[ ] Sem console.log, debugger, dead code
[ ] Documentação atualizada (README, docs, etc.)
[ ] Commit messages claras (feat:, fix:, chore:)
[ ] Stack canônico verificado (mapa-executivo-plataforma.md)
[ ] git log mostra commits novos
[ ] gh pr create pronto com base dev
```

**Depois de PR aprovado e mergeado:**
```
[ ] git pull dev
[ ] git branch -D feat/xxx (local)
[ ] git push origin --delete feat/xxx (remote)
```

---

## 📝 Obrigações de Fim de Sessão

**Agente DEVE fazer:**

```bash
# 1. Atualizar tarefas-log.md (append)
# Adicionar nova seção:
## 2026-06-05T14:30-03:00
- Feito A
- Feito B

# 2. Atualizar tarefas-retomada.md
# Reescrever estado, bloqueadores, próximos passos

# 3. Atualizar tarefas.md
# Marcar tarefas concluídas (✅)

# 4. Commitar tudo
git add tarefas-log.md tarefas-retomada.md tarefas.md
git commit -m "chore: update session logs"
git push origin <branch-atual>
```

**Sem isso, próxima sessão começa cega.**

---

## 🚨 Situações Comuns

| Problema | Solução |
|----------|---------|
| "Preciso fazer mudança em main" | Não faça. Criar branch sempre. |
| "Meu colega deletou a branch dele" | `git fetch --all --prune` |
| "Commitei em dev por acidente" | `git reset HEAD~1` → criar branch → re-commit |
| "main e dev estão dessincronizados" | `git checkout dev && git merge origin/main` |
| "Não lembro o que estava fazendo" | Ler `tarefas-retomada.md` |
| "Preciso de nova tecnologia" | Consultar `mapa-executivo-plataforma.md` antes |

---

## 📅 Cadência Padrão

```
SEGUNDA    ← Agente lê 4 documentos Tier 1 (25 min)
SEGUNDA    ← Wagner confirma tarefas-objetivo.md
TER-QUI    ← Desenvolvimento: branch → commits → PRs
TER-QUI    ← Wagner revisa PRs diariamente
SEXTA      ← Agente tira últimas PRs
SEXTA      ← Wagner faz merge de tudo em dev
SEXTA      ← Agente: atualiza 3 documentos (tarefas-log, retomada, tarefas)
SEGUNDA    ← Novo ciclo começa
```

---

## 🔗 Quick Links

| O quê | Onde |
|-------|------|
| Regras git | `docs/GIT-WORKFLOW-VERIFICAÇÃO.md` |
| Procedimento dia a dia | `GUIA-OPERACIONAL.md` |
| Mapa visual | `MAPA-VISUAL.md` |
| Todos os arquivos críticos | `DASHBOARD-ARQUIVOS-CRITICOS.md` |
| Decisões técnicas | `docs/DECISÕES/ADR-*.md` |

---

## 📊 Responsabilidades

```
Wagner (Tech Lead)          Agente (Executor)
─────────────────          ──────────────────
Escreve:                    Escreve:
- mapa-executivo           - tarefas-log (append)
- tarefas-objetivo         - tarefas-retomada
- CLAUDE.md                
- ADR-*.md                 

Lê sempre:                  Lê sempre:
- tarefas-log              - CLAUDE.md
- tarefas.md               - mapa-executivo
- tarefas-retomada         - tarefas-objetivo
                            - tarefas.md
                            
Aprova:                     Submete:
- PRs                       - PRs (sempre)
- Merges dev → main         - Session logs
- Decisões técnicas         - Documentação
```

---

## 🎯 O Que NÃO Fazer

```
❌ Commitar diretamente em main ou dev
❌ Fazer PR com base em main (sempre dev!)
❌ Deixar PR > 3 dias sem revisão
❌ Não atualizar tarefas-log.md ao final de sessão
❌ Propor tech não em stack canônico sem avisar
❌ Deixar branches stale (delete após merge)
❌ Fazer merge próprio PR (Wagner faz)
❌ Não verificar git push antes de continuar
❌ Deixar main e dev dessincronizados
```

---

## ✅ O Que SEMPRE Fazer

```
✅ Criar branch para cada feature (feat/xxx)
✅ Submeter PR com base em dev
✅ Esperar Wagner revisar e aprovar
✅ Sincronizar local = remote (sempre)
✅ Atualizar tarefas-log.md (obrigatório)
✅ Atualizar tarefas-retomada.md (obrigatório)
✅ Verificar stack canônico antes de propor tech
✅ Ler mapa-executivo-plataforma.md toda semana
✅ Perguntar se bloqueado (não esperar sozinho)
```

---

## 🔴 Se Algo Falhar

1. **Parar imediatamente** — não continuar
2. **Avisar Wagner** — qual é o problema exato
3. **Investigar** — o que deu errado
4. **Corrigir** — fix + verificar + tentar novamente

---

## 📞 Quando Chamar Wagner

- [ ] Decisão estratégica não em mapa
- [ ] Conflito de PR
- [ ] Bloqueador > 1 hora
- [ ] Dúvida sobre stack canônico
- [ ] PR esperando revisão > 1 dia
- [ ] Novo produto (precisa preencher mapa-executivo-produto)

---

**Versão:** 1.0  
**Use:** Imprima ou pin na aba do navegador  
**Próxima atualização:** Após primeiro ciclo completo
