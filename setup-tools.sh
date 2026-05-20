#!/usr/bin/env bash

# ------
# name: setup-tools.sh
# desc: link scripts in tools/ to ~/.local/bin
# ------

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"
LOCAL_BIN_PATH="${LOCAL_BIN_PATH:-$HOME/.local/bin/}"

# Define helper functions if not already defined
if ! declare -f success >/dev/null 2>&1; then
    Green='\033[0;32m'
    Color_off='\033[0m'
    msg() { printf '%b\n' "$1" >&2; }
    success() { msg "${Green}[✔]${Color_off} ${1}"; }
fi

if ! declare -f backup >/dev/null 2>&1; then
    backup() {
        local time
        time=$(date +%s)
        for i in "$@"; do
            if [[ -L "${i}" ]]; then
                rm "${i}"
                success "Remove symlink ${i}!"
            elif [[ -e "${i}" ]]; then
                mv "${i}" "${i}.${time}.backup"
                success "Backup ${i} done!"
            fi
        done
    }
fi

install_tools() {
    local tools_path="${DOTFILES_PATH}/tools"
    local bin_path="${LOCAL_BIN_PATH}"

    if [[ ! -d "${tools_path}" ]]; then
        msg "Warning: ${tools_path} not found, skipping tools installation"
        return 0
    fi

    mkdir -p "${bin_path}"

    for script in "${tools_path}"/*.sh; do
        [ -f "${script}" ] || continue
        local name
        name=$(basename "${script}" .sh)
        local target="${bin_path}${name}"
        backup "${target}"
        ln -sf "${script}" "${target}"
        success "Link tool: ${name}!"
    done
}

install_tools
