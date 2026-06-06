# Filesystem Conventions

Padrão de organização de diretórios para ambientes de desenvolvimento e deployments em eco00.

## Estrutura Canônica

Cada ambiente (dev, staging, prod) segue a mesma estrutura de 8 subdiretórios obrigatórios:

```
/home/claude/envs/dev-<7chars>/
├── config/          ← Configurações (não-secretas)
├── secrets/         ← Credenciais, keys, tokens
├── data/            ← Dados persistentes (banco, arquivos)
├── state/           ← Estado operacional (locks, semaphores)
├── cache/           ← Dados regeneráveis (cache, temp builds)
├── logs/            ← Registros operacionais
├── tmp/             ← Arquivos temporários (sessões, uploads)
└── run/             ← Runtime coordination (PIDs, sockets)
```

## Naming Convention

- **Base path:** `/home/claude/envs/`
- **Environment ID:** `dev-<7chars>` onde `<7chars>` = `[a-z0-9]{7}`
  - Exemplos: `dev-a1b2c3d`, `dev-xyz7890`, `dev-prod01`
- **Exemplo completo:** `/home/claude/envs/dev-a1b2c3d/config/`

## Propósito de Cada Subdiretório

### `config/`
**O quê:** Configurações não-secretas, variáveis de ambiente, settings

**Exemplos:**
```
/home/claude/envs/dev-a1b2c3d/config/
├── .env                    ← Variáveis públicas (DB_HOST=localhost)
├── app.json                ← Config da aplicação
├── database.yml            ← Database connection strings (públicas)
└── features.json           ← Feature flags
```

**Regra:** Pode estar no git, não contém credenciais

---

### `secrets/`
**O quê:** Credenciais, tokens, chaves privadas, senhas

**Exemplos:**
```
/home/claude/envs/dev-a1b2c3d/secrets/
├── .env.secrets            ← Env vars secretas (DB_PASSWORD=xxx)
├── api-keys.json           ← API keys (Anthropic, OpenAI, etc.)
├── github-token            ← PAT do GitHub
├── ssh-keys/               ← SSH private keys
│   ├── id_rsa              ← Chave privada
│   └── id_rsa.pub          ← Chave pública
└── tls/                    ← Certificados TLS
    ├── cert.pem
    └── key.pem
```

**Regra:** NUNCA no git, mode 0600 (legível apenas por owner), rotação periódica

---

### `data/`
**O quê:** Dados persistentes (banco de dados, arquivos estáticos, uploads)

**Exemplos:**
```
/home/claude/envs/dev-a1b2c3d/data/
├── db/                     ← Banco de dados
│   ├── app.db              ← SQLite (dev)
│   └── backups/            ← Snapshots periódicos
├── uploads/                ← Arquivos enviados por usuários
├── generated/              ← PDFs, imagens geradas
└── cache.db                ← Cache persistente
```

**Regra:** Backup regular, ownership clara, acesso controlado por applicação

---

### `state/`
**O quê:** Estado operacional (locks, semaphores, markers, coordenação)

**Exemplos:**
```
/home/claude/envs/dev-a1b2c3d/state/
├── .lock                   ← Lock file (migration em andamento?)
├── deployment.marker       ← Marker de deploy em progresso
├── last-sync.json          ← Timestamp último sync
└── health-check.log        ← Health check status
```

**Regra:** Criado/deletado por aplicação, não deve persistir entre restarts (exceto markers)

---

### `cache/`
**O quê:** Dados regeneráveis (compilação, node_modules, artifacts)

**Exemplos:**
```
/home/claude/envs/dev-a1b2c3d/cache/
├── node_modules/           ← npm packages
├── .astro/                 ← Astro build cache
├── build/                  ← Artifacts compilados
└── dist/                   ← Output de build
```

**Regra:** Pode ser deletado sem perda de dados, rebuilds da origin (git ou package manager)

---

### `logs/`
**O quê:** Registros operacionais (application logs, error logs, audit logs)

**Exemplos:**
```
/home/claude/envs/dev-a1b2c3d/logs/
├── app.log                 ← Application output
├── error.log               ← Errors
├── access.log              ← HTTP access log
├── audit.log               ← Audit trail (quem fez o quê)
└── archive/                ← Logs antigos (rotação)
    └── app-2026-06-05.log.gz
```

**Regra:** Rotação automática, retention policy (ex: 30 dias), compressão de antigos

---

### `tmp/`
**O quê:** Arquivos temporários (uploads em progresso, sessões, scratch)

**Exemplos:**
```
/home/claude/envs/dev-a1b2c3d/tmp/
├── uploads/                ← Uploads em progresso
├── sessions/               ← Session cookies/tokens
├── scratch/                ← Arquivos de trabalho temporários
└── .gitkeep                ← Marca diretório como versioned
```

**Regra:** Limpar regularmente (cron job daily), recriar se deletado, max 1GB

---

### `run/`
**O quê:** Runtime coordination (PIDs, sockets, semaphores)

**Exemplos:**
```
/home/claude/envs/dev-a1b2c3d/run/
├── app.pid                 ← PID do processo principal
├── api.sock                ← Unix socket da API
├── health.sock             ← Health check socket
└── services.json           ← Serviços rodando (metadata)
```

**Regra:** Criado dinamicamente, não persiste entre restarts, owner=app user

---

## Exemplo Prático: Dev Environment Setup

```bash
#!/bin/bash
# Criar novo dev environment

ENV_ID="dev-a1b2c3d"
BASE="/home/claude/envs/${ENV_ID}"

# Criar estrutura
mkdir -p "${BASE}"/{config,secrets,data,state,cache,logs,tmp,run}

# Permissões
chmod 755 "${BASE}"/{config,cache,logs,tmp,run}
chmod 700 "${BASE}"/{secrets,data,state}       # Owner only

# Criar .env em config/
cat > "${BASE}/config/.env" << EOF
NODE_ENV=development
DB_HOST=localhost
DB_PORT=5432
DB_NAME=app_dev_${ENV_ID}
CACHE_DIR=${BASE}/cache
DATA_DIR=${BASE}/data
EOF

# Criar secrets placeholder
cat > "${BASE}/secrets/.env.secrets" << EOF
DB_USER=dev
DB_PASSWORD=CHANGE_ME
API_KEY=CHANGE_ME
EOF
chmod 600 "${BASE}/secrets/.env.secrets"

echo "Environment ${ENV_ID} created at ${BASE}"
```

## Cleanup: Destruir Environment

```bash
#!/bin/bash
# Destruir dev environment

ENV_ID="dev-a1b2c3d"
BASE="/home/claude/envs/${ENV_ID}"

# Backup logs antes de deletar
tar czf "/tmp/logs-backup-${ENV_ID}-$(date +%s).tar.gz" "${BASE}/logs/"

# Deletar tudo
rm -rf "${BASE}"

echo "Environment ${ENV_ID} destroyed, logs backed up to /tmp/"
```

## Policy de Acesso

| Diretório | Owner | Mode  | Git | Descrição |
|-----------|-------|-------|-----|-----------|
| `config/` | app   | 755   | ✅ | Público, versionado |
| `secrets/` | app   | 700   | ❌ | Privado, .gitignore |
| `data/`    | app   | 700   | ❌ | Privado, backups regulares |
| `state/`   | app   | 700   | ❌ | Privado, ephemeral |
| `cache/`   | app   | 755   | ❌ | Regenerável, .gitignore |
| `logs/`    | app   | 755   | ❌ | Rotação automática |
| `tmp/`     | app   | 755   | ❌ | Limpeza diária |
| `run/`     | app   | 755   | ❌ | Ephemeral, criado em runtime |

## Variáveis de Ambiente Padrão

Cada ambiente deve expor:

```bash
# Em config/.env ou injetado em runtime
ECO00_ENV_ID="dev-a1b2c3d"
ECO00_ENV_BASE="/home/claude/envs/dev-a1b2c3d"
ECO00_CONFIG_DIR="${ECO00_ENV_BASE}/config"
ECO00_SECRETS_DIR="${ECO00_ENV_BASE}/secrets"
ECO00_DATA_DIR="${ECO00_ENV_BASE}/data"
ECO00_STATE_DIR="${ECO00_ENV_BASE}/state"
ECO00_CACHE_DIR="${ECO00_ENV_BASE}/cache"
ECO00_LOGS_DIR="${ECO00_ENV_BASE}/logs"
ECO00_TMP_DIR="${ECO00_ENV_BASE}/tmp"
ECO00_RUN_DIR="${ECO00_ENV_BASE}/run"
```

Aplicações devem ler essas variáveis, não hardcodejar paths.

## Referência Rápida

```bash
# Ver todos envs
ls -la /home/claude/envs/

# Ver estrutura de um env
tree /home/claude/envs/dev-a1b2c3d/

# Revisar config
cat /home/claude/envs/dev-a1b2c3d/config/.env

# Ver dados persistentes
du -sh /home/claude/envs/dev-a1b2c3d/data/

# Tail logs
tail -f /home/claude/envs/dev-a1b2c3d/logs/app.log

# Limpar cache (safe)
rm -rf /home/claude/envs/dev-a1b2c3d/cache/*

# Limpar tmp (safe)
find /home/claude/envs/dev-a1b2c3d/tmp/ -mtime +1 -delete
```

---

**Última atualização:** 2026-06-05  
**Versão:** 1.0  
**Escopo:** eco00-monorepo-template
