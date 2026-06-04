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
- **Astro** — em transição. POC-astro00 visa eliminar a dependência do Astro framework.
- **CSS Custom Properties** — sem Tailwind JIT, sem lock-in de bundler.
- **DataStar** — reatividade leve no cliente.

### Backend
- **Bun.fetch** — HTTP client nativo.
- **eco00-event-system** — backbone de comunicação entre serviços. Aplicações publicam eventos, serviços subscrevem. Sem chamadas diretas de API entre serviços.
- Routing via middleware. Sem framework de API como padrão.

### Banco de Dados
- **MySQL** — canônico para produção quando o produto exige.
- **SQLite** — para produtos mais simples ou ambientes que não suportam MySQL.
- Package canônico de acesso a banco de dados a definir — múltiplos candidatos a avaliar (box00-monorepo, tokke, outros). Carteiro não é o candidato principal.

### Infra e Deployment
- **Docker** — padrão universal. Desenvolvimento local e produção.
- **Caddy** — reverse proxy. Um por VPS.
- **NATS + JetStream** — mensageria para eco00-event-system. Containers a nível de VPS.
- **Restart policy:** `unless-stopped`. Sem PM2.
- **Formato declarativo** — configuração em YAML, TOML ou equivalente sempre que viável.

---

## Arquitetura de Infra

### Containers por VPS (propriedade da VPS)
- Caddy — reverse proxy e TLS
- NATS + JetStream — barramento de eventos do eco00

### Containers por Aplicação (propriedade da aplicação)
- Container da aplicação em si
- Container de banco de dados quando necessário (MySQL ou SQLite via volume)
- Serviços específicos da aplicação

Banco de dados nunca é compartilhado entre aplicações. Cada aplicação é dona do seu container de banco.

---

## eco00-event-system — Arquitetura de Serviços

Serviços internos da plataforma comunicam via eventos, não via chamadas de API diretas.

**Exemplo — autenticação:**
1. Aplicação publica evento `login.solicitado` com credenciais
2. Serviço de auth subscreve, valida, publica `login.aceito` ou `login.rejeitado`
3. Aplicação ouve o resultado

**Serviços internos a implementar via eco00:**
- **auth** — autenticação e sessão
- **sendmail** — email transacional (inclui carteiro como subscriber)
- **notifications** — notificações push, in-app, email
- **RBAC** — controle de acesso baseado em roles

---

## Packages da Plataforma

### Em uso ou prontos para extração
- **`@box00/ssr-foundations`** — SSR server Bun + Preact. Filesystem routing, middleware, RBAC, session.
- **`@box00/data-dictionary-v1`** — schema canônico de Data Dictionary com Zod.
- **`@box00/dd-validation-runtime`** — runtime de validação baseado no Data Dictionary.
- **`app00ui-astro`** — biblioteca de componentes UI para Astro. 21 componentes, design tokens.

### Candidatos identificados — a avaliar e consolidar
A análise dos repositórios de referência revelou múltiplos candidatos para cada categoria. Para cada uma, a tarefa é: identificar todos os candidatos, avaliar maturidade, consolidar no melhor ponto de partida, e definir como package canônico.

- **Database access** — candidatos em box00-monorepo, tokke e outros. A definir.
- **MCP Foundations** — runtime para MCP servers. Spec madura, implementação a extrair.
- **Browser Extension Foundations** — base para extensões Chrome.
- **Telegram Mini App Foundations** — base para mini apps no Telegram.
- **CLI00** — framework plug-and-play para CLIs. Conceito definido, implementação a extrair.
- **Auth service** — múltiplos mecanismos existentes. Avaliar e consolidar o melhor.

### Em desenvolvimento / POC
- **POC-astro00** — elimina dependência do Astro framework. WASM compiler + Bun nativo.
- **eco00-event-system** — barramento de eventos. Base para toda a arquitetura de serviços.

---

## Produtos

### Em produção
- **cliente-tokke-agendamentos** — sistema de agendamentos. Stack anterior à plataforma atual. Único produto de fato em produção além do carteiro.
- **carteiro (box00-carteiro-service)** — serviço de email para formulários de contato de sites. Em produção. Candidato a migração para eco00 como subscriber de `carteiro.*` events.

### Em desenvolvimento — prioridade 1
- **brcitas** — monorepo Bun + Astro + MySQL. Stack canônico. Prioridade máxima.

### Em desenvolvimento — prioridade 2
- **bitbox00** (com Bruno) — escopo definido, discovery preliminar do módulo inicial (subsistema de marketing).

### POCs e referências — não são produtos
- **POC-carteiro-service-2026** — tentativa de modernização do carteiro. Status incerto.
- Demais POCs — experimentos e provas de conceito, não produtos.

---

## O Problema de Duplicação

Múltiplas versões de SSR, routing, auth e outros mecanismos fundamentais existem espalhadas pelos repositórios. Resultado natural de evolução iterativa.

A tarefa em andamento é: para cada categoria de package fundamental, identificar todos os candidatos, avaliar maturidade e funcionalidade, e consolidar no package canônico do ecossistema.

**Decisão estratégica recorrente:** quando um cliente precisa de um produto agora, usar stack canônico mesmo que mais lento, ou usar stack legado e aceitar retrabalho futuro?

---

## O que não existe ainda

Sendo honesto sobre o estado real:

- Produto em produção com qualidade de plataforma: **nenhum ainda**
- Monitoramento de servidores e alertas de downtime: **não existe**
- Backup automatizado: **não existe**
- Pipeline de CI/CD: **não existe** — responsabilidade manual do desenvolvedor hoje
- Testes automatizados integrados a pipeline: **não existe**
- CLI da plataforma (`box00`): **não implementado**
- ORM/query builder canônico: **não definido**
- Sistema de migrations canônico: **não definido**
- Serviços internos (auth, sendmail, notifications): **não implementados**
- Documentação pública da plataforma: **não existe**

Há muito código de qualidade de produção. Produto em produção com plataforma madura: apenas tokke e carteiro, ambos em stack anterior.

---

## Perguntas para o Fundador

- **Isso constrói a plataforma ou consome a plataforma?**
- **Esse produto pode ser construído no stack canônico sem comprometer o prazo?**
- **Estou aceitando retrabalho futuro de forma consciente ou por pressão?**
- **Esse package tem candidatos nos repositórios de referência? Qual é o mais maduro?**
- **Esse serviço deveria ser interno da plataforma via eco00 ou é específico do produto?**

---

## Próximas Decisões Estratégicas Pendentes

- Consolidar package canônico de acesso a banco de dados (MySQL + SQLite)
- Quando eco00-event-system está maduro para ser o padrão de backend?
- Implementar monitoramento e backup antes de mais produtos?
- Estabelecer CI/CD mínimo antes de continuar entregas?
- Política formal para produtos em stack legado (tokke, carteiro)?
- Quando POC-astro00 está maduro o suficiente para substituir Astro?
- Quais packages canônicos extrair primeiro?
