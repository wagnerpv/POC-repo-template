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

