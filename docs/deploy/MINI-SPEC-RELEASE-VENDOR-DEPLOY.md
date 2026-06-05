# Mini-spec de Release, Vendor Install e Deploy por Artefato

## Premissas

- Cada versão publicada corresponde a uma **tag Git imutável** no formato `vX.Y.Z`.
- Cada tag gera exatamente um **artefato zip versionado**.
- O consumo interno nunca depende de branch; depende apenas de **versão declarada**.
- O install/update é sempre determinístico: resolver versão, garantir artefato local, extrair, validar, trocar ponteiro.
- O deploy de app segue o mesmo princípio: baixar artefato da tag, extrair, sincronizar, ativar release.
- **Todos os artefatos, código e dados residem em `/home/<user>/`** — sem paths fora do home.
- **Estrutura:** `repos/` para código-fonte, `envs/tenantKey/` para ambientes específicos.

---

## Convenções

### Versionamento

- Tag Git: `vX.Y.Z`
- Campo em `package.json`: `X.Y.Z`
- Nome do zip de pacote: `<package-name>-vX.Y.Z.zip`
- Nome do zip de app: `<app-name>-vX.Y.Z.zip`

### Estrutura de vendor (em home do user)

```
/home/<user>/
  repos/
    eco00-monorepo-template/
    brcitas/
    bitbox00/
  
  envs/
    tenantKey-production/vendor/eco00/...
    tenantKey-staging/vendor/eco00/...
    tenantKey-dev/vendor/eco00/...
    dev-a1b2c3d/vendor/eco00/...      (dev ephemeral)
    dev-x9y8z7w/vendor/eco00/...      (dev ephemeral)
```

### Ambientes de Desenvolvimento

Ambientes de dev seguem padrão reduzido com **7 caracteres**:

- **Formato:** `dev-<7-char-id>`
- **Exemplo:** `dev-a1b2c3d`, `dev-x9y8z7w`
- **Criação:** Manual via workflow GitHub (`workflow_dispatch`)
- **Destruição:** Manual via workflow GitHub (`workflow_dispatch`)
- **Ciclo de vida:** Ephemeral, criado sob demanda e destruído após uso
- **Automação:** Nenhuma — totalmente controlado por disparo manual

**Estrutura dentro de `dev-<id>/`:**
```
/home/<user>/envs/dev-a1b2c3d/
  vendor/
  apps/
  sandbox/
  .env
```

---

## Scripts Principais

- `release-package` — Publicar package com tag e zip
- `vendor-install` — Consumir package em vendor local  
- `deploy-app` — Promover app release entre ambientes

---

## Invariantes

- Tag é imutável
- Cada tag = um único zip
- Deploy baseado em artefato, nunca em branch
- Extração em staging antes de promoção
- Ativação por symlink, não sobrescrita
- Rollback por repontar symlink
- Todos os paths em `/home/<user>/`

---

## Workflows para Ambientes de Desenvolvimento

### Criar Ambiente Dev (Manual)

**Arquivo:** `.github/workflows/create-dev-env.yml`

**Trigger:** `workflow_dispatch`

**Inputs:**
- `environment-id`: 7 caracteres (ex: `a1b2c3d`)

**Ações:**
1. Criar estrutura de diretórios em `/home/<user>/envs/dev-<id>/`
2. Inicializar `vendor/`, `apps/`, `sandbox/`
3. Criar `.env` com configurações de dev
4. Registrar ambiente no inventory (opcional)
5. Output: caminho do novo ambiente

**Exemplo de uso:**
```bash
gh workflow run create-dev-env.yml -f environment-id=a1b2c3d
```

---

### Destruir Ambiente Dev (Manual)

**Arquivo:** `.github/workflows/destroy-dev-env.yml`

**Trigger:** `workflow_dispatch`

**Inputs:**
- `environment-id`: 7 caracteres (ex: `a1b2c3d`)

**Ações:**
1. Validar existência de `/home/<user>/envs/dev-<id>/`
2. Remover diretório completamente
3. Limpar registros (logs, configs)
4. Confirmar destruição

**Exemplo de uso:**
```bash
gh workflow run destroy-dev-env.yml -f environment-id=a1b2c3d
```

---