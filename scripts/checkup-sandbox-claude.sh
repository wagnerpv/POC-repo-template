#!/usr/bin/env bash
# checkup-sandbox-claude.sh - Checkup do sandbox Claude
# Verifica ferramentas obrigatórias, instala se faltarem, configura git

set -euo pipefail

BOLD='\033[1m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BOLD}${CYAN}╔════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║  Checkup Sandbox Claude${NC}"
echo -e "${CYAN}║  $(date +'%Y-%m-%d %H:%M:%S')${NC}"
echo -e "${BOLD}${CYAN}╚════════════════════════════════════════╝${NC}\n"

# Verificar ferramentas
echo -e "${BOLD}Verificando ferramentas...${NC}"
TOOLS=("curl" "git" "rsync" "jq")
MISSING=()

for tool in "${TOOLS[@]}"; do
  if command -v "$tool" &> /dev/null; then
    echo -e "${GREEN}✓${NC} $tool"
  else
    echo -e "${RED}✗${NC} $tool"
    MISSING+=("$tool")
  fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
  echo -e "\n${BOLD}Instalando ferramentas faltantes...${NC}"
  apt-get update -qq && apt-get install -y "${MISSING[@]}" 2>&1 | grep "^Setting" || true
fi

# Configurar git
echo -e "\n${BOLD}Configurando git...${NC}"
git config --global user.name "haiku-git-agent"
git config --global user.email "wagnerpv@box00.com"
echo -e "${GREEN}✓${NC} Git configurado"

# Verificação final
echo -e "\n${BOLD}${GREEN}✓ Checkup Completo${NC}"
echo -e "${GREEN}Sandbox pronto para operações${NC}\n"
