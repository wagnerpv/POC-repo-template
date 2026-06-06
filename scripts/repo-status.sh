#!/bin/bash

# Gera REPO-STATUS.md com estado atual do repositório.
# Executar a partir da raiz do repositório.
#
# Uso:
#   export GITHUB_TOKEN='ghp_...'
#   bash scripts/repo-status.sh > REPO-STATUS.md

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.." || exit 1

# Require GITHUB_TOKEN
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN environment variable not set"
  exit 1
fi

export GITHUB_TOKEN

# Inferir repo owner/name a partir do remote origin
REPO_URL=$(git remote get-url origin)
# Suporta https://github.com/owner/repo.git e git@github.com:owner/repo.git
REPO=$(echo "$REPO_URL" | sed -E 's|.*github\.com[:/]||;s|\.git$||')

# Sync
git fetch origin
git remote prune origin

# Último commit em main com fuso Brasil
COMMIT_DATA=$(git log -1 --format="%aI|%s" main)
HASH=$(git log -1 --format="%H" main)
DATA=$(echo "$COMMIT_DATA" | cut -d'|' -f1)
MSG=$(echo "$COMMIT_DATA" | cut -d'|' -f2-)

DATA_BRASIL=$(TZ="America/Sao_Paulo" date -d "$DATA" "+%d/%m/%Y %H:%M:%S %Z")

# Gerar markdown
cat << MARKDOWN
# Repository Status

> Gerado por \`scripts/repo-status.sh\`. Não editar manualmente.

## ÚLTIMO COMMIT

**Hash:** \`$HASH\`

**Data (Brasil):** $DATA_BRASIL

**Mensagem:** $MSG

---

## PRS ABERTOS

$(gh pr list --repo "$REPO" --state open --json number,title --template='{{range .}}- #{{.number}} - {{.title}}{{"\n"}}{{end}}' || echo "Nenhum")

---

## ISSUES ABERTOS

$(gh issue list --repo "$REPO" --state open --json number,title --template='{{range .}}- #{{.number}} - {{.title}}{{"\n"}}{{end}}' || echo "Nenhum")

---

## ÚLTIMO PR FECHADO

$(gh pr list --repo "$REPO" --state closed --limit 1 --json number,title,closedAt --template='{{range .}}**#{{.number}}** - {{.title}}{{"\\n\\n"}}**Data:** {{.closedAt}}{{"\\n\\n"}}**Link:** https://github.com/'"$REPO"'/pull/{{.number}}{{"\\n"}}{{end}}' || echo "Nenhum")

---

## ÚLTIMO ISSUE FECHADO

$(gh issue list --repo "$REPO" --state closed --limit 1 --json number,title,closedAt --template='{{range .}}**#{{.number}}** - {{.title}}{{"\\n\\n"}}**Data:** {{.closedAt}}{{"\\n"}}{{end}}' || echo "Nenhum")
MARKDOWN
