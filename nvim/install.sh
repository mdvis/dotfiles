#!/usr/bin/env bash

# ------
# name: nvim/install.sh
# author: Deve
# date: 2022-03-27
# ------

set -e
set -o pipefail

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"
REPO_NVIM_PATH="${DOTFILES_PATH}/nvim"
APP_NVIM_PATH="${HOME}/.config/nvim"

Green='\033[0;32m'
Color_off='\033[0m'

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    msg "${Green}[✔]${Color_off} ${1}"
}

backup() {
    local time
    time=$(date +%s)
    for i in "$@"; do
        if [[ -e "${i}" ]]; then
            mv "${i}" "${i}.${time}.backup"
            success "Backup ${i} done!"
        fi
    done
}

# Link ~/.config/nvim
mkdir -p "${HOME}/.config"
backup "${APP_NVIM_PATH}"
ln -sf "${REPO_NVIM_PATH}" "${APP_NVIM_PATH}"
success "nvim directory linked!"

# Install plugins
echo "Installing nvim plugins..."
local_shell="$SHELL"
export SHELL='/bin/sh'
if command -v nvim >/dev/null 2>&1; then
    nvim "+PlugInstall!" "+PlugClean" "+qall" 2>/dev/null || true
fi
export SHELL="${local_shell}"

success "nvim setup done!"
