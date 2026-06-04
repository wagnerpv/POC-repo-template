# Git Workflow — Regras de Verificação Obrigatória

**Propósito:** Garantir que toda operação Git/GitHub seja verificada após execução.
**Motivação:** Falhas silenciosas em `gh pr create`, `git push`, e outras operações críticas devem ser detectadas imediatamente — não descobertas depois.

---

## Regra Fundamental

> **Toda operação crítica DEVE ter sua conclusão verificada antes de prosseguir.**

Não existe "falhou silenciosamente". Existe "o agente não verificou". A responsabilidade é do agente.

---

## Checklist de Verificação por Operação

### `git push`
```bash
# Executar
git push origin <branch>

# Verificar IMEDIATAMENTE
git log origin/<branch> --oneline -1
# Deve mostrar o commit que acabou de ser pushed.
# Se não mostrar: investigar e corrigir antes de prosseguir.
```

### `gh pr create`
```bash
# Executar
gh pr create --title "..." --body "..." --base main --head <branch>

# Verificar IMEDIATAMENTE
gh pr list --repo wagnerpv/agente-monorepo-template --state open
# Deve listar o PR recém-criado com número e título.
# Se não listar: o PR NÃO foi criado. Investigar e criar de novo.
```

### `gh pr reopen`
```bash
# Executar
gh pr reopen <number>

# Verificar IMEDIATAMENTE
gh pr view <number> --json state --jq '.state'
# Deve retornar "OPEN".
# Se retornar "CLOSED" ou erro: investigar.
```

### `git merge` / PR mergeado pelo TL
```bash
# Verificar que main foi atualizado
git checkout main
git pull --ff-only origin main
git log --oneline -3
# Deve mostrar o commit do merge no topo.
```

### `git branch -D` + `git push origin --delete`
```bash
# Executar
git branch -D <branch>
git push origin --delete <branch>

# Verificar IMEDIATAMENTE
git branch -r | grep <branch>
# Não deve aparecer nada.
# Se aparecer: executar `git remote prune origin` e verificar de novo.
```

### `git remote prune origin`
```bash
# Executar
git remote prune origin

# Verificar
git branch -r
# Confirmar que apenas as branches esperadas estão listadas.
# ATENÇÃO: prune remove referências locais de branches deletadas remotamente.
# NÃO deleta branches que ainda existem no remote.
```

---

## Fluxo Padrão de PR (Do Zero até Link Confirmado)

```
1. git checkout main
2. git pull --ff-only origin main
   → VERIFICAR: git log --oneline -1

3. git checkout -b <branch-name>
   → VERIFICAR: git branch --show-current

4. [fazer mudanças]

5. git add <files>
   → VERIFICAR: git status (staged files corretos)

6. git commit -m "..."
   → VERIFICAR: git log --oneline -1 (commit aparece)

7. git push origin <branch-name>
   → VERIFICAR: git log origin/<branch-name> --oneline -1

8. gh pr create --title "..." --body "..." --base main --head <branch-name>
   → CAPTURAR output completo (não só grep por URL)
   → VERIFICAR: gh pr list --state open (PR aparece com número)
   → REPORTAR: número e URL confirmados ao TL
```

---

## Fluxo Padrão Após Aprovação do TL

```
1. git checkout main
2. git pull --ff-only origin main
   → VERIFICAR: git log --oneline -1 (commit do merge aparece)

3. git branch -D <branch-name>
   → VERIFICAR: git branch (branch não aparece)

4. git push origin --delete <branch-name> (se ainda existir remotamente)
   → VERIFICAR: git branch -r | grep <branch-name> (não aparece)

5. git remote prune origin (limpar referências stale)
   → VERIFICAR: git branch -r (apenas branches esperadas)
```

---

## Padrão de Captura de Output

Nunca usar `grep` para capturar URL de PR — pode suprimir erros:

```bash
# ❌ ERRADO — suprime erros, pode retornar vazio
PR_URL=$(gh pr create ... 2>&1 | grep "https://github.com")

# ✅ CORRETO — captura output completo, verifica separadamente
gh pr create \
  --title "..." \
  --body "..." \
  --base main \
  --head <branch>

# Depois verificar:
gh pr list --repo wagnerpv/agente-monorepo-template --state open
```

---

## Quando Algo Falha

1. **Parar imediatamente** — não prosseguir com a próxima etapa
2. **Reportar ao TL** o que falhou e o estado atual
3. **Investigar** o motivo (branch não existe, token expirado, conflito, etc.)
4. **Corrigir** e verificar novamente antes de continuar

---

## Resumo das Verificações Obrigatórias

| Operação | Verificação |
|----------|-------------|
| `git push` | `git log origin/<branch> --oneline -1` |
| `gh pr create` | `gh pr list --state open` |
| `gh pr reopen` | `gh pr view <n> --json state` |
| merge pelo TL | `git pull` + `git log --oneline -1` |
| delete branch local | `git branch` |
| delete branch remote | `git branch -r \| grep <branch>` |
| prune | `git branch -r` |
