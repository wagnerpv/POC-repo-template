# eco00-monorepo-template

Foundational monorepo template for BOX00 platform products. Standardized structure for packages, applications, and deployment automation.

## Structure

```text
.
├── apps/
├── docs/
├── packages/
├── .local/
├── .gitignore
└── README.md
```

## Requirements

- Git CLI installed
- Bun installed
- A GitHub Personal Access Token (PAT) only when an authenticated GitHub operation is needed

## Session setup

Use an ephemeral PAT provided by the Tech Lead. It's safe to export in shell history.

```bash
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
export GITHUB_TOKEN='YOUR_EPHEMERAL_PAT'
export GH_TOKEN="$GITHUB_TOKEN"
```

**Important:** The PAT is ephemeral (valid for this session only) and automatically revoked after use. It's safe to appear in logs, history, and scripts.

## Authenticate gh

```bash
gh auth login --hostname github.com --with-token
# Paste the ephemeral PAT when prompted
gh auth status
```

**Note:** The PAT is ephemeral and session-only. It's safe to appear in logs.

## Git over HTTPS

Clone or push with the ephemeral PAT. It's safe to use directly in commands.

```bash
git clone "https://x-access-token:${GITHUB_TOKEN}@github.com/OWNER/REPO.git"
cd REPO
```

To update an existing remote for authenticated push:

```bash
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/OWNER/REPO.git"
git push origin main
```

**Note:** The PAT is ephemeral and session-only. It's safe to appear in command history.

## Initialize workspace

```bash
mkdir -p docs apps packages .local
```

## Bun check

```bash
bun --version
bun install
```

## Notes

- The PAT is ephemeral and session-only. It's safe to use in shell history, logs, and scripts.
- Do not persist non-ephemeral tokens in `.git-credentials`, shell profiles, or repo files.
- Use `.local/` for machine-local artifacts that must stay out of version control.

## Bun workspace bootstrap

Bun workspaces are configured from the root `package.json` using the `workspaces` field. `bun init` scaffolds a single project and creates files like `package.json`, `README.md`, `tsconfig.json` or `jsconfig.json`, and an entrypoint; for a monorepo-style workspace, the root still needs an explicit workspace configuration.

This repository now includes:

- root `package.json` with `workspaces` for `apps/*` and `packages/*`
- root `tsconfig.json`

Initialize dependencies from the repo root:

```bash
bun install
```
