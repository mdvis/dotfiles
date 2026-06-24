#!/usr/bin/env bash
# 将 Agents 文件夹内容软链接到各个 AI 工具的配置目录

set -euo pipefail

# 源目录
SOURCE_DIR="$HOME/.dotfiles/agents"

# 定义目标工具及其配置目录（统一使用 ~/.工具名 的格式）
declare -A TOOLS=(
    ["claude"]="$HOME/.claude"
    ["pi"]="$HOME/.pi/agent"
    ["codex"]="$HOME/.codex"
    ["workbuddy"]="$HOME/.workbuddy"
    ["opencode"]="$HOME/.opencode"
    ["codebuddy"]="$HOME/.codebuddy"
    ["hermes"]="$HOME/.hermes"
)

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 创建单个软链接
create_single_symlink() {
    local source_path=$1
    local link_path=$2
    local item_name=$3

    # 如果链接已存在
    if [ -L "$link_path" ]; then
        local current_target=$(readlink "$link_path")
        if [ "$current_target" = "$source_path" ]; then
            log_info "    ✓ $item_name 已正确链接"
        else
            log_warn "    ⚠ $item_name 已存在但指向不同位置: $current_target"
            read -p "      是否替换? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm "$link_path"
                ln -s "$source_path" "$link_path"
                log_info "    ✓ 已更新 $item_name"
            fi
        fi
    # 如果是真实文件或目录
    elif [ -e "$link_path" ]; then
        log_warn "    ⚠ $item_name 已存在（非软链接）"
        read -p "      是否备份并替换为软链接? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mv "$link_path" "${link_path}.backup.$(date +%Y%m%d_%H%M%S)"
            ln -s "$source_path" "$link_path"
            log_info "    ✓ 已备份原文件并创建软链接 $item_name"
        fi
    # 创建新的软链接
    else
        ln -s "$source_path" "$link_path"
        log_info "    ✓ 已创建软链接 $item_name"
    fi
}

# 创建软链接函数
create_symlinks() {
    local tool_name=$1
    local target_dir=$2

    log_info "处理工具: $tool_name"

    # 检查目标目录是否存在，不存在则创建
    if [ ! -d "$target_dir" ]; then
        log_warn "目标目录不存在，正在创建: $target_dir"
        mkdir -p "$target_dir"
    fi

    # 遍历源目录中的顶级目录 (agents, hooks, skills)
    for category_dir in "$SOURCE_DIR"/*; do
        # 跳过 .DS_Store 等隐藏文件和普通文件
        if [[ "$(basename "$category_dir")" == .* ]] || [ ! -d "$category_dir" ]; then
            continue
        fi

        local category_name=$(basename "$category_dir")
        local target_category_dir="$target_dir/$category_name"

        log_info "  处理分类: $category_name"

        # 确保目标分类目录存在
        mkdir -p "$target_category_dir"

        # 遍历分类目录下的所有项目
        for item in "$category_dir"/*; do
            # 跳过 .DS_Store 等隐藏文件
            if [[ "$(basename "$item")" == .* ]]; then
                continue
            fi

            local item_name=$(basename "$item")
            local link_path="$target_category_dir/$item_name"

            # 创建软链接
            create_single_symlink "$item" "$link_path" "$category_name/$item_name"
        done
    done

    echo
}

# 显示使用说明
show_usage() {
    echo "用法: $0 [选项] [工具名称...]"
    echo
    echo "选项:"
    echo "  -h, --help     显示此帮助信息"
    echo "  -l, --list     列出所有支持的工具"
    echo "  -a, --all      为所有工具创建软链接"
    echo
    echo "工具名称:"
    echo "  如果不指定工具名称，脚本会交互式询问"
    echo "  可用的工具: ${!TOOLS[@]}"
    echo
    echo "示例:"
    echo "  $0 --all                    # 为所有工具创建软链接"
    echo "  $0 claude codex             # 仅为 claude 和 codex 创建软链接"
    echo "  $0                          # 交互式模式"
}

# 列出所有工具
list_tools() {
    echo "支持的工具及其配置目录:"
    echo
    for tool in "${!TOOLS[@]}"; do
        echo "  $tool -> ${TOOLS[$tool]}"
    done
}

# 主函数
main() {
    # 检查源目录是否存在
    if [ ! -d "$SOURCE_DIR" ]; then
        log_error "源目录不存在: $SOURCE_DIR"
        exit 1
    fi

    log_info "源目录: $SOURCE_DIR"
    echo

    # 解析命令行参数
    if [ $# -eq 0 ]; then
        # 交互式模式
        echo "请选择要配置的工具 (空格分隔，或输入 'all' 选择全部):"
        list_tools
        echo
        read -p "请输入工具名称: " -r

        if [ -z "$REPLY" ]; then
            log_error "未选择任何工具"
            exit 1
        fi

        if [[ "$REPLY" == "all" ]]; then
            for tool in "${!TOOLS[@]}"; do
                create_symlinks "$tool" "${TOOLS[$tool]}"
            done
        else
            for tool in $REPLY; do
                if [ -n "${TOOLS[$tool]:-}" ]; then
                    create_symlinks "$tool" "${TOOLS[$tool]}"
                else
                    log_error "未知工具: $tool"
                fi
            done
        fi
    else
        # 命令行参数模式
        case "$1" in
        -h | --help)
            show_usage
            exit 0
            ;;
        -l | --list)
            list_tools
            exit 0
            ;;
        -a | --all)
            for tool in "${!TOOLS[@]}"; do
                create_symlinks "$tool" "${TOOLS[$tool]}"
            done
            ;;
        *)
            for tool in "$@"; do
                if [ -n "${TOOLS[$tool]:-}" ]; then
                    create_symlinks "$tool" "${TOOLS[$tool]}"
                else
                    log_error "未知工具: $tool"
                    echo "使用 --list 查看支持的工具"
                    exit 1
                fi
            done
            ;;
        esac
    fi

    log_info "完成！"
}

main "$@"
