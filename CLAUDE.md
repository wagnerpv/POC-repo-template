# Regras do Agente — eco00-monorepo-template

Este arquivo define o comportamento obrigatório do agente ao trabalhar neste repositório.

---

## Leitura Obrigatória no Início de Toda Sessão

Antes de qualquer ação, ler na ordem:

1. **`CLAUDE.md`** — este arquivo
2. **`CONTRIBUTING.md`** — branch naming, session lifecycle, protocolo de PR
3. **`REPO-STATUS.md`** — estado atual (PRs abertos, issues, último commit)

---

## Git Workflow — Regras Inegociáveis

- **NUNCA** commitar diretamente em `main`
- Branch local de trabalho: `work-session-YYYYMMDD-HHNN` (fuso Brasil -03:00)
- Fluxo obrigatório: ver `CONTRIBUTING.md` → seção **Work Sessions**
- Identidade git:
  - `user.name`: `haiku-git-agent`
  - `user.email`: `wagnerpv@box00.com`
- PAT: solicitar ao TL no início de cada sessão (efêmero)

---

## Stack Canônico — Nunca Contrariar Sem Sinalizar

- **Runtime:** Bun. Sem Node.js.
- **Linguagem:** TypeScript strict.
- **Frontend:** Astro.
- **Backend:** eco00-event-system como barramento. Sem chamadas diretas entre serviços.
- **Banco de dados:** MySQL (produção), SQLite (sandbox/simples).
- **Infra:** Docker `unless-stopped` + Caddy. Sem PM2.
- **HTTP client:** Bun.fetch. Sem Axios.

---

## Papel do Agente

- **Agente = Software Engineer.** Executa, implementa, commita, abre PRs.
- **TL/Fundador = Tech Lead.** Revisa, aprova, define direção.
- O agente nunca pede ao TL para executar comandos.
- O agente nunca implementa sem entender o contexto.

---

## Documentos de Referência

| Documento | Propósito |
|-----------|-----------|
| `CONTRIBUTING.md` | Branch naming, session lifecycle, CHANGELOG format |
| `REPO-STATUS.md` | Estado ao vivo do repo (gerado por scripts/repo-status.sh) |
| `CHANGELOG.md` | Histórico de entregas mergeadas |
| `work-sessions/README.md` | Como usar a estrutura de sessões |
| `drafts/` | Rascunhos e WIP — docs ainda não estabilizados |
| `docs/standards/FILESYSTEM-CONVENTIONS.md` | Convenções de filesystem para ambientes |
| `docs/deploy/MINI-SPEC-RELEASE-VENDOR-DEPLOY.md` | Release, vendor, deploy |
