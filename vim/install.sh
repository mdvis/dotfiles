#!/usr/bin/env bash

# ------
# name: vim/install.sh
# author: Deve
# date: 2022-03-27
# ------

set -e
set -o pipefail

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"
REPO_VIM_PATH="${DOTFILES_PATH}/vim"
APP_VIM_PATH="${HOME}/.vim"

Green='\033[0;32m'
Color_off='\033[0m'

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    msg "${Green}[✔]${Color_off} ${1}"
}

ln_if() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
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

# Link ~/.vim
backup "${APP_VIM_PATH}"
ln_if "${REPO_VIM_PATH}" "${APP_VIM_PATH}"
success "vim directory linked!"

# Link config files (vimrc, etc.) into ~/
while IFS= read -r -d '' f; do
    file=$(basename "$f")
    backup "${HOME}/.${file}"
    ln_if "${f}" "${HOME}/.${file}"
    success "Link ${file}!"
done < <(/usr/bin/find "${REPO_VIM_PATH}/config" -maxdepth 1 -type f -print0)

# Install plugins
echo "Installing vim plugins..."
local_shell="$SHELL"
export SHELL='/bin/sh'
if command -v vim >/dev/null 2>&1; then
    vim "+PlugInstall!" "+PlugClean" "+qall" 2>/dev/null || true
fi
export SHELL="${local_shell}"

success "vim setup done!"
