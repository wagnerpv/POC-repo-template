# Contributing

## Branch Naming

| Prefixo | Uso |
|---------|-----|
| `work-session-YYYYMMDD-HHNN` | Sessão de trabalho do agente |
| `feat/xyz` | Nova funcionalidade |
| `fix/xyz` | Correção de bug |
| `chore/xyz` | Manutenção |
| `refactor/xyz` | Refatoração |
| `docs/xyz` | Documentação |

**Fuso:** Brasil (-03:00). **Nunca commitar diretamente em `main` — sempre via PR.**

---

## Work Sessions (Agente)

### Início de Sessão

```bash
git fetch --all --prune
git checkout main
git pull origin main
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D
git checkout -b work-session-YYYYMMDD-HHNN
mkdir -p work-sessions/YYYYMMDD-HHNN
cp work-sessions/TEMPLATE-scratchpad.md work-sessions/YYYYMMDD-HHNN/scratchpad.md
export GITHUB_TOKEN='...'
bash scripts/repo-status.sh > REPO-STATUS.md
# Se houver ROADMAP ativo — ler e identificar próxima etapa ⏳
```

### Regra de PR

Se há um PR aberto e o conteúdo faz sentido no escopo — incluir diretamente, sem perguntar.

### Fim de Sessão

```bash
# 1. Atualizar scratchpad + CHANGELOG.md
# 2. Atualizar ROADMAP se houver (marcar etapas concluídas)
# 3. Criar HANDOFF.md
# 4. Renomear sessão com -ended
mv work-sessions/YYYYMMDD-HHNN work-sessions/YYYYMMDD-HHNN-ended
# 5. Commit + push + PR
git add .
git commit -m "chore: close session YYYYMMDD-HHNN"
git push origin work-session-YYYYMMDD-HHNN
gh pr create --base main --head work-session-YYYYMMDD-HHNN --title "work-session-YYYYMMDD-HHNN" --body "..."
```

### Sessões Encerradas

```bash
mv work-sessions/YYYYMMDD-HHNN work-sessions/YYYYMMDD-HHNN-ended
git add work-sessions/
git commit -m "chore: marca sessão YYYYMMDD-HHNN como encerrada"
```

---

## CHANGELOG.md

```markdown
## [YYYY-MM-DD] Título

- O que foi entregue
- Testes: X/X ✅

**PR:** #N
```

---

## Estrutura de Pastas

```
src/           — código de produção
POCs/          — provas de conceito
docs/          — documentação estável
work-sessions/ — sessões de trabalho
scripts/       — automação
drafts/        — rascunhos WIP (dentro de work-sessions ou docs/)
```
