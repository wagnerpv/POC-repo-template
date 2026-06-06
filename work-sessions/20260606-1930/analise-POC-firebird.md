# Análise — POC-firebird

**Data:** 2026-06-06
**Status:** POC de conectividade nativa Firebird com Bun

---

## O que é

Monorepo de teste para conectividade nativa Firebird via Bun. Inclui scripts de automação para dependências de sistema e orquestração via Docker.

## Estrutura

```
POC-firebird/
├── docker/
│   ├── firebird-v5_0-docker-compose.yml  ← Firebird 5.0 via Docker
│   └── firebird.conf                      ← Config do servidor
├── scripts/
│   ├── check-isql-fb.sh    ← Verificar isql
│   ├── fbclient-install.sh ← Instalar libfbclient
│   ├── fbclient-remove.sh  ← Remover libfbclient
│   └── ping-firebird.sh    ← Testar conectividade
├── packages/               ← Vazio (workspace preparado)
└── qqfdb.zip               ← Package qqfdb zipado
```

## Conteúdo Principal

### Docker Setup
- Firebird 5.0 via docker-compose
- Config canônica do servidor

### Scripts de Setup
- Automação de instalação do `libfbclient` (dependência nativa)
- Scripts de verificação e teste de conectividade

### `qqfdb.zip`
Package qqfdb comprimido — provavelmente contém a abstração Firebird também vista em POC-carteiro-service-2026.

## Avaliação

**Maturidade:** Baixa (infra/scripts, sem código de negócio)
**Relevância para eco00:** Média (Firebird é usado em produção no legado)
**Destino sugerido:** Manter como referência de setup de infraestrutura

## Artefatos a Extrair

| Artefato | Destino |
|----------|---------|
| `docker/firebird-v5_0-docker-compose.yml` | `docs/infra/` ou sandbox template |
| `scripts/fbclient-install.sh` | `scripts/` do monorepo (setup de ambiente) |
| `qqfdb.zip` | Extrair e comparar com qqfdb de POC-carteiro |
