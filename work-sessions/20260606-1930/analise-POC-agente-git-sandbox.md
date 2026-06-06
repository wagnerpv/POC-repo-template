# Análise — POC-agente-git-sandbox

**Data:** 2026-06-06
**Status:** Repositório de documentação operacional para agentes git

---

## O que é

Manual operacional para agente de software trabalhando em ambiente sandbox (originalmente Perplexity) com Git, GitHub CLI e workflows autenticados. Não tem código executável — é 100% documentação e scripts shell.

## Estrutura

```
POC-agente-git-sandbox/
├── README.md                          ← Manual principal (extenso)
├── CRITICAL-AGENT-ERRORS.md           ← Erros críticos documentados
├── agent-startup-prompt.md            ← Prompt de bootstrap
├── private-git-session-bootstrap-prompt.md
├── new-repository-from-template-flow.md
├── session-context-definition.md
├── tarefas.md
├── docs/
│   ├── index.md
│   ├── quick-reference.md
│   ├── operations-catalog.md
│   ├── agent-playbook.md
│   ├── documentation-review-checklist.md
│   ├── gh-audit.md
│   ├── json-output-conventions.md
│   ├── tutorial-git-remote-ops.md
│   └── use-cases-index.md
└── scripts/
    ├── gh-pr-pipeline.sh
    ├── gh-pr-status.sh
    ├── gh-audit.sh
    ├── check-doc-coverage.sh
    ├── smoke-test.sh
    └── lib/github-api.sh
```

## Conteúdo Relevante

### Padrões que já foram absorvidos pelo eco00
- Branch com timestamp: `feat/desc-HHMM` → **eco00 usa** `work-session-YYYYMMDD-HHNN` ✅
- Nunca ficar em main → **eco00 adota** como invariante ✅
- PAT efêmero → **eco00 adota** ✅
- git config user.name/email → **eco00 adota** ✅

### Conteúdo ainda não absorvido (candidatos)
- `scripts/lib/github-api.sh` — helpers shell reutilizáveis para GitHub API
- `scripts/gh-pr-pipeline.sh` — pipeline end-to-end de PR
- `scripts/gh-audit.sh` — auditoria de repo e workflows
- `docs/operations-catalog.md` — catálogo de operações avançadas
- `docs/json-output-conventions.md` — convenções de output JSON

### Standard PR Reporting Procedure
Documentado no README: sempre verificar número do PR via API antes de reportar. Relevante para o agente eco00.

## Avaliação

**Maturidade:** Alta (documentação detalhada, scripts funcionais)
**Relevância para eco00:** Alta — é o predecessor direto dos padrões operacionais atuais
**Destino sugerido:** Arquivar após extrair `scripts/lib/github-api.sh` e `scripts/gh-pr-pipeline.sh` para `POC-eco00-monorepo-template/scripts/`

## Artefatos a Extrair

| Artefato | Destino |
|----------|---------|
| `scripts/lib/github-api.sh` | `POC-eco00-monorepo-template/scripts/lib/` |
| `scripts/gh-pr-pipeline.sh` | `POC-eco00-monorepo-template/scripts/` |
| `docs/operations-catalog.md` | Referência para CONTRIBUTING.md |
| PR Reporting Procedure | Incorporar em GUIA-OPERACIONAL.md |
