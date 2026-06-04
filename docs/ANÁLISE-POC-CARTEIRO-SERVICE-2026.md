# Análise: POC-carteiro-service-2026

**Repositório:** `POC-carteiro-service-2026`
**Versão atual:** v3.0.0
**Data:** 2026-06-04

## Descrição
Form-to-email gateway. Aceita submissões de formulários HTML de qualquer domínio, valida reCAPTCHA (v2 e v3), envia emails via Resend ou SendGrid, e persiste tudo em flat-file JSON.

## Estrutura do Repositório
O repositório contém 4 versões evolutivas:
```
v1/          ← Versão inicial (UnoCSS)
v2/          ← Refinamentos
v3/          ← Versão mais recente (REFERÊNCIA)
008-com-firebird/ ← Experimento com Firebird DB + qqfdb client
conversation/    ← Histórico de desenvolvimento (transcripts, ZIPs)
problemas-encontrados/ ← Issues documentadas
```

## Stack (v3 — versão de referência)

| Concern | Choice |
|---------|--------|
| Runtime | Bun |
| Framework | Astro SSR (`output: 'server'`, `@astrojs/node` standalone) |
| CSS | DaisyUI 5 (self-hosted) |
| Reactivity | DataStar (self-hosted) |
| Persistence | Flat-file JSON (`node:fs/promises`) |
| Email | Resend v4 + SendGrid v7 |
| Process manager | PM2 (`interpreter: bun`) |
| Reverse proxy | Caddy |

**Sem:** Docker, Tailwind, pacotes privados, CDN externo para assets.

## Estrutura de Código (v3)
```
src/
├── middleware.ts              ← Todas as rotas POST (sem /api/ files)
├── lib/
│   ├── db.ts                  ← JSON store standalone (sem deps externas)
│   ├── config.ts              ← Carrega carteiros + recaptchas das databases
│   ├── sendFormEmail.ts       ← Dispatch Resend + SendGrid
│   ├── verifyCaptcha.ts       ← Google reCAPTCHA siteverify via fetch()
│   ├── checkReCaptcha.ts
│   ├── identificaCarteiro.ts
│   ├── identificaRecaptcha.ts
│   ├── saveRequestData.ts
│   ├── queryParser.ts         ← GitHub-style qualifier parser
│   └── getHostName.ts
├── layouts/AdminLayout.astro
└── pages/
    ├── index.astro
    └── admin/
        ├── carteiros.astro    ← CRUD — email providers
        ├── recaptchas.astro   ← CRUD — reCAPTCHA configs
        ├── mensagens.astro    ← Read-only, GitHub-style query
        └── webhooks.astro     ← Read-only, SendGrid webhooks
public/
├── js/datastar.js             ← Self-hosted DataStar
├── js/grecaptcha-v2.js        ← Client script embeddável
├── js/grecaptcha-v3.js        ← Client script embeddável
└── css/daisyui.css            ← Self-hosted DaisyUI
```

## Artefatos de Código Relevantes

### 1. `db.ts` — JSON Store Standalone (CRÍTICO)
Store JSON flat-file sem dependências externas. Compatível com formato qqdb diskStore.

**API:**
```typescript
insertOne(database, table, record)  → { id: number }
getAll(database, table)             → Record[]
getById(database, table, id)        → Record | null
updateOne(database, table, id, patch) → boolean
deleteOne(database, table, id)      → boolean
overwriteTable(database, table, records)
listDatabases()                     → string[]
listTables(database)                → string[]
```

**On-disk format:**
```
{DATABASES_FOLDER}/{database}/{table}.json
```
Cada arquivo = JSON array com auto-increment `id`. Wire-compatible com qqdb diskStore.

### 2. `sendFormEmail.ts` — Email Dispatcher Multi-provider
```typescript
sendFormEmail(apiProvider, apiKey, fromEmail, destinatario, formData, files?)
// providers: 'resend' | 'sendgrid'
// files: { filename, buffer, mimeType }[]
// returns: { messageId, message? }
```
Provider-agnostic — switch entre Resend e SendGrid sem mudar código consumidor.

### 3. `queryParser.ts` — GitHub-style Query Parser
Parser de filtros estilo GitHub para queries em flat-file JSON.

**Sintaxe suportada:**
```
qualifier:value              → substring match em campo
qualifier:"v a l"            → value com espaços
field.nested:value           → dot-notation em campos JSON
after:YYYY-MM-DD             → registros a partir de data
before:YYYY-MM-DD            → registros até data
bare word                    → full-text em todos os campos
```

### 4. `middleware.ts` — Padrão de Routing via Middleware
Todas as rotas POST tratadas em `middleware.ts` — sem arquivos `/api/` do Astro.

**Rotas:**
```
POST /api/sendmail    → JSON body, reCAPTCHA, retorna { ok, message }
POST /api/multipart   → multipart/form-data, attachments, redirect
POST /webhook         → SendGrid event payload, sempre 200
```

### 5. `qqfdb` (em 008-com-firebird) — Client Firebird
Client para Firebird DB com suporte a multi-tenant.

**API:**
```typescript
setDefaultConnectOptions(opts)
createQqdbClient()                    → client padrão (SYSTEM user)
createCustomQqdbClient(custom)        → client com opções customizadas
createTenantQqdbClient(tenantId)      → client multi-tenant
```
**Nota:** Firebird é experimento — não está no stack canônico.

## HTTP Routes Completas (v3)

### Públicas
| Method | Path | Descrição |
|--------|------|-----------|
| POST | `/api/sendmail` | JSON, reCAPTCHA v2/v3 |
| POST | `/api/multipart` | Form data + attachments, redirect |
| POST | `/webhook` | SendGrid webhooks |
| GET | `/js/grecaptcha-v2.js` | Client embeddável |
| GET | `/js/grecaptcha-v3.js` | Client embeddável |

### Admin (acesso via Caddy + SSH tunnel)
| Path | Descrição |
|------|-----------|
| `/admin/carteiros` | CRUD — email providers |
| `/admin/recaptchas` | CRUD — reCAPTCHA configs |
| `/admin/mensagens` | Read-only + query |
| `/admin/webhooks` | Read-only + query |

## Persistência

```
/var/databases/carteiro/
  config/
    carteiros.json      ← Email provider configs
    recaptchas.json     ← reCAPTCHA configs
  faleConosco/
    mensagens.json      ← Todas as tentativas de envio
  webhooks/
    events.json         ← Payloads do SendGrid
```

## Deploy
```bash
bun run build
pm2 start pm2.yaml      # interpreter: bun, entry: dist/server/entry.mjs
# Caddy como reverse proxy (porta 21004)
```

## Candidatos para Template

| Artefato | Importância | Ação |
|----------|-------------|------|
| `db.ts` — JSON Store standalone | 🔴 Crítico | Extrair como utilitário reutilizável |
| `sendFormEmail.ts` — Multi-provider email | 🟡 Importante | Referência para serviços de email |
| `queryParser.ts` — GitHub-style query | 🟡 Importante | Reutilizável em admin UIs |
| Padrão: routing via middleware.ts | 🔴 Crítico | Adotar no template (sem /api/ files) |
| Self-hosted assets (DataStar, DaisyUI) | 🟡 Importante | Alinha com "sem CDN externo" |
| pm2.yaml com `interpreter: bun` | 🟡 Importante | Padrão de deploy com Bun |
| Padrão de databases folder | 🟡 Importante | Convenção de persistência flat-file |

## Notas

- `db.ts` é um CRUD JSON standalone sem deps — candidato forte para package reutilizável
- Padrão de "routing via middleware" (sem `/api/` files Astro) é elegante e consolidado
- Self-hosting de assets (DataStar, DaisyUI) alinha com o princípio de sem CDN externo
- qqfdb/Firebird é experimento — não incorporar no template
- v3 é a versão de referência; v1/v2 são evolutivas
