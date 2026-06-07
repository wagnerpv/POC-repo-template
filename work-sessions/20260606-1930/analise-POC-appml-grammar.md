# Análise — POC-appml-grammar

**Data:** 2026-06-06
**Status:** Arquivo de gramáticas e definições XML para sistema AppML legado

---

## O que é

**NÃO é eco00.** É um repositório de definições XML de aplicações de negócio (ERP/PDV) construídas sobre o framework AppML (legado). Contém ~20 aplicações de domínio diferentes normalizadas em formato XML.

## Estrutura

```
POC-appml-grammar/
├── appml-grammar/             ← Schemas JSON de gramática AppML
│   ├── appOptions-grammar.json
│   ├── database-grammar.json
│   ├── module-grammar.json
│   └── ...
├── appml-normalized/          ← Aplicações normalizadas (XML)
│   ├── academia/              ← Sistema de academia
│   ├── ai/                    ← Administração de imóveis
│   ├── aluno/                 ← Sistema de alunos/cursos
│   ├── cbt/                   ← Computer-Based Training
│   ├── maestroimoveis/        ← Gestão de imóveis
│   ├── medic/                 ← Sistema médico
│   ├── pafrecover/            ← PDV completo com PAF
│   ├── pafsimples/            ← PDV simplificado
│   ├── pdv/                   ← PDV básico
│   ├── sat/                   ← SAT (sistema ERP)
│   ├── sg/                    ← SG (sistema ERP comercial)
│   ├── sgfood/                ← SG Food (restaurante/food service)
│   ├── sgpaf/                 ← SG PDV com PAF
│   ├── smart/                 ← Smart ERP
│   ├── vending/               ← Sistema de vending machines
│   └── ...
├── appml-grammar-schema.json  ← Schema completo
├── appml-directives.md        ← Documentação das diretivas
└── appml-build-root-trees.js  ← Script de build
```

## Avaliação

**Relevância para eco00:** Baixa — é um repositório de definições de sistema legado (AppML)
**Maturidade:** Alta (muitas aplicações completas, muito conteúdo)
**Relação com eco00:** Provavelmente é o "corpus" de dados/modelos de negócio que inspira o design de sistemas futuros

## O que NÃO extrair

- Nenhum código é reutilizável diretamente — é XML de configuração de framework legado
- Nenhum padrão eco00 aqui

## O que PODE ser referência (indireto)

- **Modelos de negócio:** Os domínios cobertos (ERP, PDV, imóveis, food service, vending) são referência de complexidade de negócio
- **Vocabulário de módulos:** Os nomes de módulos (cadastro-de-*, pesquisa-*, filtro-*, listagem-de-*) são padrões de nomenclatura para CRUD que podem influenciar eco00
- **appml-directives.md:** Pode ter insights sobre padrões declarativos

## Destino sugerido

Manter como está — é um arquivo histórico. Não há artefatos para extrair para eco00.
