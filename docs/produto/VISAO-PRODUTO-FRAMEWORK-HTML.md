# Visão de Produto — Framework de Templates HTML

**Status:** Planejamento | **Data:** 2026-06-05 | **Mantido por:** Wagner Vieira

---

## Visão Geral

Framework SSR-first para construção de aplicações web, baseado em HTML com tags e atributos especializados. Cada tag ou componente é associado a um renderer específico pelo nome da tag. A reatividade client-side é delegada ao DataStar signals, sem intenção de paridade com frameworks como Vue.

---

## Princípios

- **SSR-first**: toda renderização inicial ocorre no servidor
- **Declarativo**: o markup HTML define a estrutura; os renderers cuidam da lógica
- **Sem reinventar reatividade**: bindings e signals client-side são responsabilidade do DataStar
- **Inspiração Vue, sem paridade**: diretivas declarativas no markup, mas sem compromissos como `v-model`
- **Baby steps / refinamento incremental**: decisões tomadas progressivamente, sem over-engineering antecipado

---

## Sistema de Componentes

O vínculo entre tag e renderer é feito pelo **nome da tag**:

- `<form>` → `renderForm()` (assinatura própria)
- `<table>` → `renderTable()` (assinatura própria)
- Cada renderer tem uma assinatura diferente — não existe renderer genérico único

---

## Estrutura de Arquivos

### Arquivo de Página vs. Arquivo de Componente

- **Arquivo de página**: representa uma rota da aplicação (ex: `index.html`)
- **Arquivo de componente**: unidade reutilizável de UI

### Arquivo Companion (`.md`)

Cada página possui um arquivo companion com o mesmo nome base:

| Arquivo | Função |
|---------|--------|
| `index.html` | Markup da rota |
| `index.md` | Configuração e documentação da rota |

O arquivo `.md` tem **dupla função**:
1. **Documentação** legível da página
2. **Documento ativo** que impacta a renderização (front matter, datasets)

O HTML permanece semântico e limpo — nenhuma contaminação com metadados.

---

## Estrutura do Arquivo Companion

### Front Matter

Propriedades declaradas no topo do `.md`. Divididas em duas categorias:

#### Estáticas (resolvidas no servidor)

| Propriedade | Descrição |
|-------------|-----------|
| `title` | Título da página / `<title>` (suporta interpolação de signal: `"Editando: {$nome}"`) |
| `description` | Meta description |
| `layout` | Layout wrapper a utilizar |
| `route` | Path canônico da rota |
| `permissions` | Controle de acesso |

#### Reativas (valores iniciais de signals DataStar)

| Propriedade | Descrição |
|-------------|-----------|
| `signals` | Mapa de valores iniciais de signals da página |
| `loading` | Estado de carregamento inicial |

> **Nota sobre interpolação**: propriedades estáticas como `title` suportam interpolação de signal (`{$nome}`). O servidor renderiza o valor inicial; o DataStar atualiza se o signal mudar.

---

### Seção Datasets

Declarada como `## Datasets` no `.md`. Cada dataset é uma subseção `### <nome>`.

#### Dataset Principal (main)

O dataset `main` é o **default** da rota — o conjunto de dados primário da página.

```markdown
## Datasets

### main (clientes)
- sqlQuery: |
    SELECT c.id, c.nome, c.cpf,
           ci.nome AS cidade, ci.uf
    FROM clientes c
    LEFT OUTER JOIN cidades ci ON ci.id = c.cidade_id
    WHERE c.ativo = true
  order: c.nome asc
  paginate: default
```

#### Datasets Secundários (lookups, dropdowns)

```markdown
### lookup (cidades)
- dataSource: cidades
- fields: id, nome, uf
- order: nome asc
- paginate: default
```

#### Modos de Declaração — Mutuamente Exclusivos

| Modo | Propriedades | Quando usar |
|------|--------------|------------|
| **Simples** | `dataSource` + `fields` | Tabela única, sem join |
| **Avançado** | `sqlQuery` | Joins, subqueries, SQL livre |

`fields` é opcional no modo simples, com default explícito `*`.

`paginate` deve ser sempre explícito, inclusive quando usar o valor `default`, para evitar acidentes e deixar a semântica visível em todas as páginas.

Além dos datasets funcionais da página, existe um dataset de nome reservado chamado `filter`, destinado à representação dos filtros da página.

---

## Contrato do Signal de Dataset

Cada dataset declarado gera um signal DataStar com a seguinte estrutura:

| Signal | Tipo | Descrição |
|--------|------|-----------|
| `$ds.<nome>.records` | Array | Registros retornados |
| `$ds.<nome>.record` | Object \| null | Registro corrente |
| `$ds.<nome>.recordIndex` | Number | Índice do registro corrente |
| `$ds.<nome>.total` | Number | Total de registros |
| `$ds.<nome>.pageSize` | Number | Tamanho da página |
| `$ds.<nome>.pageNumber` | Number | Página atual |
| `$ds.<nome>.loading` | Boolean | Estado de carregamento |
| `$ds.<nome>.filter` | Object | Filtros ativos |

---

## Comportamento de Lookup

Inspirado no modelo Delphi. O lookup é um input comum — sem componente especial para mobile (o teclado nativo provê o Enter).

| Cenário | Comportamento |
|---------|--------------|
| Usuário digita + Enter | Executa busca no dataset de lookup |
| 1 resultado (modal fechado) | Seleciona diretamente, sem abrir modal |
| 2+ resultados | Abre modal com tabela + barra de busca pré-preenchida |
| 1 resultado (modal já aberto) | Exibe para confirmação explícita do usuário |

> **Rationale**: quando o modal já está aberto, o contexto é de escolha explícita — seleção automática silenciosa poderia causar erros difíceis de detectar.

---

## Sugestões de Implementação

Esta seção registra decisões e direções conceituais de implementação sem entrar em detalhamento de código. O objetivo é orientar a arquitetura preservando o nível de abstração de produto.

### Módulo de Tags

O framework deve possuir um **módulo de tags** responsável por centralizar a definição das tags suportadas pelo sistema.

Esse módulo deve trabalhar com um **catálogo de tags** (`tagsCatalog`), implementado como um `Map` JavaScript:

- a chave é o **nome da tag**
- o valor é um **objeto de definição da tag**

Cada definição de tag deve conter, no mínimo:

- `renderer`: função responsável pela renderização da tag
- `requiredChildren`: lista de filhos obrigatórios
- `optionalChildren`: lista de filhos opcionais

A lista de filhos permitidos é implicitamente dada pela união entre `requiredChildren` e `optionalChildren`. Portanto, não faz sentido manter uma propriedade redundante como `allowedChildren`.

### Papel do Catálogo

O catálogo de tags não serve apenas para despachar renderers. Ele também define o **contrato estrutural** de cada tag.

Isso permite que o sistema:

- resolva o renderer a partir do nome da tag
- valide a estrutura de filhos de cada componente
- concentre metadata futura da tag no mesmo ponto de definição

Exemplo conceitual:

- `form` → renderer próprio e regras estruturais próprias
- `table` → renderer próprio e possibilidade de declarar filhos obrigatórios e opcionais, como cabeçalho, corpo e rodapé

### Helpers do Módulo

O módulo também pode expor **helpers de consulta**, como por exemplo:

- `findTag(...)`
- `getTagDefinition(...)`

A intenção é facilitar a leitura e o consumo do catálogo em outros pontos do sistema, mesmo que tecnicamente o `Map` já permita acesso direto.

Por outro lado, não é necessário blindar mutações do catálogo neste momento. Isso é **backlog do arrependimento**: só será feito no dia em que houver arrependimento de não ter blindado.

---

## Backlog do Arrependimento

O produto adota explicitamente a noção de **backlog do arrependimento**.

Esse backlog contém coisas que, em tese, poderiam ser consideradas boas práticas, melhorias de segurança, robustez ou performance, mas que neste momento representam custo, complexidade ou perda de foco desnecessária.

A regra é simples:

- se funciona de forma simples, fica simples
- se um problema real aparecer, o item sai do backlog do arrependimento e entra no backlog ativo

### Exemplos típicos

- endurecimento excessivo de segurança em aplicações sem criticidade real
- otimização antecipada de queries SQL
- criação prematura de índices
- blindagem excessiva de APIs internas do framework
- abstrações para problemas que ainda não existem
- blindagem de mutações do catálogo de tags antes de existir necessidade real

O backlog do arrependimento não é descartado; ele fica registrado como uma reserva consciente de decisões adiadas.

---

## Backlog Ativo

O **backlog ativo** contém somente o que precisa ser tratado agora para o produto evoluir com clareza.

A intenção é evitar que o projeto seja soterrado por preocupações hipotéticas. Quando algo deixar de ser especulação e virar problema concreto, passa do backlog do arrependimento para o backlog ativo.

---

## Fora de Escopo

Existe também um conjunto de decisões que não pertence nem ao backlog ativo nem ao backlog do arrependimento. São itens **fora de escopo do projeto**.

Esses pontos representam escolhas estruturais de produto, design ou direção técnica que simplesmente não farão parte da proposta atual.

Exemplo:

- suporte a islands architecture
- hidratação parcial ou estratégias equivalentes, quando isso contrariar a proposta SSR-first do produto

Esses itens não ficam pendurados como pendência técnica. Eles são tratados como decisões de escopo.

---

## Tópicos em Aberto

- [ ] Quais propriedades do front matter devem se tornar signals reativos vs. permanecer estáticas
- [ ] Comportamento exato do dataset reservado `filter`
- [ ] Forma final da semântica de `paginate: default` e dos demais valores explícitos

---

**Versão:** 1.0 | **Data:** 2026-06-05 | **Próxima revisão:** Após primeira implementação POC
