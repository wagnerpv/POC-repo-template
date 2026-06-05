# vendor

Versionado packages da plataforma eco00.

## Estrutura

```
vendor/
└── <package-name>/
    └── <version>/
```

Exemplo:

```
vendor/
└── eco00-ssr-foundations/
    ├── v1.0.0/
    ├── v1.1.0/
    └── v2.0.0/
```

## Uso

Packages em `vendor/` são instalados via `vendor-install` script e consumidos localmente pelos `apps/` e `packages/` do monorepo.
