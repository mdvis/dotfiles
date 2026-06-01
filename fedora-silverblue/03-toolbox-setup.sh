#!/bin/bash
# 03-toolbox-setup.sh
# Toolbox 容器创建和配置脚本

set -e

echo "================================================"
echo "Fedora Silverblue - Toolbox 容器配置"
echo "================================================"
echo ""

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/toolbox-configs"

# 检查 toolbox
if ! command -v toolbox &> /dev/null; then
    echo "❌ 错误: Toolbox 未安装"
    echo "安装命令: sudo rpm-ostree install toolbox"
    exit 1
fi

# 创建容器的函数
create_toolbox() {
    local name=$1
    local description=$2
    
    echo ""
    echo -e "${BLUE}📦 创建容器: $name${NC}"
    echo "描述: $description"
    
    if toolbox list | grep -q "$name"; then
        echo "⚠️  容器 $name 已存在，跳过创建"
        read -p "是否删除并重新创建? (y/N): " recreate
        if [[ $recreate =~ ^[Yy]$ ]]; then
            toolbox rm -f "$name"
            toolbox create -c "$name"
        fi
    else
        toolbox create -c "$name"
    fi
}

# 在容器中安装包的函数
install_in_toolbox() {
    local container=$1
    local package_file=$2
    
    if [[ ! -f "$package_file" ]]; then
        echo "⚠️  包列表文件不存在: $package_file"
        return
    fi
    
    echo -e "${BLUE}📥 在容器 $container 中安装包...${NC}"
    
    # 读取包列表（忽略注释和空行）
    local packages=$(grep -v '^#' "$package_file" | grep -v '^$' | tr '\n' ' ')
    
    if [[ -z "$packages" ]]; then
        echo "⚠️  没有要安装的包"
        return
    fi
    
    echo "包列表: $packages"
    
    # 在容器中安装
    toolbox run -c "$container" sudo dnf install -y $packages
}

# 主菜单
echo "请选择要创建的容器:"
echo ""
echo "1) dev        - 通用开发容器 (编辑器、代码工具、语言工具)"
echo "2) containers - 容器管理容器 (Docker、Podman、K8s)"
echo "3) cloud      - 云工具容器 (Terraform、云 CLI)"
echo "4) security   - 安全工具容器 (扫描、渗透测试)"
echo "5) all        - 创建所有容器"
echo "6) custom     - 自定义容器"
echo ""

read -p "选择 (1-6): " choice

case $choice in
    1)
        create_toolbox "dev" "通用开发容器"
        install_in_toolbox "dev" "$CONFIG_DIR/dev-packages.txt"
        ;;
    2)
        create_toolbox "containers" "容器管理容器"
        install_in_toolbox "containers" "$CONFIG_DIR/container-packages.txt"
        ;;
    3)
        create_toolbox "cloud" "云工具容器"
        install_in_toolbox "cloud" "$CONFIG_DIR/cloud-packages.txt"
        ;;
    4)
        create_toolbox "security" "安全工具容器"
        install_in_toolbox "security" "$CONFIG_DIR/security-packages.txt"
        ;;
    5)
        create_toolbox "dev" "通用开发容器"
        install_in_toolbox "dev" "$CONFIG_DIR/dev-packages.txt"
        
        create_toolbox "containers" "容器管理容器"
        install_in_toolbox "containers" "$CONFIG_DIR/container-packages.txt"
        
        create_toolbox "cloud" "云工具容器"
        install_in_toolbox "cloud" "$CONFIG_DIR/cloud-packages.txt"
        
        create_toolbox "security" "安全工具容器"
        install_in_toolbox "security" "$CONFIG_DIR/security-packages.txt"
        ;;
    6)
        read -p "容器名称: " custom_name
        read -p "容器描述: " custom_desc
        create_toolbox "$custom_name" "$custom_desc"
        echo "容器已创建，请手动安装所需的包"
        echo "命令: toolbox run -c $custom_name sudo dnf install <packages>"
        ;;
    *)
        echo "无效选择"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}✅ Toolbox 容器配置完成!${NC}"
echo ""
echo "使用方法:"
echo "  进入容器: toolbox enter <name>"
echo "  在容器中执行命令: toolbox run -c <name> <command>"
echo "  列出所有容器: toolbox list"
echo ""
echo "示例:"
echo "  toolbox enter dev"
echo "  toolbox run -c dev nvim"
echo ""
echo "下一步: ./04-mise-setup.sh"
