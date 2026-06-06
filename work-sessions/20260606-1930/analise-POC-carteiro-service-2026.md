# Análise — POC-carteiro-service-2026

**Data:** 2026-06-06
**Status:** Serviço de carteiro (webhook delivery) — múltiplas versões

---

## O que é

Serviço de entrega de webhooks/notificações (o "carteiro"). Tem múltiplas versões de evolução: v1, v2, v3, e uma versão com Firebird (`008-com-firebird`). Cada versão representa uma iteração do serviço.

## Estrutura

```
POC-carteiro-service-2026/
├── v1/           ← Versão 1 (flat-file JSON store)
├── v2/           ← Versão 2
├── v3/           ← Versão 3
├── 008-com-firebird/  ← Versão com Firebird DB
│   ├── src/lib/
│   │   ├── db.ts              ← Persistence layer (Firebird, API=JSON store)
│   │   ├── firebird.ts        ← Firebird connection
│   │   ├── qqfdb/             ← Abstração Firebird (cliente, connection)
│   │   ├── config.ts
│   │   ├── checkReCaptcha.ts
│   │   └── identificaCarteiro.ts
│   ├── public/js/datastar.js  ← DataStar para SSE
│   └── pm2.yaml               ← Deploy config
├── conversation/  ← Histórico de sessões AI
└── problemas-encontrados/  ← Log de problemas
```

## Artefatos Críticos

### `db.ts` — Padrão de Persistence Layer
Interface pública idêntica ao flat-file JSON store mas implementando Firebird por baixo. Padrão de abstração de storage que permite trocar backend sem mudar consumers.

### `qqfdb/` — Abstração Firebird
- `client.ts` — Firebird client abstraction
- `connection.ts` — Connection management
- `index.ts` — Public exports

### DataStar Integration
Usa DataStar v1 para SSE (Server-Sent Events) no frontend.

## Stack

- Bun + Astro SSR
- Firebird (produção) / flat-file JSON (dev)
- DataStar (SSE frontend)
- Node-firebird
- ReCaptcha v2/v3

## Avaliação

**Maturidade:** Alta (serviço em produção)
**Relevância para eco00:** Média
**Padrão de valor:** O padrão de abstração de storage (`db.ts` com API pública estável, backend plugável) é excelente

## Artefatos a Extrair

| Artefato | Destino |
|----------|---------|
| `src/lib/db.ts` (padrão de abstração) | Referência para `@eco00/storage` |
| `src/lib/qqfdb/` | Referência para Firebird abstraction |
| Padrão de storage abstraction | Documentar em `docs/standards/` |

## Observações

- `problemas-encontrados/` tem registro de problemas reais encontrados — valioso como ADR negativo
- O padrão flat-file → Firebird (mesma API) é um exemplo concreto de storage abstraction
- `conversation/` mostra o fluxo de desenvolvimento com AI — referência de metodologia
