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
        if [[ -e "${i}" || -L "${i}" ]]; then
            mv "${i}" "${i}.${time}.backup"
            success "Backup ${i} done!"
        fi
    done
}

# Check source path exists
if [[ ! -d "${REPO_NVIM_PATH}" ]]; then
    msg "Error: ${REPO_NVIM_PATH} not found"
    exit 1
fi

# Link ~/.config/nvim
mkdir -p "${HOME}/.config"
backup "${APP_NVIM_PATH}"
rm -f "${APP_NVIM_PATH}"
ln -s "${REPO_NVIM_PATH}" "${APP_NVIM_PATH}"
success "nvim directory linked!"

# Install plugins
echo "Installing nvim plugins..."
if command -v nvim >/dev/null 2>&1; then
    (export SHELL='/bin/sh'; nvim --headless "+Lazy! sync" "+qall") || msg "Warning: nvim plugin sync failed"
fi

success "nvim setup done!"
