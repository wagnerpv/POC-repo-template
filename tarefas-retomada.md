# Retomada de Sessão — agente-monorepo-template

**Para o agente que vai retomar este trabalho:**
Você está começando uma sessão nova, sem memória da sessão anterior. Este documento contém tudo que você precisa saber para continuar de onde paramos.

---

## Contexto do Projeto

**Repositório de trabalho:** `WagnerPV/agente-monorepo-template`
**Objetivo:** Aprimorar o template de monorepo incorporando artefatos, padrões e configurações validados em repositórios de referência.

**Fase atual:** Reconhecimento (análise dos repositórios de referência). Não implementar nada ainda — apenas explorar, documentar e catalogar.

---

## Stack Canônico (não negociável)

- **Runtime:** Bun
- **Frontend:** Astro (em transição — POC-astro00 visa eliminar dependência)
- **Linguagem:** TypeScript strict
- **Banco de Dados:** MySQL (canônico) + SQLite (apenas sandbox/exceções)
- **HTTP Client:** Bun.fetch (nativo)
- ❌ **NÃO usar:** Hono, Node.js, Angular, Vue, Tailwind JIT, CDN externo

---

## Repositórios Clonados em `~/repos`

| Repositório | Tipo | Status de Análise |
|-------------|------|-------------------|
| `agente-monorepo-template` | Trabalho | — |
| `agente-git-sandbox` | Referência operacional | — |
| `POC-astro00` | Referência principal | ✅ Analisado |
| `POC-basta00` | IDP/Plataforma | ✅ Analisado |
| `POC-ssr-foundations` | POC (criado nesta sessão) | ✅ Criado |
| `POC-app00ui-astro` | UI components | ✅ Analisado |
| `POC-carteiro-service-2026` | Serviço email | ✅ Analisado |
| `backup-edge40` | Backup (3341 arquivos) | ✅ Analisado |
| `brcitas` | Projeto full-stack | ✅ Analisado |
| `box00-monorepo` | Plataforma legado | ✅ Analisado |
| `box00-carteiro-service` | Serviço email legado | ✅ Analisado |
| `cliente-tokke-agendamentos` | Cliente produção | ✅ Analisado |

---

## Tarefas Pendentes (por prioridade)

### 1. ⏳ Analisar `backup-edge40` (PRIORITÁRIA)
- Repositório com 3341 arquivos já clonado em `~/repos/backup-edge40`
- Estrutura: `/agents`, `/wip`, `/zona`, `/scripts`, `/big.local`
- Projetos identificados: DIVAGA, QQDB
- Focar em: `.ts`, `.tsx`, `.astro`, `.md` com specs/decisões
- Ignorar: PDFs, ZIPs, MP4/MP3, XLSX/DOCX, `/big.local`
- Ver tarefa em: `docs/TAREFA-ANÁLISE-BACKUP-EDGE40.md`
- Criar ao final: `docs/ANÁLISE-DETALHADA-BACKUP-EDGE40-ARTEFATOS.md`

### 2. ⏳ Consolidar reconhecimento completo
- Após analisar backup-edge40, consolidar todos os achados
- Atualizar `docs/RECONHECIMENTO-EM-ANDAMENTO.md`
- Criar plano de implementação por categoria de artefato

### 3. ⏳ Criar `POC-ssr-foundations` com README e documentação adequada
- Repositório já existe: `https://github.com/wagnerpv/POC-ssr-foundations`
- Código extraído de `POC-basta00/wip/ssr-foundations/`
- Falta: README próprio, atualizar referências de nome

---

## Documentos de Referência (em `docs/`)

| Arquivo | Conteúdo |
|---------|----------|
| `ANÁLISE-DETALHADA-BASTA00-ARTEFATOS.md` | Análise completa de POC-basta00 (20 artefatos) |
| `ANÁLISE-POC-APP00UI-ASTRO.md` | Análise de UI components (21 componentes Astro) |
| `ANÁLISE-POC-CARTEIRO-SERVICE-2026.md` | Análise do carteiro v3 (db.ts, email, queryParser) |
| `TAREFA-ANÁLISE-BACKUP-EDGE40.md` | Tarefa e escopo para análise de backup-edge40 |
| `RECONHECIMENTO-EM-ANDAMENTO.md` | Status geral do reconhecimento |
| `GIT-WORKFLOW-VERIFICAÇÃO.md` | Regras obrigatórias de verificação Git |

---

## Regras de Trabalho

### Git
- Nunca commitar direto na `main`
- Fluxo: `branch → commit → push → PR → TL aprova → sincronizar main`
- Após aprovação do TL: `git pull main`, `git fetch --prune`, deletar branches locais órfãs
- Verificar SEMPRE após: push, pr create, merge

### Agente
- Username Git: `haiku-git-agent`
- Email: `wagnerpv@box00.com`
- GIT_OWNER: `WagnerPV`
- WORKSPACE_PATH: `~/repos`
- PAT: solicitar ao TL no início da sessão

### Documentação
- `tarefas-log.md` — append-only, atualizar com `## YYYY-MM-DDTHH:MM-03:00` a cada conjunto de ações
- `tarefas-retomada.md` — este arquivo, atualizar ao final de cada sessão
- Idioma: português para nomes de arquivo e seções, inglês para código

---

## Como Iniciar a Sessão

1. Solicitar PAT ao TL
2. Seguir `agente-git-sandbox/private-git-session-bootstrap-prompt.md`
3. Clonar `agente-monorepo-template` como repositório de trabalho
4. Ler este arquivo (`tarefas-retomada.md`)
5. Ler `tarefas-log.md` para entender o histórico
6. Executar a próxima tarefa pendente (análise de `backup-edge40`)
7. Atualizar `tarefas-log.md` com o que foi feito
8. Atualizar este arquivo ao final da sessão

---

## Atualização Pós-Sessão 2026-06-04

### Análise de backup-edge40 concluída
- `docs/ANÁLISE-DETALHADA-BACKUP-EDGE40-ARTEFATOS.md` criado
- Artefatos críticos: Filesystem Conventions, dd-validation-runtime, Data Dictionary, MCP Foundations specs, MCP00 tool/resource/prompt conventions
- Artefatos importantes: Site Renderer CMS, Design Tokens Package

### Novo status das tarefas pendentes

1. **⏳ Consolidar reconhecimento completo** — todos os repositórios foram analisados. Próximo passo: consolidar achados e criar plano de implementação por categoria.
2. **⏳ Avaliar se `@box00/dd-validation-runtime` merece POC próprio** — código maduro e relevante.
3. **⏳ Criar `tarefas-implementação.md`** — plano de implementação por fase após consolidação.

---

## Atualização Final da Sessão 2026-06-04

### Concluído nesta sessão
- ✅ Fase de reconhecimento 100% completa (todos os repositórios analisados)
- ✅ `mapa-executivo.md` criado e revisado pelo fundador
- ✅ `CLAUDE.md` criado com regras obrigatórias do agente
- ✅ Padronização de idioma (português) em todos os documentos
- ✅ `tarefas-retomada.md` e `tarefas-log.md` como documentos vivos estabelecidos

### Como iniciar a próxima sessão
1. Solicitar PAT ao TL
2. Seguir `agente-git-sandbox/private-git-session-bootstrap-prompt.md`
3. Ler `CLAUDE.md` — regras obrigatórias do agente
4. Ler `mapa-executivo.md` — visão estratégica
5. Ler este arquivo (`tarefas-retomada.md`)
6. Ler `tarefas-log.md` — histórico
7. Executar próxima tarefa pendente

### Próximas tarefas pendentes (prioridade)
1. Consolidar package canônico de acesso a banco de dados — avaliar candidatos em box00-monorepo, tokke e outros
2. Mapear todos os packages fundamentais da plataforma e seus candidatos por categoria
3. Avaliar extração de `@box00/dd-validation-runtime` como repositório POC
4. Definir quais packages extrair primeiro (CLI00, MCP Foundations, Browser Extension Foundations)
5. Atualizar `mapa-executivo.md` conforme análise de packages avança
