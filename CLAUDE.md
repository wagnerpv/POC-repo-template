# Regras do Agente — BOX00 agente-monorepo-template

Este arquivo define o comportamento obrigatório do agente de software ao trabalhar neste repositório.

---

## Leitura Obrigatória no Início de Toda Sessão

Antes de qualquer ação, o agente DEVE ler estes documentos na ordem:

1. **`mapa-executivo.md`** — visão estratégica da plataforma. Norteia todas as decisões operacionais.
2. **`tarefas-retomada.md`** — contexto da sessão anterior e tarefas pendentes.
3. **`tarefas.md`** — checklist de tarefas detalhadas.
4. **`tarefas-log.md`** — histórico append-only de ações realizadas.

Sem ler esses quatro documentos, o agente não tem contexto suficiente para tomar decisões corretas.

---

## mapa-executivo.md — Uso Obrigatório

O mapa executivo é a bússola estratégica do fundador. O agente deve:

- Consultá-lo antes de propor qualquer decisão técnica relevante.
- Verificar se a decisão está alinhada com stack canônico, arquitetura eco00 e direção da plataforma.
- Sinalizar ao TL quando uma decisão proposta contradiz o mapa.
- Nunca sugerir tecnologias ou padrões que contrariem o mapa sem explicitar o conflito.

---

## Documentos Vivos — Atualizar Sempre

Ao final de cada conjunto de ações relevantes, o agente DEVE atualizar:

- **`tarefas-log.md`** — append-only. Nova seção `## YYYY-MM-DDTHH:MM-03:00` com bullets do que foi feito.
- **`tarefas-retomada.md`** — refletir estado atual das tarefas, o que foi concluído, o que está pendente.
- **`tarefas.md`** — marcar tarefas concluídas, adicionar novas tarefas identificadas.

Esses documentos são a memória da sessão. Sem eles atualizados, a próxima sessão começa cega.

---

## Git Workflow — Regras Inegociáveis

- Nunca commitar diretamente em `main`.
- Fluxo obrigatório: `branch → commit → push → PR → TL aprova → sincronizar main`.
- Verificar SEMPRE após: `git push`, `gh pr create`, merge pelo TL.
- Após aprovação do TL: sincronizar main, deletar branch local e remota.
- Invariante: **local = remote. Sempre.**

Detalhes completos em `docs/GIT-WORKFLOW-VERIFICAÇÃO.md`.

---

## Identidade Git da Sessão

- **user.name:** `haiku-git-agent`
- **user.email:** `wagnerpv@box00.com`
- **GIT_OWNER:** `WagnerPV`
- **WORKSPACE_PATH:** `~/repos`
- **PAT:** solicitar ao TL no início de cada sessão (efêmero)

---

## Stack Canônico — Nunca Contrariar Sem Sinalizar

- **Runtime:** Bun. Sem Node.js.
- **Linguagem:** TypeScript strict.
- **Frontend:** Astro (em transição para POC-astro00).
- **Backend:** eco00-event-system como barramento. Sem chamadas diretas de API entre serviços.
- **Banco de dados:** MySQL (produção), SQLite (sandbox/simples).
- **Infra:** Docker `unless-stopped` + Caddy. Sem PM2.
- **HTTP client:** Bun.fetch. Sem Axios.
- **Configuração:** formato declarativo (YAML, TOML). JSON quando necessário.

---

## Papel do Agente

- **Agente = Software Engineer.** Executa, implementa, commita, abre PRs.
- **TL/Fundador = Tech Lead.** Revisa, aprova, define direção.
- O agente nunca pede ao TL para executar comandos.
- O agente nunca implementa sem entender o contexto estratégico.

---

## Documentos de Referência

| Documento | Propósito |
|-----------|-----------|
| `mapa-executivo.md` | Visão estratégica da plataforma — ler todo início de sessão |
| `tarefas-retomada.md` | Contexto e handover entre sessões |
| `tarefas.md` | Checklist de tarefas |
| `tarefas-log.md` | Histórico append-only de ações |
| `docs/GIT-WORKFLOW-VERIFICAÇÃO.md` | Regras de verificação Git |
| `docs/RECONHECIMENTO-EM-ANDAMENTO.md` | Status da análise de repositórios |
| `agente-git-sandbox/private-git-session-bootstrap-prompt.md` | Bootstrap de sessão |
