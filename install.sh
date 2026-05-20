#!/usr/bin/env bash

# ------
# name: install.sh
# author: Deve
# date: 2022-03-27
# ------

set -e
set -u
set -o pipefail

APP_NAME="dotfiles"
REPO_URI="https://github.com/mdvis/${APP_NAME}.git"
DOTFILES_PATH="${HOME}/.${APP_NAME}"

CONFIG_PATH="${HOME}/.config/"
LOCAL_BIN_PATH="${HOME}/.local/bin/"
LOCAL_FONTS_PATH="${HOME}/.local/share/fonts/"
SSH_PATH="${HOME}/.ssh/"
MAC_FONTS_PATH="${HOME}/Library/Fonts/"

System="$(uname -s | tr '[:upper:]' '[:lower:]')"

Red='\033[0;31m'
Green='\033[0;32m'
Color_off='\033[0m'

# ── helpers ──────────────────────────────────────────────────────────────────

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    msg "${Green}[✔]${Color_off} ${1}"
}

error() {
    msg "${Red}[✘]${Color_off} ${1}"
    exit 1
}

ln_if() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}

backup() {
    local list time
    list="$*"
    time=$(date +%s)
    for i in $list; do
        if [[ -L "${i}" ]]; then
            rm "${i}"
        elif [[ -e "${i}" ]]; then
            mv "${i}" "${i}.${time}.backup"
            success "Backup ${i} done!"
        fi
    done
}

getFile() {
    /usr/bin/find "$1" -maxdepth 1 -type f
}

getDir() {
    /usr/bin/find "$1" -maxdepth 1 -mindepth 1 -type d
}

handler() {
    local path_name="$1"
    local target_dir="$2"
    local typ="$3"
    local dir_list file

    if [[ "${typ}" == "f" ]]; then
        dir_list=$(getFile "${path_name}")
    else
        dir_list=$(getDir "${path_name}")
    fi

    for i in ${dir_list}; do
        file=$(basename "$i")
        backup "${target_dir}${file}"
        ln_if "${path_name}/${file}" "${target_dir}${file}"
        success "Link ${file}!"
    done
}

syncRepo() {
    local repo_path="$1"
    local repo_uri="$2"

    if [ ! -e "$repo_path" ]; then
        mkdir -p "$repo_path"
        git clone --depth 1 "$repo_uri" "$repo_path"
    else
        cd "$repo_path" && git fetch origin && git reset --hard origin/main
    fi

    success "Sync $(basename "${repo_uri%.git}") done!"
}

install_fonts() {
    if [ "${System}" == "darwin" ]; then
        mkdir -p "${MAC_FONTS_PATH}"
        cp -r "${DOTFILES_PATH}/fonts/"* "${MAC_FONTS_PATH}"
    else
        mkdir -p "${LOCAL_FONTS_PATH}"
        cp -r "${DOTFILES_PATH}/fonts/"* "${LOCAL_FONTS_PATH}"
        fc-cache -fv >/dev/null
    fi
    success "Fonts installed!"
}

install_vim() {
    bash "${DOTFILES_PATH}/vim/install.sh"
    bash "${DOTFILES_PATH}/nvim/install.sh"
}

# ── init dirs ────────────────────────────────────────────────────────────────

mkdir -p "${LOCAL_BIN_PATH}"
mkdir -p "${CONFIG_PATH}"
mkdir -p "${SSH_PATH}"
mkdir -p "${HOME}/.swp" "${HOME}/.backup" "${HOME}/.undo"

# ── sync repo ────────────────────────────────────────────────────────────────

syncRepo "${DOTFILES_PATH}" "${REPO_URI}"
cd "${DOTFILES_PATH}" || exit 1

# ── packages ─────────────────────────────────────────────────────────────────

if command -v apt &>/dev/null; then
    . "${DOTFILES_PATH}/setup-apt.sh" || error "Failed to setup apt packages"
fi

if command -v brew &>/dev/null; then
    . "${DOTFILES_PATH}/setup-brew.sh" || error "Failed to setup brew packages"
fi

if [ "${System}" == "linux" ] && command -v nix &>/dev/null; then
    . "${DOTFILES_PATH}/nix/install.sh" || error "Failed to setup nix"
fi

# ── tools ────────────────────────────────────────────────────────────────────

. "${DOTFILES_PATH}/setup-tools.sh" || error "Failed to setup tools"

# ── fonts ────────────────────────────────────────────────────────────────────

install_fonts

# ── dotfiles ─────────────────────────────────────────────────────────────────

handler "${DOTFILES_PATH}/ssh" "${SSH_PATH}" "f" || error "Failed to link ssh!"
handler "${DOTFILES_PATH}/config_files" "${HOME}/." "f" || error "Failed to link config files!"
handler "${DOTFILES_PATH}/config_dirs" "${CONFIG_PATH}" "d" || error "Failed to link config dirs!"

# ── vim / nvim ───────────────────────────────────────────────────────────────

install_vim

success "All done!"