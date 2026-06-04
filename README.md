# agente-perplexity-sandbox

Minimal workspace bootstrap for running a local workflow compatible with Perplexity-style sandbox tasks.

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

Use a session-only token export when the human provides an ephemeral PAT.

```bash
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
export GITHUB_TOKEN='YOUR_EPHEMERAL_PAT'
export GH_TOKEN="$GITHUB_TOKEN"
```

## Authenticate gh

Use stdin to avoid placing the token directly in shell history.

```bash
printf '%s\n' "$GITHUB_TOKEN" | gh auth login --hostname github.com --with-token
gh auth status
```

## Git over HTTPS

Clone or push with the token only when required.

```bash
git clone "https://x-access-token:${GITHUB_TOKEN}@github.com/OWNER/REPO.git"
cd REPO
```

To update an existing remote for authenticated push:

```bash
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/OWNER/REPO.git"
git push origin main
```

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

- Prefer ephemeral PATs for short-lived authenticated operations.
- Do not persist the token in `.git-credentials`, shell profiles, or repo files unless there is an explicit requirement to do so.
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
