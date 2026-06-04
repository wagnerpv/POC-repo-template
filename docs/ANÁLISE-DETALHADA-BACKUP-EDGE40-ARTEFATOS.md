# Análise Detalhada de backup-edge40 - Artefatos de Código

**Repositório:** `backup-edge40`
**Data:** 2026-06-04
**Propósito do repo:** Backup e organização de arquivos do smartphone Edge 40.

---

## Nota Sobre a Natureza do Repositório

`backup-edge40` é um repositório de backup pessoal, não um produto. Contém:
- Artefatos entregues em sessões de trabalho com agentes AI
- ZIPs, PDFs, DOCXs de specs e deliverables
- Código TypeScript de pacotes em desenvolvimento

A análise foca exclusivamente nos **code artifacts** — ignorando ZIPs, PDFs, MP4, MP3, XLSX, DOCX e `/big.local/`.

---

## Estrutura do Repositório

```
backup-edge40/
├── agents/                    ← Artefatos vindos do smartphone (principal)
│   ├── FILESYSTEM-CONVENTIONS.md  ← Convenção canônica de filesystem
│   ├── PSP/                   ← Payment Service Provider
│   ├── br-citas/              ← Projeto BR Citas (código, discovery, specs)
│   ├── dd-norm/               ← Data Dictionary + Validation Runtime
│   ├── dev/                   ← Ferramentas de desenvolvimento
│   ├── docs-site/             ← Site renderer CMS
│   ├── edge40-2026-04-20/     ← Sessão 20/04: basta00, astro-renderer, eco00
│   ├── edge40-2026-04-23/     ← Sessão 23/04: browser-engine, router-engine, web-api
│   ├── edge40-2026-05-05/     ← Sessão 05/05: taskboard, browser-automation, ssr-runtime
│   ├── edge40-2026-05-23/     ← Sessão 23/05: Valeska, app-spec, astro-renderer
│   ├── edge40-2026-05-24/     ← Sessão 24/05: Valeska HTML
│   ├── edge40-2026-05-27/     ← Sessão 27/05: tokke-monorepo
│   ├── mcp-foundations/       ← Specs e PRD do MCP Foundations
│   └── misc--app00-deploy-guidelines/ ← Guidelines de deploy
├── scripts/                   ← Utilitários bash para gestão de arquivos grandes
│   ├── list_big_files.sh
│   ├── move_big_files.sh
│   └── unstage_big_files.sh
├── wip/                       ← Work in progress (vazio atualmente)
└── zona/                      ← Área de rascunhos (não analisar)
```

---

## 1. `agents/FILESYSTEM-CONVENTIONS.md` — Convenção Canônica de Filesystem (CRÍTICO)

**Localização:** `agents/FILESYSTEM-CONVENTIONS.md`
**Status:** ✅ Documento completo e maduro

### Convenção
Todo ambiente de servidor resolve para:
```
~/box00/<env>
```
Exemplos: `~/box00/tokke-prod`, `~/box00/tokke-stage`, `~/box00/tokke-dev`

### Subdiretórios Canônicos
```
~/box00/<env>/config     ← Config persistente
~/box00/<env>/secrets    ← Material secreto (signing keys, etc.)
~/box00/<env>/data       ← Dados persistentes (SQLite, JSON, uploads)
~/box00/<env>/state      ← Estado operacional (checkpoints, cursors)
~/box00/<env>/cache      ← Artefatos regeneráveis (templates, indexes)
~/box00/<env>/logs       ← Logs append-only ou rotados
~/box00/<env>/tmp        ← Temporários descartáveis
~/box00/<env>/run        ← Coordenação runtime (PIDs, locks, sockets)
```

### Regras de Alocação
1. Todos os dados persistentes do platform DEVEM estar em `~/box00/<env>`
2. Packages usam o diretório canônico de semântica mais adequada
3. Packages podem criar nested dirs dentro dos roots canônicos
4. Packages NÃO podem criar novos top-level roots sem decisão de platform
5. Em caso de ambiguidade: secret > config > data > state > cache > run > tmp

### Candidatura para Template
**Status:** ✅ CRÍTICO — adotar como convenção de filesystem do template

---

## 2. `agents/dd-norm` — Data Dictionary + Validation Runtime (CRÍTICO)

**Localização:** `agents/dd-norm/`
**Versões:** `box00-dd-norm-v2_2` e `dd-validation-runtime-v1`

### Descrição
Sistema de Data Dictionary (DD) + runtime de validação baseado no DD.

### Pacotes

#### `@box00/data-dictionary-v1`
- Valida JSON do DD via `DataDictionarySchemaV1.parse(...)`
- Expõe tipos: `DataDictionaryV1`, `Table`, `Field`
- O DD espelha o dicionário de negócio — não modificar só para "fazer o código funcionar"

#### `@box00/dd-validation-runtime`
API pública:
```typescript
createValidatorRegistry()                     → ValidatorRegistry
registerFieldValidator(registry, { name, implementation })
registerRecordValidator(registry, { name, implementation })
validateRecord(dd, { tableName, record, mode }, registry) → ValidationResult
validateField(dd, { tableName, fieldName, value, record, mode }, registry) → ValidationResult
```

Resultado:
```typescript
interface ValidationResult {
  ok: boolean
  errors: ValidationIssue[]           // falhas de negócio
  resolutionErrors: ResolutionIssue[] // problemas de wiring DD/registry
  hasValidationErrors: boolean
  hasResolutionErrors: boolean
}
```

### Arquitetura de Resolução
**Para um field:**
1. Encontrar tabela no DD
2. Encontrar field na tabela
3. Se `fieldType` presente → ler `fieldTypesCatalog.items[fieldType].defaultFieldValidations`
4. Combinar com `field.fieldValidations`
5. Para cada validator: resolver definição no catalog + implementação no registry

**Para um record:**
1. Usar `table.recordValidations` + `recordValidationsCatalog`
2. Resolver implementações no registry
3. Executar validators de record + todos os field validators da tabela

### Padrão de Uso
```typescript
// dd-bootstrap.ts — parse once at startup
const dataDictionary = DataDictionarySchemaV1.parse(ddJson)

// validation/registry.ts — register all validators
const registry = createValidatorRegistry()
registerFieldValidator(registry, { name: 'required', implementation: ... })

// services/entity-service.ts — validate before persist
const result = validateRecord(dataDictionary, { tableName, record, mode: 'insert' }, registry)
if (!result.ok) throw new Error(...)
```

### Candidatura para Template
**Status:** ✅ CRÍTICO — arquitetura de validação baseada em Data Dictionary é fundamental para sistemas business

---

## 3. `agents/docs-site` — Site Renderer CMS (IMPORTANTE)

**Localização:** `agents/docs-site/docs-sites-cms/site-renderer-v2/`

### Descrição
Renderer de sites estruturados a partir de modelos de dados tipados. Resolve pages, sections, blocks e renderiza HTML.

### API Pública
```typescript
// Resolve
resolveLayout(unresolved)   → ResolvedLayout
resolveSection(unresolved)  → ResolvedSection
resolvePage(unresolved)     → ResolvedPage
resolveSite(unresolved)     → ResolvedSite

// Render
renderBlock(block)          → HTML string
renderSection(section)      → HTML string
renderPage(page)            → RenderedPage { path, html }
renderSite(site)            → RenderedSite { site, pages }

// Block renderers específicos
renderHero, renderFeatureGrid, renderCtaBanner, renderRichText,
renderCallout, renderActionGroup, renderSectionHeading, renderStepList
```

### Tipos de Bloco
```typescript
type Block =
  | HeroBlock | FeatureGridBlock | CtaBannerBlock | RichTextBlock
  | CalloutBlock | ActionGroupBlock | SectionHeadingBlock | StepListBlock
```

### Tipos de Página e Site
- `PageType`: `'landing' | 'content' | 'docs'`
- `SectionKind`: `'hero' | 'content' | 'features' | 'docs-content' | 'cta'`
- `SiteTheme`: tokens, fonts, brand, modes
- `SiteNavigation`, `SiteFooter`, `SiteSeo`, `SiteBuildOptions`

### Candidatura para Template
**Status:** 🟡 IMPORTANTE — útil para projetos que geram sites/docs programaticamente

---

## 4. `agents/mcp-foundations` — MCP Foundations Specs (CRÍTICO)

**Localização:** `agents/mcp-foundations/`
**Documentos:** specs completas, PRD, convenção canônica de filesystem MCP

### Descrição
Spec completa do `@box00/mcp-foundations` — runtime genérico para criação de MCP servers.

### Filosofia
- **Filesystem é a única fonte da verdade**
- Convention-based routing (sem config)
- Descoberta dinâmica por request (sem cache, sem build)
- Falhas explícitas quando convenção inválida

### Estrutura Canônica de um MCP App
```
package.json
src/index.ts
mcp00.app.md           ← Overview humano do app
attachments/           ← Arquivos referenciados por resources
tools/                 ← Tools (model-controlled actions)
resources/             ← Resources (readable content)
resource-templates/    ← Resource templates (parameterizados)
prompts/               ← Prompts (user-controlled templates)
```

### Convenção de Tool
```
tools/generate-palette/
  generate-palette.meta.yaml         ← title, description
  generate-palette.input.schema.json ← JSON Schema do input
  generate-palette.output.schema.json← JSON Schema do output
  generate-palette.annotations.yaml  ← readOnlyHint, destructiveHint, etc.
  generate-palette.ts                ← implementação
```

### Convenção de Resource
```
resources/brand-guidelines/
  brand-guidelines.meta.yaml     ← uri, title, description, mimeType
  brand-guidelines.annotations.yaml ← audience, priority
# Conteúdo em:
attachments/brand-guidelines.md
```

### Convenção de Resource Template
```
resource-templates/palette-by-id/
  palette-by-id.meta.yaml        ← uriTemplate, title, description, mimeType
  palette-by-id.annotations.yaml
  palette-by-id.ts               ← implementação
```

### Convenção de Prompt
```
prompts/suggest-palette/
  suggest-palette.meta.yaml      ← title, description
  suggest-palette.arguments.yaml ← arguments com name, required, description
  suggest-palette.ts             ← implementação
```

### Runtime
```typescript
// src/index.ts de um MCP App
import { startMcpServer } from '@box00/mcp-foundations'
await startMcpServer({ port, rootDir: process.cwd() })
```

### Candidatura para Template
**Status:** ✅ CRÍTICO — base para qualquer MCP server BOX00

---

## 5. `agents/docs-site/docs-sites-cms/design-tokens-package-node-v1` — Design Tokens Package

**Localização:** `agents/docs-site/docs-sites-cms/design-tokens-package-node-v1/`

### Descrição
Package de design tokens para Node/Bun. Distribuído como `dist/index.d.ts`.

### Candidatura para Template
**Status:** 🟡 IMPORTANTE — base para sistema de design tokens

---

## 6. `scripts/` — Utilitários de Gestão de Arquivos Grandes

**Localização:** `scripts/`

```bash
# list_big_files.sh — lista arquivos > 45MB (excluindo .git e big.local)
bun run big:list

# move_big_files.sh — remove do stage e move para big.local/
bun run big:move

# unstage_big_files.sh — remove do stage (sem mover)
bun run big:unstage
```

**Package.json pattern:**
```json
"scripts": {
  "big:list":    "bash scripts/list_big_files.sh",
  "big:unstage": "bash scripts/unstage_big_files.sh",
  "big:move":    "bash scripts/move_big_files.sh",
  "big:clean":   "npm run big:unstage && npm run big:move"
}
```

### Candidatura para Template
**Status:** 🟢 BAIXO — útil apenas para repos de backup com arquivos grandes

---

## 7. `agents/edge40-*` — Sessões de Entrega (Artefatos em ZIPs)

Os diretórios `edge40-YYYY-MM-DD/` contêm entregáveis de sessões de trabalho. A maior parte está em ZIPs/PDFs (fora do escopo de análise). Os principais code artifacts identificados:

| Sessão | Artefato | Formato | Relevância |
|--------|----------|---------|-----------|
| edge40-2026-04-20 | astro-renderer (meta + perplexity) | `.ts` | 🔴 Alta |
| edge40-2026-04-23 | router-engine-1_9_1 | código | 🔴 Alta |
| edge40-2026-04-23 | browser-engine-mcp | código | 🟡 Média |
| edge40-2026-05-05 | ssr-runtime-101.md | `.md` | 🔴 Alta |
| edge40-2026-05-05 | taskboard-demo-prd.md | `.md` | 🟡 Média |
| edge40-2026-05-05 | browser-automation-poc | código | 🟡 Média |
| edge40-2026-05-23 | Valeska citas (backoffice) | ZIPs | (não analisar) |
| edge40-2026-05-23 | app-spec v1.0 | ZIPs | (não analisar) |
| edge40-2026-05-23 | astro-renderer v1.0.0 | ZIP | (não analisar) |

**Nota:** Os ZIPs dos artefatos entregues estão aqui como backup — o código real já existe em repositórios próprios (e.g., POC-astro00 contém o astro-renderer).

---

## Matriz de Candidatos Final

| # | Artefato | Tipo | Localização | Importância | Ação |
|---|----------|------|-------------|-------------|------|
| 1 | Filesystem Conventions `~/box00/<env>` | Standard | `agents/FILESYSTEM-CONVENTIONS.md` | 🔴 Crítico | Adotar como convenção de filesystem |
| 2 | `@box00/dd-validation-runtime` — validateRecord/validateField | Package | `agents/dd-norm/dd-validation-runtime-v1/` | 🔴 Crítico | Avaliar extração como package |
| 3 | `@box00/data-dictionary-v1` — DataDictionarySchemaV1 | Package | `agents/dd-norm/` | 🔴 Crítico | Avaliar extração como package |
| 4 | MCP Foundations — convenção canônica de filesystem MCP | Spec + Pattern | `agents/mcp-foundations/` | 🔴 Crítico | Base para qualquer MCP BOX00 |
| 5 | MCP00 Tool/Resource/Prompt conventions | Pattern | `agents/mcp-foundations/` | 🔴 Crítico | Template para novos MCPs |
| 6 | Site Renderer CMS — renderPage/renderSite | Package | `agents/docs-site/site-renderer-v2/` | 🟡 Importante | Útil para projetos docs/sites |
| 7 | Design Tokens Package | Package | `agents/docs-site/design-tokens-*` | 🟡 Importante | Base para design system |
| 8 | Scripts de gestão de arquivos grandes | Utils | `scripts/` | 🟢 Baixo | Apenas para repos com arquivos grandes |

---

## O que NÃO Existe de Relevante

- ❌ Código TypeScript diretamente acessível em `/zona/` (rascunhos, não analisar)
- ❌ `/wip/` está vazio
- ❌ ZIPs e PDFs estão fora do escopo
- ❌ Nenhum ORM/database pattern neste repo especificamente
- ❌ Nenhum componente UI nativo (os de app00ui-astro estão em repo próprio)

---

## Próximas Ações

1. ✅ Análise de backup-edge40 CONCLUÍDA
2. ⏳ Extrair `FILESYSTEM-CONVENTIONS.md` para o template
3. ⏳ Avaliar se `@box00/dd-validation-runtime` merece repositório POC próprio
4. ⏳ Documentar convenção MCP00 no template
5. ⏳ Consolidar reconhecimento completo de todos os repositórios
