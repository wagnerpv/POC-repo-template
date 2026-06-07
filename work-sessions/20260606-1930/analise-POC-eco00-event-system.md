# Análise — POC-eco00-event-system

**Data:** 2026-06-06
**Status:** Barramento de eventos da plataforma BOX00/eco00 — fase de design/documentação

---

## O que é

**Este é o barramento central da plataforma eco00.** Infraestrutura de mensageria que conecta browsers, sessões, aplicações e serviços. Atualmente em fase de design — tem documentação rica mas implementação ainda é uma POC simples.

## Princípios Técnicos

- **SSE** (Server-Sent Events) — canal servidor → browser, sem WebSocket
- **BroadcastChannel** — comunicação entre tabs do mesmo browser
- **Web Locks API** — eleição de tab líder por browser
- **NATS Core** — eventos voláteis
- **JetStream** — entrega durável
- **3 semânticas:** `volatile`, `durable-sync`, `durable-async`
- **Tenant:** `app+ENV` (ex: `toc.prod`)
- **tabId:** efêmero em `sessionStorage`

## Estrutura

```
POC-eco00-event-system/
├── comm-docs/              ← Documentação de produto e contratos
│   ├── visao-de-produto.md
│   ├── catalogo-de-eventos.md
│   ├── glossario-e-sistema-de-nomes.md
│   ├── contrato-definitivo-mvp-de-integracao.md
│   ├── casos-de-uso-e-orquestracao.md
│   ├── analise-tecnica-viabilidade-e-riscos.md
│   ├── estudo-jetstream-kv-como-storage-de-identidade.md
│   ├── wireframe-frontend-datastar.md
│   └── use-case-*.md (5 casos de uso)
├── docs/ARCHITECTURE-V1.md ← Arquitetura v1
├── handoff.md              ← Contexto da conversa de design
└── poc/                    ← POC de frontend (Astro + DataStar)
    └── src/pages/items/    ← Exemplo de listagem com loaders
```

## Artefatos Críticos

### `comm-docs/contrato-definitivo-mvp-de-integracao.md`
**O documento mais importante** — define o contrato de integração MVP entre sistema e consumers.

### `comm-docs/catalogo-de-eventos.md`
Catálogo de todos os eventos do sistema — base para implementação.

### `comm-docs/glossario-e-sistema-de-nomes.md`
Vocabulário canônico — tenant, tabId, volatile/durable, etc.

### `docs/ARCHITECTURE-V1.md`
Arquitetura v1 completa do barramento.

### POC frontend (`poc/src/pages/items/`)
Padrão de loader: `_loaders/list.loader.ts` + `list.ts` — separação de data loading das pages Astro.

## Avaliação

**Maturidade:** Design completo, implementação básica
**Relevância para eco00:** CRÍTICA — é o barramento central da plataforma
**Status:** Segunda prioridade ativa desta temporada

## Artefatos a Extrair

| Artefato | Destino |
|----------|---------|
| `comm-docs/` completo | `docs/event-system/` no template |
| `docs/ARCHITECTURE-V1.md` | Referência de arquitetura |
| Padrão de loader (poc) | Padrão de data loading para Astro pages |

## Observações

- `eco00-event-system` é a segunda prioridade ativa desta temporada (após astro00-poc)
- A implementação real ainda está por vir — documentação é o que existe
- DataStar + SSE é o padrão de frontend escolhido para este sistema
- NATS/JetStream é a infraestrutura de backend escolhida
