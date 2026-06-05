# Mapa Visual — eco00-monorepo-template

> Visualização rápida da estrutura, fluxo de trabalho e responsabilidades.

---

## 📐 Fluxo de Documentos — "Ciclo Nervoso"

```
┌─────────────────────────────────────────────────────────────────┐
│                    VISÃO ESTRATÉGICA                             │
│                                                                   │
│   mapa-executivo-plataforma.md                                   │
│   "O que estamos construindo como BOX00"                         │
│   (Stack canônico, produtos, decisões, o que não existe)        │
│                                                                   │
│   Leitura: Wagner (escritor) + Agente (consultor)                │
│   Frequência: Mensal ou após decisão                             │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    PLANEJAMENTO DE SPRINT                         │
│                                                                   │
│   tarefas-objetivo.md                                             │
│   "O que vamos tentar fazer neste ciclo?"                        │
│   (Objetivo macro, escopo, stack, decisões pendentes)            │
│                                                                   │
│   Leitura: Wagner (escritor) + Agente (executor)                 │
│   Frequência: Início de sprint (semanal)                         │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    EXECUÇÃO (TAREFAS)                             │
│                                                                   │
│   tarefas.md                                                      │
│   "Quais são as ações individuais?"                              │
│   (Checklist com fases, progresso, bloqueadores)                 │
│                                                                   │
│   Leitura: Agente (consultor) + Wagner (revisor)                 │
│   Frequência: A cada início de tarefa                            │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                [DESENVOLVIMENTO EM BRANCHES]                      │
│                                                                   │
│                git checkout -b feat/xxx                           │
│                [fazer mudanças]                                  │
│                git push origin feat/xxx                           │
│                gh pr create --base dev                            │
│                [Tech Lead aprova]                                │
│                git merge (TL faz)                                │
│                                                                   │
│          Registrado em: tarefas-log.md (commit ref)              │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    REGISTRO HISTÓRICO                             │
│                                                                   │
│   tarefas-log.md (APPEND-ONLY)                                    │
│   "O que foi feito, quando, por quem?"                           │
│                                                                   │
│   ## 2026-06-05T14:30-03:00                                      │
│   - Feito X                                                       │
│   - Feito Y                                                       │
│                                                                   │
│   Escritor: Agente (obrigatório ao final de sessão)              │
│   Frequência: Append ao final de cada sessão                     │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    RESUMO PARA PRÓXIMA SESSÃO                     │
│                                                                   │
│   tarefas-retomada.md                                             │
│   "Onde paramos? O que vem depois?"                              │
│                                                                   │
│   - Resumo do que foi feito                                       │
│   - Estado de cada fase                                           │
│   - Bloqueadores atuais                                           │
│   - Próximas ações imediatas                                      │
│                                                                   │
│   Escritor: Agente (obrigatório ao final de sessão)              │
│   Frequência: Atualizar ao final de cada sessão                  │
└─────────────────────────────────────────────────────────────────┘
                              ↓
                   [NOVA SESSÃO COMEÇA]
                   Agente lê 4 documentos
                              ↓
                   [Continuar de onde parou]
```

---

## 🌳 Estrutura de Arquivos Críticos

```
eco00-monorepo/
│
├── 🔴 TIER 1 — MÁXIMA PRIORIDADE (consultar todo início)
│   ├── mapa-executivo-plataforma.md        [Bússola estratégica]
│   ├── tarefas-retomada.md                 [Handover entre sessões]
│   ├── tarefas.md                          [Checklist de tarefas]
│   └── tarefas-log.md                      [Histórico append-only]
│
├── 🟡 TIER 2 — ALTA PRIORIDADE (consultar início de sprint)
│   ├── CLAUDE.md                           [Regras do agente]
│   ├── tarefas-objetivo.md                 [Objetivos da sprint]
│   ├── GUIA-OPERACIONAL.md                 [Dia a dia operacional]
│   └── DASHBOARD-ARQUIVOS-CRITICOS.md      [Este mapa]
│
├── 🟢 TIER 3 — MÉDIA PRIORIDADE (consultar quando relevante)
│   ├── README.md                           [Setup + overview]
│   ├── EXPLORAÇÃO.md                       [Status da exploração]
│   ├── docs/
│   │   ├── GIT-WORKFLOW-VERIFICAÇÃO.md     [Verificações Git]
│   │   ├── DECISÕES/
│   │   │   ├── ADR-001.md
│   │   │   └── ADR-002.md
│   │   └── [análises, pesquisa, referências]
│   ├── mapa-executivo-produto.md           [Template para produtos]
│   │
│   └── apps/                               [Aplicações]
│       └── [full-stack, APIs]
│
│   └── packages/                           [Packages reutilizáveis]
│       └── [@eco00/*, core-libs]
│
└── .local/                                 [Artifacts locais - gitignored]
```

---

## 🔄 Git Workflow — Fluxo Visual

```
                        main (sempre pronto)
                           ↑ (merge periodicamente)
                           │
                        [branch: dev] ← Integração contínua
                           ↑
        ┌──────────────────┼──────────────────┐
        │                  │                  │
    feat/f1          feat/f2              feat/f3
    (work)          (work)               (work)
        │                  │                  │
        └──→ PR #1    └──→ PR #2       └──→ PR #3
             (awaiting    (awaiting         (awaiting
              review)      review)           review)
        │                  │                  │
        └──→ [TL aprova] ──→ [TL aprova]  ──→ [TL aprova]
                               │
        ┌──────────────────────┤
        │                      │
   dev sincroniza ←────────────┘
        │
   [branches deletadas]
   [local = remote]
```

**Regra:** Nunca `main ← feature` direto. Sempre `feature → PR → dev (TL aprova) → dev → main (periodicamente)`.

---

## 📅 Cadência Operacional

```
SEMANA
├── Segunda (início)
│   ├── [1] Agente lê CLAUDE.md + 3 mapas executivos
│   ├── [2] Wagner revisa tarefas.md e cria tarefas-objetivo.md
│   └── [3] Agente começa execução
│
├── Segunda-Quinta (trabalho)
│   ├── Agente: branch → commits → PR
│   ├── Wagner: revisa e aprova PRs
│   ├── Agente: sincroniza dev, deleta branches
│   └── Agente: atualiza tarefas.md com progresso
│
└── Sexta (encerramento)
    ├── Agente: tira últimas PRs
    ├── Wagner: faz merge final de tudo
    ├── Agente: sincroniza main e dev
    └── **OBRIGATÓRIO:**
        ├── Atualizar tarefas-log.md (append)
        ├── Atualizar tarefas-retomada.md
        ├── Commit: "chore: update session logs"
        └── Push para a branch atual (ou dev se nada pendente)
```

---

## 🎯 Árvore de Decisão — O Que Fazer?

```
┌─ Preciso fazer uma mudança?
│
├─ É em main ou dev?
│  └─ NÃO! Criar branch: git checkout -b feat/xxx
│
├─ É uma nova feature?
│  ├─ SIM → tarefas.md já tem?
│  │  ├─ NÃO → Avisar Wagner
│  │  └─ SIM → Começar
│  └─ NÃO → É bugfix? Criar branch: fix/xxx
│
├─ Preciso de nova tecnologia?
│  ├─ Está em mapa-executivo-plataforma.md?
│  │  ├─ SIM → Usar
│  │  └─ NÃO → Avisar Wagner antes
│  └─ É para este produto ou plataforma?
│
├─ Pronto para PR?
│  ├─ Testes passam?
│  ├─ Docs atualizadas?
│  ├─ Matches stack canônico?
│  └─ Tudo OK? → Criar PR com base em dev
│
└─ Fim de sessão?
   ├─ Atualizar tarefas-log.md (append)
   ├─ Atualizar tarefas-retomada.md
   ├─ Commit e push
   └─ Pronto para próxima sessão
```

---

## 📊 Responsabilidades por Documento

```
                Wagner (TL)        Agente            Ambos
                ───────────        ──────            ─────
Escrever →      ╔═══════════════╗  ╔════════════╗  ╔═════════════╗
                ║ mapa-exec...  ║  ║ tarefas... ║  ║ CLAUDE.md   ║
                ║ tarefas-obj.. ║  ║ tarefas-... ║  ║ README.md   ║
                ║ CLAUDE.md     ║  ║ tarefas-log║  ║             ║
                ║ ADR-*.md      ║  ║            ║  ║             ║
                ╚═══════════════╝  ╚════════════╝  ╚═════════════╝

Ler/Consultar → ║ Lê antes de    ║ Lê SEMPRE que  ║ Ambos consultam
                ║ propor tech    ║ começa sesão   ║ durante trabalho
                ║ (obrigatório)  ║ (obrigatório)  ║
```

---

## ⏱️ Tempo de Leitura por Situação

```
┌─ Novo para o time?
│  └─ Ler TUDO (1 hora)
│     ├── README.md (5 min)
│     ├── CLAUDE.md (5 min)
│     ├── mapa-executivo-plataforma.md (10 min)
│     ├── GUIA-OPERACIONAL.md (15 min)
│     ├── DASHBOARD-ARQUIVOS-CRITICOS.md (10 min)
│     ├── tarefas-objetivo.md (5 min)
│     └── tarefas.md (5 min)
│
├─ Começando nova sessão?
│  └─ Ler Tier 1 + objetivo (25 min)
│     ├── CLAUDE.md (5 min)
│     ├── mapa-executivo-plataforma.md (10 min)
│     ├── tarefas-retomada.md (5 min)
│     ├── tarefas.md (5 min)
│     └── tarefas-objetivo.md (5 min)
│
├─ Vou fazer um commit/PR?
│  └─ Ler checklist (10 min)
│     ├── GUIA-OPERACIONAL.md (5 min)
│     └── docs/GIT-WORKFLOW-VERIFICAÇÃO.md (5 min)
│
└─ Finalizando sessão?
   └─ Atualizar docs (15 min)
      ├── tarefas-log.md append (5 min)
      ├── tarefas-retomada.md atualizar (5 min)
      ├── tarefas.md marcar progresso (5 min)
      └── Commit e push
```

---

## 🔗 Navegação Rápida

**Preciso de:** → **Consultar:**

- Visão geral do projeto → `README.md`
- Visão estratégica de BOX00 → `mapa-executivo-plataforma.md`
- Objetivo desta sprint → `tarefas-objetivo.md`
- Lista de tarefas → `tarefas.md`
- Histórico do que foi feito → `tarefas-log.md`
- Onde paramos na última vez → `tarefas-retomada.md`
- Como fazer um PR → `GUIA-OPERACIONAL.md`
- Verificações Git obrigatórias → `docs/GIT-WORKFLOW-VERIFICAÇÃO.md`
- Entender regras do agente → `CLAUDE.md`
- Mapa visual desta estrutura → `DASHBOARD-ARQUIVOS-CRITICOS.md` (este)

---

## ✅ Checklist para Novo Membro do Time

- [ ] Li `README.md`
- [ ] Li `CLAUDE.md` (entendi git workflow)
- [ ] Li `mapa-executivo-plataforma.md` (entendi visão)
- [ ] Li `GUIA-OPERACIONAL.md` (entendi processo dia a dia)
- [ ] Li `DASHBOARD-ARQUIVOS-CRITICOS.md` (este arquivo)
- [ ] Vi `tarefas-objetivo.md` (entendi sprint atual)
- [ ] Vi `tarefas.md` (entendi tarefas específicas)
- [ ] Perguntei ao Wagner sobre bloqueadores em `tarefas-retomada.md`
- [ ] Pronto para começar

---

## 🚨 Sinais de Alerta

Se vir isso, **avise imediatamente ao Wagner:**

| Sinal | O que fazer |
|-------|------------|
| PR > 3 dias sem revisão | Avisar Wagner |
| `tarefas-log.md` sem entrada há 2 dias | Avisar que última sessão não foi registrada |
| `tarefas.md` tem bloqueador por > 1 dia | Avisar — pode travar sprint |
| Mudança importante não em ADR | Criar ADR |
| Nova tecnologia não em mapa-executivo | Questionar no mapa antes de usar |
| main e dev dessincronizados | Erro grave — sincronizar imediatamente |
| Branch local que não existe no remote | Erro — rodar git prune e sync |

---

**Versão:** 1.0  
**Mantido por:** Wagner  
**Próxima atualização:** Após primeiro ciclo operacional completo
