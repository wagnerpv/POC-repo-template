# Guia Operacional — eco00-monorepo-template

**Propósito:** Estabelecer fluxo de trabalho para manter a plataforma BOX00 operacional, com documentos sempre atualizados, sem merges diretos em `main`, e ciclo de desenvolvimento separado.

**Última atualização:** 2026-06-05  
**Mantido por:** Agente + Tech Lead (Wagner)

---

## 📋 Arquivos Críticos a Manter Atualizados

Estes documentos formam o "ciclo nervoso" da plataforma. Devem estar em sincronismo contínuo.

### 1. **Mapas Executivos** (Visão Estratégica)
| Arquivo | Quem | Frequência | Gatilho |
|---------|------|-----------|---------|
| `mapa-executivo-plataforma.md` | Tech Lead (Wagner) | Após decisão estratégica | Nova tecnologia, produto, mudança de direção |
| `mapa-executivo-produto.md` | Tech Lead de cada produto | Por produto | Novo produto criado a partir do template |

**Conteúdo mínimo:**
- O que é (1 frase)
- Por que existe
- Público-alvo / Escopo
- Estado atual
- Decisões estratégicas pendentes
- Perguntas para decisão rápida

**Quando atualizar:** Sempre que o roadmap, stack canônico ou direção mudar.

---

### 2. **Tarefas & Progressão** (Rastreamento de Trabalho)

| Arquivo | Tipo | Frequência | Propósito |
|---------|------|-----------|----------|
| `tarefas.md` | Checklist | A cada início de sprinta | Estado das tarefas, fases, bloqueadores |
| `tarefas-objetivo.md` | Objetivos | Ao iniciar sprint | O que estamos tentando alcançar (macro) |
| `tarefas-log.md` | Append-only | Ao final de cada sessão | Histórico imutável do que foi feito |
| `tarefas-retomada.md` | Handover | Ao final de cada sessão | Contexto para próxima sessão começar |

**Regras de cada arquivo:**

#### `tarefas.md`
- Checklist com fases (Phase 1, 2, 3, 4...)
- Marcar progresso: ✅ (done), 🔴 (in progress), ⬜ (not started)
- Adicionar bloqueadores e notas

#### `tarefas-objetivo.md`
- Objetivos macro (ex: "Consolidar SSR foundations como package")
- Escopo (o que entra, o que não entra)
- Stack canônico confirmado
- Decisões pendentes

#### `tarefas-log.md` (APPEND-ONLY)
```markdown
## 2026-06-05T14:30-03:00
- Criado branch `feat/operational-framework`
- Documentado arquivo de Mapas Executivos
- ...adicionar mais bullets...
```
- Nunca remover ou editar entradas antigas
- Nova seção ao final com data ISO 8601
- Bullets indicando que foi feito

#### `tarefas-retomada.md`
- Resumo do contexto atual
- Estado de cada fase
- O que está bloqueado e por quê
- Próximos passos imediatos
- Links para PRs em aberto

---

### 3. **Documentação de Referência** (Viva)

| Arquivo | Propósito | Atualizar quando |
|---------|-----------|-----------------|
| `README.md` | Visão geral + setup | Bootstrap muda, novo setup |
| `CLAUDE.md` | Regras do agente | Workflow muda, novas decisões |
| `docs/GIT-WORKFLOW-VERIFICAÇÃO.md` | Verificações Git obrigatórias | Processo de PR muda |
| `docs/DECISÕES/ADR-*.md` | Architecture Decision Records | Nova decisão técnica importante |

---

## 🔄 Fluxo de Trabalho — Nunca Direto em Main

```
main (production-ready sempre)
  ↓ [fork]
  ├─ dev (branch de desenvolvimento sempre ativa)
  │   ├─ feat/feature-1 → PR #1 → merge → dev atualiza
  │   ├─ feat/feature-2 → PR #2 → merge → dev atualiza
  │   └─ feat/feature-3 → PR #3 → merge → dev atualiza
  │
  └─ Periodicamente (após n features + testes):
      dev → PR (para main) → Tech Lead revisa → merge
```

### Regras Inegociáveis

**1. Nunca commitar diretamente em `main` ou `dev`**
```bash
# ❌ ERRADO
git checkout main && git commit -m "..."

# ✅ CORRETO
git checkout -b feat/seu-feature
git commit -m "..."
git push origin feat/seu-feature
gh pr create --base dev --head feat/seu-feature
```

**2. Fluxo de PR sempre**
- `feat/xxx` → PR (base: `dev`) → Tech Lead aprova → merge
- Após merge: sincronizar `dev`, deletar branch

**3. Dev como integração**
- Sempre atualizada com features testadas
- Serve como "staging" antes de `main`
- Permite validação contínua

**4. Main = Sempre Pronto**
- Apenas merges de `dev` testado
- Commits rastreáveis em `tarefas-log.md`
- Sem "apenas um commit rápido"

---

## 📝 Procedimento Padrão de Sessão (Agente)

### Início de Sessão
```bash
# 1. Ler documentos de contexto (15 min)
cat CLAUDE.md
cat mapa-executivo-plataforma.md
cat tarefas-retomada.md
cat tarefas.md

# 2. Sincronizar repositório
git fetch --all --prune
git checkout dev
git pull --ff-only origin dev

# 3. Verificar estado
git status
git branch -vv
```

### Durante Trabalho
```bash
# 1. Criar branch
git checkout -b feat/seu-feature
# Trabalhar...

# 2. Commitar com mensagem clara
git commit -m "feat: descrição do que foi feito"

# 3. Push e PR
git push origin feat/seu-feature
gh pr create --title "feat: ..." --base dev --head feat/seu-feature

# 4. Esperar aprovação do Tech Lead
```

### Fim de Sessão (Obrigatório)
```bash
# 1. Atualizar tarefas-log.md (append-only)
# Data ISO 8601, bullets do que foi feito

# 2. Atualizar tarefas-retomada.md
# Estado atual, bloqueadores, próximos passos

# 3. Commitar atualizações
git add tarefas-log.md tarefas-retomada.md
git commit -m "chore: update session logs"
git push origin <branch-atual>
```

---

## 🎯 Checklist de Decisão

Antes de implementar qualquer feature ou mudança, responder:

### Estrutura de Decisão
```
[ ] É nova feature ou manutenção?
[ ] Afeta stack canônico ou apenas um produto?
[ ] Tem que estar em mapa-executivo-plataforma.md?
[ ] Exige ADR (Architecture Decision Record)?
[ ] Tem testes antes de submeter PR?
[ ] Docs foram atualizadas?
[ ] tarefas-log.md será atualizado?
```

### Critérios de Definição de Pronto (DoD)
- [ ] Código em feature branch (não main/dev)
- [ ] PR aberta com base em `dev`
- [ ] Testes passando
- [ ] Documentação atualizada (README, mapa, ADR se necessário)
- [ ] Tech Lead aprovado
- [ ] tarefas-log.md atualizado

---

## 📊 Estrutura de Arquivos Críticos

```
eco00-monorepo/
├── README.md                                    # Setup + overview
├── CLAUDE.md                                    # Regras do agente
├── GUIA-OPERACIONAL.md                          # ← Este arquivo
├── mapa-executivo-plataforma.md                 # Visão estratégica
├── mapa-executivo-produto.md                    # Template para produtos
├── tarefas.md                                   # Checklist de tarefas
├── tarefas-objetivo.md                          # Objetivos macro
├── tarefas-log.md                               # Histórico append-only
├── tarefas-retomada.md                          # Handover entre sessões
├── docs/
│   ├── GIT-WORKFLOW-VERIFICAÇÃO.md              # Regras de verificação Git
│   ├── DECISÕES/                                # Architecture Decision Records
│   │   ├── ADR-001.md                           # Exemplo: Decisão de stack
│   │   └── ADR-002.md
│   └── [análises, pesquisa, referências]
├── apps/                                        # Aplicações (full-stack, APIs)
├── packages/                                    # Packages reutilizáveis
└── .local/                                      # Artifacts locais (gitignored)
```

---

## 🔗 Vinculações Entre Documentos

```
mapa-executivo-plataforma.md
    ↓ (define direção)
    ↓ (responde: o que estamos construindo?)
    ↓
tarefas-objetivo.md
    ↓ (quebra em fases)
    ↓ (responde: como vamos alcançar?)
    ↓
tarefas.md
    ↓ (detalha tarefas individuais)
    ↓ (responde: quais são as ações?)
    ↓
[Desenvolvimento em branches feature]
    ↓ (cada commit, comentário)
    ↓
tarefas-log.md (append-only)
    ↓ (registra o que foi feito)
    ↓
tarefas-retomada.md
    ↓ (resume estado para próxima sessão)
    ↓
[Próxima sessão lê e continua]
```

---

## 🚨 Situações Comuns & Resoluções

### Situação 1: "Preciso fazer uma mudança rápida em main"
**Não faça.** Sempre:
1. `git checkout -b fix/descricao`
2. Fazer a mudança
3. Submeter PR (base: `dev`)
4. Esperar aprovação

### Situação 2: "A branch do meu colega foi deletada remotamente"
**Sincronizar:**
```bash
git fetch --all --prune
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
```

### Situação 3: "Dev e main ficaram dessincronizados"
**Recuperar:**
```bash
git checkout dev
git pull --ff-only origin dev
git log --oneline -5                 # Verificar estado
# Se dev está atrasado:
git merge origin/main                # Trazer commits de main
```

### Situação 4: "Eu commitei em dev por acidente"
**Mover para branch:**
```bash
git reset HEAD~1                      # Desfazer commit (arquivos permanecem)
git checkout -b feat/seu-feature
git add <files>
git commit -m "feat: ..."
git push origin feat/seu-feature
```

---

## 📅 Cadência de Revisão

| Frequência | O que | Quem | Onde |
|-----------|------|------|------|
| A cada sessão | tarefas-log.md | Agente | Append ao final |
| A cada sessão | tarefas-retomada.md | Agente | Reescrever estado |
| Semanal | tarefas.md | Tech Lead | Atualizar progresso |
| Mensal | mapa-executivo-plataforma.md | Tech Lead | Se houver decisão estratégica |
| Sempre que há decisão | ADR nova | Tech Lead | Criar em docs/DECISÕES/ |

---

## ✅ Resumo Operacional

**O que NÃO fazer:**
- ❌ Commitar em `main` ou `dev` diretamente
- ❌ Deixar branch local sem ser sincronizada com remote
- ❌ Não atualizar tarefas-log.md ao final da sessão
- ❌ Fazer merge sem Tech Lead revisar
- ❌ Não verificar stack canônico antes de propor tech
- ❌ Deixar documento vivo desatualizado

**O que SEMPRE fazer:**
- ✅ Criar branch para cada feature (`feat/xxx`)
- ✅ Submeter PR (base: `dev`)
- ✅ Esperar aprovação do Tech Lead
- ✅ Atualizar `tarefas-log.md` (append-only) ao final de sessão
- ✅ Manter `tarefas-retomada.md` com estado atual
- ✅ Verificar stack canônico em `mapa-executivo-plataforma.md`
- ✅ Sincronizar local = remote (sempre)

---

## 🎓 Leitura Obrigatória de Referência

1. `CLAUDE.md` — Regras do agente (ler no início de cada sessão)
2. `mapa-executivo-plataforma.md` — Decisões estratégicas
3. `docs/GIT-WORKFLOW-VERIFICAÇÃO.md` — Verificações Git
4. Este arquivo (`GUIA-OPERACIONAL.md`) — Operações do dia a dia

---

## 📞 Quando Chamar Tech Lead

- [ ] Decisão estratégica que não está em `mapa-executivo-plataforma.md`
- [ ] Conflito no fluxo Git
- [ ] PR bloqueada
- [ ] Dúvida sobre stack canônico
- [ ] Novo produto criado (precisa preencher `mapa-executivo-produto.md`)

---

**Versão:** 1.0  
**Próxima revisão:** Após primeira sessão operacional completa
