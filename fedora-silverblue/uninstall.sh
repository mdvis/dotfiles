#!/bin/bash
# uninstall.sh
# 卸载脚本 - 移除通过脚本安装的组件

set -e

RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "================================================"
echo "Fedora Silverblue 卸载脚本"
echo "================================================"
echo ""
echo -e "${RED}⚠️  警告: 这将移除通过安装脚本添加的组件${NC}"
echo ""

# 菜单
echo "请选择要卸载的组件:"
echo ""
echo "1) 移除 rpm-ostree 安装的包"
echo "2) 移除所有 Flatpak 应用"
echo "3) 删除所有 Toolbox 容器"
echo "4) 移除 Mise 和运行时"
echo "5) 全部移除"
echo "6) 取消"
echo ""

read -p "选择 (1-6): " choice

case $choice in
    1)
        echo -e "${BLUE}列出 rpm-ostree 安装的包...${NC}"
        rpm-ostree status
        echo ""
        read -p "输入要移除的包 (空格分隔): " packages
        if [[ -n "$packages" ]]; then
            sudo rpm-ostree uninstall $packages
            echo "需要重启以应用更改"
        fi
        ;;
    2)
        echo -e "${BLUE}列出已安装的 Flatpak 应用...${NC}"
        flatpak list --app
        echo ""
        read -p "确认移除所有 Flatpak 应用? (yes/N): " confirm
        if [[ "$confirm" == "yes" ]]; then
            flatpak uninstall --all -y
        fi
        ;;
    3)
        echo -e "${BLUE}列出 Toolbox 容器...${NC}"
        toolbox list
        echo ""
        read -p "确认删除所有容器? (yes/N): " confirm
        if [[ "$confirm" == "yes" ]]; then
            for container in $(toolbox list -c | tail -n +2 | awk '{print $2}'); do
                toolbox rm -f "$container"
            done
        fi
        ;;
    4)
        echo -e "${BLUE}移除 Mise...${NC}"
        read -p "确认移除 Mise 和所有运行时? (yes/N): " confirm
        if [[ "$confirm" == "yes" ]]; then
            rm -rf ~/.local/share/mise
            rm -rf ~/.local/bin/mise
            rm -rf ~/.cache/mise
            sed -i '/mise activate/d' ~/.zshrc 2>/dev/null || true
            sed -i '/mise activate/d' ~/.bashrc 2>/dev/null || true
        fi
        ;;
    5)
        echo -e "${RED}确认移除所有组件? (输入 'yes' 确认): ${NC}"
        read confirm
        if [[ "$confirm" == "yes" ]]; then
            # 移除 Flatpak
            flatpak uninstall --all -y || true
            
            # 删除 Toolbox
            for container in $(toolbox list -c | tail -n +2 | awk '{print $2}'); do
                toolbox rm -f "$container"
            done
            
            # 移除 Mise
            rm -rf ~/.local/share/mise
            rm -rf ~/.local/bin/mise
            rm -rf ~/.cache/mise
            
            echo ""
            echo "rpm-ostree 包需要手动移除"
            echo "查看已安装的包: rpm-ostree status"
        fi
        ;;
    6)
        echo "取消"
        exit 0
        ;;
    *)
        echo "无效选择"
        exit 1
        ;;
esac

echo ""
echo -e "${BLUE}完成${NC}"
