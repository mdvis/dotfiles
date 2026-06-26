#!/bin/bash
# install-all.sh
# 一键安装所有配置的主脚本

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "================================================"
echo "Fedora Silverblue 完整配置脚本"
echo "================================================"
echo ""
echo "这个脚本将按顺序执行以下步骤:"
echo ""
echo "1. 基础系统层安装 (rpm-ostree)"
echo "2. Flatpak 应用安装"
echo "3. Toolbox 容器配置"
echo "4. Mise 运行时管理器配置"
echo "5. 后续配置和优化"
echo ""
echo -e "${YELLOW}⚠️  注意: 基础系统安装后需要重启${NC}"
echo ""

read -p "是否继续? (y/N): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "取消安装"
    exit 0
fi

# 检查是否是继续安装
if [[ "$1" == "--continue" ]]; then
    continue_install
fi

# 步骤 1: 基础系统
echo ""
echo -e "${BLUE}=== 步骤 1/5: 基础系统层安装 ===${NC}"
bash "$SCRIPT_DIR/01-base-system.sh"

echo ""
echo -e "${YELLOW}⚠️  基础系统安装完成，需要重启系统${NC}"
echo ""
read -p "现在重启? (y/N): " reboot_now
if [[ $reboot_now =~ ^[Yy]$ ]]; then
    echo "重启后请运行: $SCRIPT_DIR/install-all.sh --continue"
    sudo systemctl reboot
    exit 0
fi

echo ""
echo "请手动重启系统，然后运行:"
echo "  $SCRIPT_DIR/install-all.sh --continue"
exit 0

# 继续安装的函数
continue_install() {
    echo ""
    echo -e "${BLUE}=== 继续安装 ===${NC}"
    echo ""

    # 步骤 2: Flatpak
    echo -e "${BLUE}=== 步骤 2/5: Flatpak 应用安装 ===${NC}"
    bash "$SCRIPT_DIR/02-flatpak-apps.sh"

    # 步骤 3: Toolbox
    echo ""
    echo -e "${BLUE}=== 步骤 3/5: Toolbox 容器配置 ===${NC}"
    bash "$SCRIPT_DIR/03-toolbox-setup.sh"

    # 步骤 4: Mise
    echo ""
    echo -e "${BLUE}=== 步骤 4/5: Mise 配置 ===${NC}"
    bash "$SCRIPT_DIR/04-mise-setup.sh"

    # 步骤 5: 后续配置
    echo ""
    echo -e "${BLUE}=== 步骤 5/5: 后续配置 ===${NC}"
    bash "$SCRIPT_DIR/05-post-install.sh"

    echo ""
    echo -e "${GREEN}🎉 所有安装步骤完成!${NC}"
    echo ""
}
