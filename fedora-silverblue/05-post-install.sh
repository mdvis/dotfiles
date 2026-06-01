#!/bin/bash
# 05-post-install.sh
# 后续配置和优化脚本

set -e

echo "================================================"
echo "Fedora Silverblue - 后续配置"
echo "================================================"
echo ""

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 配置 Git
echo -e "${BLUE}📝 配置 Git...${NC}"
read -p "配置 Git 用户信息? (Y/n): " config_git
if [[ ! $config_git =~ ^[Nn]$ ]]; then
    read -p "Git 用户名: " git_name
    read -p "Git 邮箱: " git_email
    
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    git config --global pull.rebase false
    
    echo -e "${GREEN}✓${NC} Git 配置完成"
fi

# 配置 SSH
echo ""
echo -e "${BLUE}🔑 配置 SSH...${NC}"
if [[ ! -f ~/.ssh/id_ed25519 ]]; then
    read -p "生成 SSH 密钥? (Y/n): " gen_ssh
    if [[ ! $gen_ssh =~ ^[Nn]$ ]]; then
        read -p "SSH 密钥邮箱: " ssh_email
        ssh-keygen -t ed25519 -C "$ssh_email"
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_ed25519
        echo -e "${GREEN}✓${NC} SSH 密钥已生成"
        echo ""
        echo "公钥内容:"
        cat ~/.ssh/id_ed25519.pub
    fi
else
    echo -e "${GREEN}✓${NC} SSH 密钥已存在"
fi

# 配置 Zsh
echo ""
echo -e "${BLUE}🐚 配置 Zsh...${NC}"
if command -v zsh &> /dev/null; then
    if [[ "$SHELL" != *"zsh"* ]]; then
        read -p "设置 Zsh 为默认 Shell? (Y/n): " set_zsh
        if [[ ! $set_zsh =~ ^[Nn]$ ]]; then
            chsh -s $(which zsh)
            echo -e "${GREEN}✓${NC} Zsh 已设置为默认 Shell"
        fi
    else
        echo -e "${GREEN}✓${NC} Zsh 已是默认 Shell"
    fi
fi

# 配置 Fcitx5
echo ""
echo -e "${BLUE}⌨️  配置 Fcitx5 输入法...${NC}"
if rpm-ostree status | grep -q fcitx5; then
    read -p "配置 Fcitx5 环境变量? (Y/n): " config_fcitx
    if [[ ! $config_fcitx =~ ^[Nn]$ ]]; then
        cat >> ~/.bashrc << 'EOF'

# Fcitx5
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
EOF
        
        if [[ -f ~/.zshrc ]]; then
            cat >> ~/.zshrc << 'EOF'

# Fcitx5
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
EOF
        fi
        
        echo -e "${GREEN}✓${NC} Fcitx5 环境变量已配置"
    fi
fi

# 优化系统设置
echo ""
echo -e "${BLUE}⚙️  系统优化...${NC}"
read -p "应用系统优化设置? (Y/n): " optimize
if [[ ! $optimize =~ ^[Nn]$ ]]; then
    # 增加 inotify 限制
    echo "fs.inotify.max_user_watches=524288" | sudo tee /etc/sysctl.d/99-inotify.conf
    sudo sysctl -p /etc/sysctl.d/99-inotify.conf
    
    echo -e "${GREEN}✓${NC} 系统优化完成"
fi

# 配置 Flatpak 权限
echo ""
echo -e "${BLUE}🔒 Flatpak 权限管理...${NC}"
if flatpak list | grep -q Flatseal; then
    echo "提示: 使用 Flatseal 管理 Flatpak 应用权限"
    echo "命令: flatpak run com.github.tchx84.Flatseal"
else
    read -p "安装 Flatseal (Flatpak 权限管理器)? (Y/n): " install_flatseal
    if [[ ! $install_flatseal =~ ^[Nn]$ ]]; then
        flatpak install -y flathub com.github.tchx84.Flatseal
    fi
fi

echo ""
echo -e "${GREEN}✅ 所有配置完成!${NC}"
echo ""
echo "建议的后续步骤:"
echo "1. 重启系统以应用所有更改"
echo "2. 配置 Fcitx5 输入法 (fcitx5-configtool)"
echo "3. 使用 Flatseal 调整 Flatpak 应用权限"
echo "4. 进入 toolbox 容器开始开发: toolbox enter dev"
echo ""
