#!/bin/bash
# 02-flatpak-apps.sh
# Flatpak 应用安装脚本

set -e

echo "================================================"
echo "Fedora Silverblue - Flatpak 应用安装"
echo "================================================"
echo ""

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 检查 Flatpak
if ! command -v flatpak &> /dev/null; then
    echo "❌ 错误: Flatpak 未安装"
    exit 1
fi

echo -e "${BLUE}📦 配置 Flathub 仓库...${NC}"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# 添加 Flathub Beta (可选)
read -p "是否添加 Flathub Beta 仓库? (y/N): " add_beta
if [[ $add_beta =~ ^[Yy]$ ]]; then
    flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
fi

echo ""
echo -e "${BLUE}📱 准备安装 Flatpak 应用...${NC}"
echo ""

# 开发工具
DEV_APPS=(
    "com.visualstudio.code|Visual Studio Code"
    "com.vscodium.codium|VSCodium (开源版)"
    "md.obsidian.Obsidian|Obsidian"
    "com.jetbrains.IntelliJ-IDEA-Community|IntelliJ IDEA CE"
)

# 浏览器
BROWSERS=(
    "com.google.Chrome|Google Chrome"
    "org.mozilla.firefox|Firefox"
    "org.chromium.Chromium|Chromium"
)

# 办公和文档
OFFICE_APPS=(
    "org.libreoffice.LibreOffice|LibreOffice"
    "com.calibre_ebook.calibre|Calibre"
    "com.github.johnfactotum.Foliate|Foliate (电子书)"
    "org.gnome.Evince|Evince (PDF)"
)

# 图形设计
GRAPHICS_APPS=(
    "org.gimp.GIMP|GIMP"
    "org.blender.Blender|Blender"
    "org.inkscape.Inkscape|Inkscape"
    "com.jgraph.drawio.desktop|Draw.io"
    "org.kde.krita|Krita"
)

# 媒体工具
MEDIA_APPS=(
    "io.mpv.Mpv|MPV"
    "org.videolan.VLC|VLC"
    "com.github.huluti.Curtail|Curtail (图片压缩)"
    "org.gnome.Shotwell|Shotwell (照片管理)"
    "fr.handbrake.ghb|HandBrake (视频转码)"
)

# 文件管理
FILE_APPS=(
    "org.gnome.Nautilus|Nautilus"
    "org.kde.dolphin|Dolphin"
    "io.github.peazip.PeaZip|PeaZip"
    "org.gnome.FileRoller|File Roller (归档管理)"
)

# 通讯工具
COMMUNICATION_APPS=(
    "org.telegram.desktop|Telegram"
    "org.mozilla.Thunderbird|Thunderbird"
    "com.discordapp.Discord|Discord"
    "us.zoom.Zoom|Zoom"
)

# 系统工具
SYSTEM_APPS=(
    "org.keepassxc.KeePassXC|KeePassXC"
    "com.github.tchx84.Flatseal|Flatseal (权限管理)"
    "io.github.flattool.Warehouse|Warehouse (Flatpak 管理)"
    "org.gnome.baobab|Baobab (磁盘使用分析)"
    "org.remmina.Remmina|Remmina (远程桌面)"
    "org.filezillaproject.Filezilla|FileZilla"
)

# 下载工具
DOWNLOAD_APPS=(
    "org.qbittorrent.qBittorrent|qBittorrent"
    "de.haeckerfelix.Fragments|Fragments (BT 下载)"
)

# 数据库工具
DATABASE_APPS=(
    "io.dbeaver.DBeaverCommunity|DBeaver"
)

# Git GUI
GIT_APPS=(
    "io.github.mightycreak.Diffuse|Diffuse (Diff 工具)"
    "com.github.maoschanz.drawing|Drawing"
)

# 其他工具
OTHER_APPS=(
    "org.localsend.localsend_app|LocalSend"
    "org.syncthing.SyncthingGTK|Syncthing GTK"
    "com.github.IsmaelMartinez.teams_for_linux|Teams for Linux"
)

# 函数: 显示应用列表并询问安装
install_category() {
    local category_name=$1
    shift
    local apps=("$@")
    
    echo ""
    echo -e "${YELLOW}=== $category_name ===${NC}"
    
    for app_info in "${apps[@]}"; do
        IFS='|' read -r app_id app_name <<< "$app_info"
        echo "  - $app_name ($app_id)"
    done
    
    echo ""
    read -p "安装 $category_name? (Y/n): " install_cat
    
    if [[ ! $install_cat =~ ^[Nn]$ ]]; then
        for app_info in "${apps[@]}"; do
            IFS='|' read -r app_id app_name <<< "$app_info"
            echo -e "${BLUE}安装: $app_name${NC}"
            flatpak install -y flathub "$app_id" || echo "⚠️  $app_name 安装失败，跳过"
        done
    fi
}

# 安装各类应用
install_category "开发工具" "${DEV_APPS[@]}"
install_category "浏览器" "${BROWSERS[@]}"
install_category "办公和文档" "${OFFICE_APPS[@]}"
install_category "图形设计" "${GRAPHICS_APPS[@]}"
install_category "媒体工具" "${MEDIA_APPS[@]}"
install_category "文件管理" "${FILE_APPS[@]}"
install_category "通讯工具" "${COMMUNICATION_APPS[@]}"
install_category "系统工具" "${SYSTEM_APPS[@]}"
install_category "下载工具" "${DOWNLOAD_APPS[@]}"
install_category "数据库工具" "${DATABASE_APPS[@]}"
install_category "Git 工具" "${GIT_APPS[@]}"
install_category "其他工具" "${OTHER_APPS[@]}"

echo ""
echo -e "${GREEN}✅ Flatpak 应用安装完成!${NC}"
echo ""
echo "提示: 某些应用可能需要注销重新登录才能在应用菜单中显示"
echo ""
echo "下一步: ./03-toolbox-setup.sh"
