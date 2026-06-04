# tarefas

## usage

Este arquivo é o ledger vivo de trabalho do repositório e deve ser mantido atualizado durante toda sessão ativa.

Como usar:

- Manter este arquivo na raiz do repositório.
- Usar este arquivo tanto para trabalho ad hoc quanto para trabalho guiado por issues.
- Atualizar este arquivo sempre que o escopo mudar ou uma tarefa for concluída.
- Atualizar este arquivo antes ou junto de cada commit/push atômico quando houver mudança de estado das tarefas.
- Usar este arquivo como fonte local rápida de verdade para progresso da sessão.
- Quando existirem issues, citar os números no texto das tarefas.
- Itens concluídos devem continuar visíveis e marcados como concluídos.
- Itens pendentes devem ser explícitos, pequenos e acionáveis.

Fluxo recomendado:

1. Identificar o item ativo de trabalho.
2. Quebrar o trabalho em tarefas concretas neste arquivo.
3. Executar uma mudança pequena por vez.
4. Atualizar este arquivo para refletir o progresso.
5. Criar um commit e push atômicos.
6. Repetir até concluir o trabalho.

## pendentes

Nenhuma pendência registrada ao encerrar o dia.

## sessao_atual

- [x] Preparado e validado o bootstrap de sessão privada para trabalho com GitHub no sandbox.
- [x] Consolidado o prompt oficial de bootstrap em `private-git-session-bootstrap-prompt.md`.
- [x] Definido `WORKSPACE_PATH` fixo como `~/repos`.
- [x] Tornado explícito o bloco inicial de variáveis de sessão com defaults e placeholders.
- [x] Renomeados os campos de identidade para `GIT_SESSION_USER_NAME` e `GIT_SESSION_USER_EMAIL`.
- [x] Definido que novos repositórios devem nascer do template remoto `WagnerPV/agente-monorepo-template`.
- [x] Adicionado `new-repository-from-template-flow.md` com o fluxo operacional de criação de novos repositórios a partir do template remoto atualizado.
- [x] Documentada a regra de nunca solicitar ao humano execução de comandos operacionais.
- [x] Documentada a regra de sempre fazer pull antes de alterar branch existente, especialmente `main`.
- [x] Documentado o fluxo padrão de branch, commit, push, PR, merge e tratamento de branches obsoletas.
- [x] Documentados os papéis da sessão: agente como software engineer executor e humano como tech lead revisor/orientador.
- [x] Validado commit, push e merge do fluxo atualizado no repositório `agente-git-sandbox`.
- [x] Reinstalado e validado o GitHub CLI (`gh`) localmente no sandbox.
- [x] Renomeado o ledger de sessão de `tasks.md` para `tarefas.md`.
- [x] Atualizado o conteúdo do ledger para refletir o encerramento do dia sem pendências abertas.

## sessao_anterior

- [x] Estruturado o repositório inicial de sandbox e o material base do fluxo de trabalho.
