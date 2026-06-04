# Mapa Executivo — BOX00 Plataforma

**Para o fundador.** Leia quando precisar tomar uma decisão estratégica ou quando sentir que perdeu a visão do todo.

**Última atualização:** 2026-06-04

---

## O que estamos construindo

Uma plataforma de software para construir e operar produtos digitais — internos e para clientes — com velocidade, consistência e custo baixo.

Não é um framework. É um conjunto de convenções, packages e ferramentas que tornam qualquer novo produto previsível de construir e operar.

---

## Por que existe

Produtos entregues sem plataforma madura viram legado rápido. O custo de retrabalho acumula. O objetivo é construir a plataforma uma vez e colher consistência em todos os produtos que vierem depois.

---

## Stack Canônico

### Runtime e Linguagem
- **Bun** — runtime e package manager. Sem Node.js.
- **TypeScript** — strict mode. Sem exceções.

### Frontend
- **Astro** — em transição. POC-astro00 está eliminando a dependência do Astro framework gradualmente.
- **CSS Custom Properties** — sem Tailwind JIT, sem lock-in de bundler.
- **DataStar** — reatividade leve no cliente.

### Backend e HTTP
- **Bun.fetch** — HTTP client nativo. Sem Axios, sem node-fetch.
- **Sem framework de API** — routing via middleware (padrão carteiro). Sem Hono como padrão.

### Banco de Dados
- **MySQL** — canônico para produção.
- **SQLite** — apenas em sandbox ou ambientes que não suportam MySQL.
- Sem ORM externo como padrão — abstrações próprias.

### Serviços e Infra
- **Docker + Caddy** — padrão de deployment.
- **PM2 com interpreter Bun** — process manager.
- **Flat-file JSON** — para dados simples e configuração de serviços (padrão carteiro).

---

## Convenções de Plataforma

### Filesystem de Ambiente
Todo ambiente de servidor resolve para `~/box00/<env>`.

- `config/` — configuração persistente
- `secrets/` — chaves, material criptográfico
- `data/` — dados de aplicação (SQLite, JSON)
- `state/` — estado operacional (checkpoints, cursors)
- `cache/` — artefatos regeneráveis
- `logs/` — logs append-only
- `tmp/` — temporários descartáveis
- `run/` — PID files, locks, sockets

### Estrutura de Monorepo
```
apps/        → aplicações deployáveis
packages/    → libraries compartilhadas
services/    → daemons e workers
mcps/        → MCP servers para agentes AI
integrations/→ adaptadores de serviços externos
standards/   → ADRs, convenções, runbooks
docs/        → documentação centralizada
```

### Naming de Ambientes
`<tenantId>-<envId>` — ex: `tokke-production`, `tokke-dev`

---

## Packages da Plataforma

### Prontos ou em Extração
- **`@box00/ssr-foundations`** — SSR server com Bun + Preact. Filesystem routing, middleware, RBAC, session management. Extraído de POC-basta00.
- **`@box00/data-dictionary-v1`** — schema canônico de Data Dictionary com Zod.
- **`@box00/dd-validation-runtime`** — runtime de validação baseado no Data Dictionary.
- **`app00ui-astro`** — biblioteca de componentes UI para Astro. 21 componentes, design tokens, CSS Custom Properties.

### Em Desenvolvimento / POC
- **POC-astro00** — elimina dependência do Astro framework. Usa `@astrojs/compiler` WASM + Bun nativo.
- **MCP Foundations** — runtime para MCP servers com filesystem como source of truth.
- **`db.ts` (carteiro)** — JSON store standalone sem dependências externas. Candidato a package.

---

## Produtos Existentes e Alinhamento

### Alinhados com a Plataforma
- **brcitas** — monorepo Bun + Astro + MySQL. Stack canônico. Em desenvolvimento.
- **POC-carteiro-service-2026** — Bun + Astro SSR + flat-file JSON. Padrão bem estabelecido.

### Legado ou Desalinhados
- **cliente-tokke-agendamentos** — stack anterior à plataforma atual. Decisão pendente: manter legado ou migrar.
- **box00-monorepo** — primeira tentativa de plataforma. Cresceu desordenadamente. Referência histórica, não padrão atual.
- **box00-carteiro-service** — versão anterior do carteiro. Substituído por POC-carteiro-service-2026.

---

## O Problema de Duplicação

Existem múltiplas versões de SSR, routing e foundations espalhadas pelos repositórios. Isso é resultado natural de evolução iterativa — não é um erro, é um estado de transição.

A plataforma está convergindo. O risco é entregar mais produtos antes da convergência, aumentando o custo de migração futura.

**Decisão estratégica recorrente:** quando um cliente precisa de um produto agora, usar stack canônico mesmo que mais lento, ou usar stack legado e aceitar retrabalho futuro?

---

## Estado Atual da Plataforma

### O que está consolidado
- Stack canônico definido (Bun, TypeScript, MySQL, CSS Custom Props)
- Convenções de filesystem (`~/box00/<env>`)
- Estrutura de monorepo
- `@box00/ssr-foundations` (código completo, pronto para extração)
- Biblioteca de UI (`app00ui-astro`)
- Padrão de deployment (Docker + Caddy + PM2)

### O que está em transição
- Eliminação da dependência do Astro framework (POC-astro00)
- Extração de packages canônicos (dd-validation-runtime, db.ts, mcp-foundations)
- Padronização de routing (middleware vs. /api/ files)

### O que ainda não existe formalmente
- CLI da plataforma (`box00` CLI — referenciado em runbooks, não implementado)
- ORM/query builder canônico
- Sistema de migrations canônico
- Documentação pública da plataforma

---

## Perguntas para o Fundador

Use estas perguntas como filtro para decisões estratégicas:

- **Isso constrói a plataforma ou consome a plataforma?**
- **Esse produto pode ser construído no stack canônico sem comprometer o prazo?**
- **Estou aceitando retrabalho futuro de forma consciente ou por pressão?**
- **Esse package existe em algum repositório de referência? Precisa ser extraído antes de ser usado?**

---

## Próximas Decisões Estratégicas Pendentes

- Extrair `@box00/dd-validation-runtime` como repositório POC próprio?
- Definir CLI `box00` como próxima entrega de plataforma?
- Estabelecer política formal para produtos em stack legado (tokke)?
- Quando POC-astro00 está maduro o suficiente para ser o padrão de SSR?
