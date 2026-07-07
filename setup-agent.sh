#!/usr/bin/env bash
# AI Agent Code Tools 一键安装脚本
set -euo pipefail

GREEN='\033[0;32m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

echo -e "${BOLD}🤖 安装 AI Agent Code Tools${RESET}"
echo ""

install_tool() {
    local name="$1" url="$2" shell="${3:-bash}"
    echo -n "  ➜ ${name} ... "
    if curl -fsSL "$url" | $shell >/dev/null 2>&1; then
        echo -e "${GREEN}✔${RESET}"
    else
        echo -e "${RED}✘ 失败${RESET}"
    fi
}

install_tool "Pi Agent" "https://pi.dev/install.sh" sh
install_tool "OpenCode" "https://opencode.ai/install" bash
install_tool "Claude Code" "https://claude.ai/install.sh" bash
install_tool "Hermes Agent" "https://hermes-agent.nousresearch.com/install.sh" bash
install_tool "Antigravity CLI" "https://antigravity.google/cli/install.sh" bash
install_tool "Codex CLI" "https://chatgpt.com/codex/install.sh" sh
install_tool "OpenClaw" "https://openclaw.ai/install.sh" bash

echo ""
echo -e "${GREEN}${BOLD}完成!${RESET}"
