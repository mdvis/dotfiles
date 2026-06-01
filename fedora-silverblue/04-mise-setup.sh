#!/bin/bash
# 04-mise-setup.sh
# Mise 运行时管理器配置脚本

set -e

echo "================================================"
echo "Fedora Silverblue - Mise 配置"
echo "================================================"
echo ""

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 检查 mise 是否已安装
if command -v mise &> /dev/null; then
    echo -e "${GREEN}✓${NC} Mise 已安装"
    mise --version
else
    echo -e "${BLUE}📥 安装 Mise...${NC}"
    curl https://mise.run | sh
    
    # 添加到 shell 配置
    if [[ -f ~/.zshrc ]]; then
        if ! grep -q 'mise activate' ~/.zshrc; then
            echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
        fi
    fi
    
    if [[ -f ~/.bashrc ]]; then
        if ! grep -q 'mise activate' ~/.bashrc; then
            echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
        fi
    fi
    
    export PATH="$HOME/.local/bin:$PATH"
fi

echo ""
echo -e "${BLUE}📦 配置运行时版本...${NC}"
echo ""

# Node.js
read -p "安装 Node.js LTS? (Y/n): " install_node
if [[ ! $install_node =~ ^[Nn]$ ]]; then
    echo -e "${BLUE}安装 Node.js LTS...${NC}"
    ~/.local/bin/mise use -g node@lts
fi

# Python
read -p "安装 Python 最新版? (Y/n): " install_python
if [[ ! $install_python =~ ^[Nn]$ ]]; then
    echo -e "${BLUE}安装 Python...${NC}"
    ~/.local/bin/mise use -g python@latest
fi

# Go
read -p "安装 Go 最新版? (Y/n): " install_go
if [[ ! $install_go =~ ^[Nn]$ ]]; then
    echo -e "${BLUE}安装 Go...${NC}"
    ~/.local/bin/mise use -g go@latest
fi

# Rust
read -p "安装 Rust 最新版? (Y/n): " install_rust
if [[ ! $install_rust =~ ^[Nn]$ ]]; then
    echo -e "${BLUE}安装 Rust...${NC}"
    ~/.local/bin/mise use -g rust@latest
fi

# Java
read -p "安装 Java (OpenJDK)? (y/N): " install_java
if [[ $install_java =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}安装 Java...${NC}"
    ~/.local/bin/mise use -g java@openjdk
fi

echo ""
echo -e "${GREEN}✅ Mise 配置完成!${NC}"
echo ""
echo "已安装的运行时:"
~/.local/bin/mise list
echo ""
echo "提示: 重新打开终端或运行 'source ~/.zshrc' 以激活 mise"
echo ""
echo "下一步: ./05-post-install.sh"
