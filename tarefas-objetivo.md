# Objetivo da Sessão - Aprimoramento do Monorepo Template

## Contexto

O `agente-monorepo-template` é a base para novos projetos monorepo. Atualmente é minimalista. Objetivo: evoluir para um artefato robusto incorporando padrões, configurações e estruturas validadas em produção.

---

## Stack Canônico Definido

### Tecnologias Principais
- **Runtime:** Bun (98% dos projetos)
- **Frontend:** Astro (em transição para POC-astro00, eliminando dependência gradual)
- **Linguagem:** TypeScript (strict mode)
- **Banco de Dados:** MySQL (canônico) + SQLite (apenas exceções/sandbox)
- **HTTP Client:** Bun.fetch (nativo)

### O que NÃO é padrão
- ❌ Hono (legado ou experimento isolado)
- ❌ Astro framework em runtime (sendo eliminado)
- ❌ Node.js (legado)
- ❌ Frameworks legado (Angular, Vue, etc)

---

## Escopo da Sessão

### O QUE FAZER ✅

**Fase de Reconhecimento:**
- Explorar repositórios de referência
- Mapear artefatos de código reutilizáveis
- Documentar padrões consolidados
- Identificar estruturas de plataforma
- Catalogar packages reutilizáveis
- Descobrir configurações-padrão

**Fase de Planejamento:**
- Consolidar achados
- Organizar por categoria de artefato
- Criar planos de implementação cirúrgicos

**Fase de Implementação:**
- Implementar melhorias conforme prioridade
- Validar com testes
- Documentar decisões

### O QUE NÃO FAZER ❌

- ❌ Analisar applications específicas (não interessa)
- ❌ Incorporar knowledge bases (por enquanto)
- ❌ Implementar mudanças sem planejamento prévio
- ❌ Mexer em main sem PR
- ❌ Commits sem documentação clara

---

## Repositórios de Referência (FINAL)

| # | Repositório | Tipo | Status | Utilidade |
|---|---|---|---|---|
| 1 | POC-app00ui-astro | POC | A analisar | UI components reutilizáveis com Astro |
| 2 | POC-astro00 | POC | Analisado ✓ | SSR com Astro compiler + Bun (principal) |
| 3 | POC-basta00 | IDP/Plataforma | Analisando | Padrões de monorepo, packages, plataforma |
| 4 | POC-carteiro-service-2026 | POC | A analisar | Serviço especializado (emails/formulários) |
| 5 | POC-ssr-foundations | POC | A criar | Extraído de wip/ssr-foundations em POC-basta00 |
| 6 | box00-monorepo | Plataforma | Analisado ✓ | Primeira tentativa de plataforma (refatoração em curso) |
| 7 | brcitas | Projeto | Analisado ✓ | Monorepo full-stack (projeto, não produção) |
| 8 | cliente-tokke-agendamentos | Produção | Analisado ✓ | Cliente com padrões consolidados |
| - | backup-edge40 | Backup | Backlog | Futuro repositório de análise |

---

## Decisões de Engenharia

### Estrutura Monorepo Padrão
```
/apps         → Aplicações deployáveis
/packages     → Bibliotecas compartilhadas
/services     → Daemons/workers backend
/mcps         → Model Context Protocol servers (agentes AI)
/docs         → Documentação centralizada
/standards    → ADRs, runbooks, conventions
/operations   → Planning, task tracking, backlog
```

### Análise em Andamento

**POC-basta00 - Foco:**
- ✅ Code artifacts (não applications)
- ✅ Platform packages (estrutura reutilizável)
- ✅ Padrões consolidados (standards/, ADRs)
- ❌ Applications específicas
- ❌ Knowledge bases

**POC-ssr-foundations (a criar):**
- Extrair de `wip/ssr-foundations/` em POC-basta00
- Criar como novo repositório POC
- Integrar como referência

---

## Dinâmica de Trabalho

### Missão de Reconhecimento (ATUAL)
1. Explorar repositórios
2. Documentar artefatos
3. Mapear padrões
4. **NÃO implementar nada ainda**

### Resultado Esperado do Reconhecimento
- Inventário completo de artefatos
- Categorização por tipo
- Priorização clara
- Planos cirúrgicos por categoria

### Após Reconhecimento
1. **Planejamento:** Organizar artefatos por categoria
2. **Implementação:** Aplicar melhorias de forma disciplinada
3. **Validação:** Testes passando, documentação clara

---

## Status da Sessão

- ✅ Stack canônico documentado
- ✅ Repositórios de referência finalizados
- ✅ POC-basta00 em análise
- ⏳ Criar POC-ssr-foundations (pending)
- ⏳ Análise detalhada de artefatos (pending)
- ⏳ Reconhecimento completo (pending)
- ⏳ Planejamento de implementação (pending)

---

## Notas Importantes

- **Padrão de nomes:** Será padronizado após reconhecimento
- **Contexto é crítico:** Todas as decisões serão baseadas em análise profunda
- **Cirurgicidade:** Implementações serão precisas, não especulativas
- **Documentação:** Cada mudança será documentada explicando o quê, por quê, e como

---

## Objetivo Macro do Template

O `agente-monorepo-template` não é um exercício técnico. É a fundação que vai permitir a BOX00 entrar em operação com seus produtos e migrar os legados existentes.

### Ordem de Prioridade dos Consumidores

**Prioridade 1 — brcitas**
Primeiro produto a entrar em operação usando o template como base. Define o template na prática.

**Prioridade 2 — bitbox00**
Segundo produto a entrar em operação. Valida o template como plataforma reutilizável.

**Prioridade 3 — cliente-tokke-agendamentos**
Migração do sistema de agendamentos do stack legado para o template padrão. O template tem que ser capaz de atender os requisitos deste sistema em produção.

**Prioridade 4 — carteiro**
Migração do serviço de email do repositório legado para o template padrão. Ao concluir, o repositório legado é descomissionado e o serviço assume produção no novo stack.

### Implicação para o Template

O template não pode ser genérico demais. Ele precisa ser validado contra os requisitos reais desses quatro consumidores — especialmente brcitas (prioridade 1) e tokke (já em produção com requisitos conhecidos).

O `box00-monorepo` contém funcionalidades únicas que precisam ser trazidas para o template antes que tokke possa migrar.
