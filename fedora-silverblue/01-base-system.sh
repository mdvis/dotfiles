#!/bin/bash
# 01-base-system.sh
# 基础系统层安装脚本 - 使用 rpm-ostree 安装核心系统工具

set -e

echo "================================================"
echo "Fedora Silverblue - 基础系统层安装"
echo "================================================"
echo ""
echo "⚠️  警告: rpm-ostree 安装后需要重启系统才能生效"
echo ""

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查是否是 rpm-ostree 系统
if ! command -v rpm-ostree &> /dev/null; then
    echo "❌ 错误: 这不是一个 rpm-ostree 系统"
    exit 1
fi

echo -e "${BLUE}📦 准备安装基础系统包...${NC}"
echo ""

# 核心命令行工具
CORE_CLI_TOOLS=(
    btop
    curl
    fd-find
    fzf
    git
    git-lfs
    gnupg2
    jq
    ripgrep
    tmux
    vim-enhanced
    zsh
    zoxide
    starship
    the_silver_searcher
    tree
    htop
    wget
    unzip
    zip
)

# Sway 桌面环境 (如果使用 Sway)
SWAY_PACKAGES=(
    sway
    swaylock
    swayidle
    swaybg
    waybar
    mako
    rofi-wayland
    wofi
    foot
    grim
    slurp
    wl-clipboard
    kanshi
    gammastep
    brightnessctl
    blueman
    pavucontrol
    pipewire
    pipewire-pulseaudio
    wireplumber
    imv
    swappy
)

# 网络和系统工具
SYSTEM_TOOLS=(
    NetworkManager
    NetworkManager-wifi
    network-manager-applet
    smartmontools
    lm_sensors
    powertop
    tlp
    tlp-rdw
)

# 输入法 (Fcitx5)
INPUT_METHOD=(
    fcitx5
    fcitx5-chinese-addons
    fcitx5-configtool
    fcitx5-gtk
    fcitx5-qt
)

# 多媒体编解码器
MULTIMEDIA=(
    ffmpeg
    ffmpegthumbnailer
    ImageMagick
    poppler-utils
)

# 文件系统工具
FILESYSTEM=(
    e2fsprogs
    exfat-utils
    fuse
    fuse-sshfs
    ntfs-3g
)

# 安全工具
SECURITY=(
    clamav
    clamav-update
)

# 合并所有包
ALL_PACKAGES=(
    "${CORE_CLI_TOOLS[@]}"
    "${SYSTEM_TOOLS[@]}"
    "${MULTIMEDIA[@]}"
    "${FILESYSTEM[@]}"
)

# 询问是否安装 Sway
read -p "是否安装 Sway 桌面环境? (y/N): " install_sway
if [[ $install_sway =~ ^[Yy]$ ]]; then
    ALL_PACKAGES+=("${SWAY_PACKAGES[@]}")
fi

# 询问是否安装输入法
read -p "是否安装 Fcitx5 输入法? (y/N): " install_fcitx
if [[ $install_fcitx =~ ^[Yy]$ ]]; then
    ALL_PACKAGES+=("${INPUT_METHOD[@]}")
fi

# 询问是否安装安全工具
read -p "是否安装 ClamAV 杀毒软件? (y/N): " install_security
if [[ $install_security =~ ^[Yy]$ ]]; then
    ALL_PACKAGES+=("${SECURITY[@]}")
fi

echo ""
echo -e "${YELLOW}将要安装以下包:${NC}"
printf '%s\n' "${ALL_PACKAGES[@]}" | column
echo ""
echo "总计: ${#ALL_PACKAGES[@]} 个包"
echo ""

read -p "确认安装? (y/N): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "取消安装"
    exit 0
fi

echo ""
echo -e "${BLUE}🚀 开始安装...${NC}"
echo ""

# 执行安装
sudo rpm-ostree install "${ALL_PACKAGES[@]}"

echo ""
echo -e "${GREEN}✅ 基础系统包安装完成!${NC}"
echo ""
echo -e "${YELLOW}⚠️  重要: 请重启系统以应用更改${NC}"
echo ""
echo "重启命令: sudo systemctl reboot"
echo ""
echo "重启后请运行: ./02-flatpak-apps.sh"
