# Análise — POC-eco00-monorepo-template

**Data:** 2026-06-06
**Status:** Template canônico para monorepos eco00 — este próprio repositório

---

## O que é

Este é o repositório que estamos construindo agora. É o template base para todos os repositórios eco00. Contém a estrutura canônica, documentação operacional, scripts e convenções.

## Estado Atual (2026-06-06)

```
POC-eco00-monorepo-template/
├── apps/, packages/, vendor/, sandbox/  ← Estrutura canônica (vazias)
├── work-sessions/                        ← Sessões de trabalho
├── docs/
│   ├── standards/FILESYSTEM-CONVENTIONS.md
│   └── deploy/MINI-SPEC-RELEASE-VENDOR-DEPLOY.md
├── scripts/
│   ├── repo-status.sh
│   └── checkup-sandbox-claude.sh
├── .github/workflows/
│   ├── create-dev-env.yml
│   └── destroy-dev-env.yml
├── CLAUDE.md         ← Regras do agente
├── CONTRIBUTING.md   ← Branch naming, session lifecycle, CHANGELOG format
├── CHANGELOG.md      ← Histórico de entregas
├── REPO-STATUS.md    ← Estado ao vivo
├── GUIA-OPERACIONAL.md ← POP completo do agente
└── README.md
```

## O que Está Sendo Construído

Esta sessão de análise é parte do processo de enriquecer o template com:
1. Documentação de artefatos identificados nos outros POCs
2. Definição de o que vai para `vendor/`
3. Canonização de padrões de trabalho

## Avaliação

**Maturidade:** Média (estrutura definida, em evolução ativa)
**Relevância:** É o foco de trabalho desta temporada
**Status:** Em construção ativa

## Próximos Passos para o Template

Com base nas análises desta sessão:

| Artefato | De | Para |
|----------|-----|------|
| astro-runtime | POC-astro00/packages/astro-runtime/ | vendor/eco00-astro-runtime/v1.x.x/ |
| ssr-foundations | POC-ssr-foundations/src/ | vendor/eco00-ssr-foundations/v1.0.0/ ✅ (placeholder existe) |
| html-parser | POC-ssr-templates-engine/packages/@eco00/html-parser/ | vendor/ |
| h-elements | POC-ssr-templates-engine/packages/@eco00/h-elements/ | vendor/ |
| theme-vars.css | POC-app00ui-astro/packages/app00ui-astro/src/styles/ | vendor/ |
| ADRs | POC-basta00/standards/adrs/ | docs/standards/adrs/ |
