# Contributing

## Branch Naming

Todo trabalho acontece em branches, nunca em `main` diretamente.

| Prefixo | Uso |
|---------|-----|
| `work-session-YYYYMMDD-HHNN` | Branch de sessão de trabalho do agente |
| `feat/xyz` | Nova funcionalidade |
| `fix/xyz` | Correção de bug |
| `chore/xyz` | Manutenção (docs, cleanup, scripts) |
| `refactor/xyz` | Refatoração de código |
| `docs/xyz` | Documentação |

**Fuso:** Brasil (-03:00) para timestamps.

**Exemplo:** `work-session-20260606-1700` (06 de junho de 2026, 17:00 Brasil)

## Commits

Commits atômicos e descritivos:

```bash
git commit -m "type: descrição curta

Explicação mais longa se necessário.
- Detalhe específico
- Outro detalhe"
```

**Types:** `feat`, `fix`, `chore`, `docs`, `refactor`, `test`

## Pull Requests

1. Criar PR da branch para `main`
2. Título: descreve o que mudou
3. Descrição: explica o porquê
4. Linkar issues relacionadas

**Nunca commitar diretamente em `main` — sempre via PR.**

## Work Sessions (Agente)

Cada sessão de trabalho do agente segue este ciclo:

### Início de Sessão

```bash
# 1. Sincronizar
git fetch --all --prune

# 2. Limpar branches stale
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D

# 3. Criar branch de sessão (NUNCA trabalhar em main)
git checkout -b work-session-YYYYMMDD-HHNN
# Exemplo: git checkout -b work-session-20260606-1700

# 4. Criar pasta de sessão e scratchpad
mkdir -p work-sessions/YYYYMMDD-HHNN
cp work-sessions/TEMPLATE-scratchpad.md work-sessions/YYYYMMDD-HHNN/scratchpad.md
# Editar scratchpad.md com contexto inicial

# 5. Gerar REPO-STATUS.md
export GITHUB_TOKEN='...'
bash scripts/repo-status.sh > REPO-STATUS.md
```

### Durante a Sessão

```bash
# Trabalhar em work-session-YYYYMMDD-HHNN
# Múltiplos commits OK
git add <files>
git commit -m "feat/chore/docs: descrição"

# Atualizar scratchpad com progresso
# work-sessions/YYYYMMDD-HHNN/scratchpad.md
```

### Fim de Sessão

```bash
# 1. Atualizar scratchpad com resultado final
# 2. Registrar resultado no CHANGELOG.md
# 3. Commitar
git add work-sessions/ CHANGELOG.md REPO-STATUS.md
git commit -m "chore: close session YYYYMMDD-HHNN"

# 4. Push e PR (branch mantém o nome da sessão)
git push origin work-session-YYYYMMDD-HHNN
gh pr create --base main --head work-session-YYYYMMDD-HHNN --title "work-session-YYYYMMDD-HHNN" --body "..."
```


### Sessões Encerradas

Ao encerrar uma sessão, renomear a pasta com sufixo `-ended`:

```bash
# Após merge do PR da sessão
mv work-sessions/YYYYMMDD-HHNN work-sessions/YYYYMMDD-HHNN-ended
git add work-sessions/
git commit -m "chore: marca sessão YYYYMMDD-HHNN como encerrada"
git push origin main  # ou via PR se main for protegida
```

Isso sinaliza visualmente que a sessão está fechada sem apagar o histórico. Atualizar o índice `work-sessions/README.md` em seguida.

### Próxima Sessão (após merge do PR)

```bash
git fetch --all --prune
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D
git checkout -b work-session-YYYYMMDD-HHNN   # nova sessão, novo timestamp
bash scripts/repo-status.sh > REPO-STATUS.md  # estado atual
```

## CHANGELOG.md

O `CHANGELOG.md` é o histórico global de entregas do repositório.

**Quando atualizar:** Ao fechar cada sessão de trabalho, registrar o que foi entregue.

**Formato:**

```markdown
## [YYYY-MM-DD] Título da entrega

- O que foi feito
- Pacote ou feature entregue
- Testes: X/X ✅

**Branch:** feat/nome-semantico
**PR:** #N
```

**Regras:**
- Entradas em ordem cronológica reversa (mais recente primeiro)
- Focar no resultado, não no processo
- O processo fica no `scratchpad.md` da sessão
- Só registrar o que foi mergeado em `main`

## Drafts

A pasta `drafts/` é a área de rascunhos e WIP do repositório.

**Quando usar:**
- Visões de produto em elaboração
- Pesquisas e análises de referência (ex: comparativos com outros frameworks)
- Decisões arquiteturais ainda não estabilizadas
- Qualquer documento que ainda não é spec nem doc oficial

**Regras:**
- Arquivos em `drafts/` não têm compromisso de estabilidade — podem mudar ou ser descartados
- Não referenciar arquivos de `drafts/` em código de produção ou testes
- Quando um draft estabilizar, migrar para `docs/` com PR explícito

**O que não vai para `drafts/`:**
- Código (vai para `packages/` ou `apps/`)
- Sessões de trabalho (vão para `work-sessions/`)
- Documentação oficial de packages (vai junto ao package)

---

## REPO-STATUS.md

Estado ao vivo do repositório: último commit, PRs abertos, issues abertas.

**Gerado automaticamente:**
```bash
export GITHUB_TOKEN='...'
bash scripts/repo-status.sh > REPO-STATUS.md
```

**Nunca editar manualmente.**
