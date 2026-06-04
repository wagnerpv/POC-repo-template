# Perplexity Sandbox Bootstrap Prompt

Use your own sandbox as the execution environment for this task.

## Objective

Initialize a fresh Perplexity sandbox so it is ready for repository-based work with Git and Bun, using an ephemeral GitHub Personal Access Token supplied by the human only when authenticated GitHub operations are required.

## Operating rules

- Work inside your own sandbox, not the human's machine.
- Use the sandbox terminal to install any missing user-space tools needed for the task.
- Prefer user-space installation paths such as `~/.local/bin` and `~/.bun/bin`.
- Keep the token ephemeral and scoped to the current session whenever possible.
- Avoid persisting credentials in long-lived files unless the task explicitly requires it.
- Treat the sandbox as disposable, but complete the setup so Git CLI, GitHub CLI, and Bun are usable during the session.

## Required actions

1. Ensure `git` is available.
2. Ensure `gh` is available; install it in user-space if missing.
3. Ensure `bun` is available; install it in user-space if missing.
4. Export the environment variables needed for authenticated GitHub operations.
5. Clone the source repository provided by the human.
6. Rename the cloned working directory to `perplexity-sandbox`.
7. Create an additional GitHub repository named `WagnerPV/Perplexity-YYYYMMDD-HHNN`, where the timestamp is generated at runtime in UTC or local sandbox time and uses four digits for hours and minutes.
8. Report the resulting local directory and created repository URL.

## Shell bootstrap block

Replace the placeholder values before running.

```bash
set -euo pipefail

export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
export GITHUB_TOKEN='__EPHEMERAL_PAT__'
export GH_TOKEN="$GITHUB_TOKEN"
export SOURCE_REPO_URL='__SOURCE_REPO_URL__'

mkdir -p "$HOME/.local/bin"

if ! command -v gh >/dev/null 2>&1; then
  ARCH="$(uname -m)"
  case "$ARCH" in
    x86_64) GH_ARCH=amd64 ;;
    aarch64|arm64) GH_ARCH=arm64 ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
  esac
  GH_VERSION="$(curl -fsSL https://api.github.com/repos/cli/cli/releases/latest | grep '"tag_name":' | head -n1 | sed -E 's/.*"v?([^"]+)".*/\1/')"
  cd "$HOME/.local/bin"
  curl -fsSL -o gh.tgz "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${GH_ARCH}.tar.gz"
  tar -xzf gh.tgz
  cp "gh_${GH_VERSION}_linux_${GH_ARCH}/bin/gh" ./gh
  chmod +x ./gh
  rm -rf gh.tgz "gh_${GH_VERSION}_linux_${GH_ARCH}"
fi

if ! command -v bun >/dev/null 2>&1; then
  curl -fsSL https://bun.sh/install | bash
fi

printf '%s\n' "$GITHUB_TOKEN" | gh auth login --hostname github.com --with-token >/dev/null 2>&1 || true

git clone "${SOURCE_REPO_URL}" "$HOME/perplexity-sandbox"
cd "$HOME/perplexity-sandbox"

STAMP="$(date +%Y%m%d-%H%M)"
NEW_REPO="WagnerPV/Perplexity-${STAMP}"

gh repo create "$NEW_REPO" --private >/dev/null

printf 'Workspace: %s\n' "$HOME/perplexity-sandbox"
printf 'Created repo: https://github.com/%s\n' "$NEW_REPO"
```

## Execution notes

- If the provided source repository URL is private, use an authenticated HTTPS URL when cloning.
- If the repository already exists locally under another name, rename or move it to `perplexity-sandbox`.
- If `gh repo create` reports that the repository name already exists, regenerate the timestamp and retry once.
- Do not ask whether a new repository should be created; create it automatically as part of the flow.
