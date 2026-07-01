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

FONTS_PATH="${DOTFILES_PATH}/fonts/"
LOCAL_FONTS_PATH="${HOME}/.local/share/fonts/"
MAC_FONTS_PATH="${HOME}/Library/Fonts/"

SYSTEM="$(uname -s | tr '[:upper:]' '[:lower:]')"

RED='\033[0;31m'
GREEN='\033[0;32m'
COLOR_OFF='\033[0m'

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    msg "${GREEN}[✔]${COLOR_OFF} ${1}"
}

error() {
    msg "${RED}[✘]${COLOR_OFF} ${1}"
    exit 1
}

sync_repo() {
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

get_fonts_target_path() {
    if [ "${SYSTEM}" == "darwin" ]; then
        echo "${MAC_FONTS_PATH}"
    else
        echo "${LOCAL_FONTS_PATH}"
    fi
}

copy_fonts_to() {
    local target_path="$1"

    mkdir -p "${target_path}"
    cp -r "${FONTS_PATH}"* "${target_path}"
}

refresh_font_cache() {
    if [ "${SYSTEM}" != "darwin" ]; then
        fc-cache -fv >/dev/null
    fi
}

install_fonts() {
    copy_fonts_to "$(get_fonts_target_path)"

    refresh_font_cache

    success "Fonts installed!"
}

# ── sync repo ────────────────────────────────────────────────────────────────

sync_repo "${DOTFILES_PATH}" "${REPO_URI}"
cd "${DOTFILES_PATH}" || exit 1

# ── fonts ────────────────────────────────────────────────────────────────────

install_fonts

# ── packages ─────────────────────────────────────────────────────────────────

if command -v brew &>/dev/null; then
    . "${DOTFILES_PATH}/setup-brew.sh" || error "Failed to setup brew packages"
fi

if [ "${SYSTEM}" == "linux" ] && command -v apt &>/dev/null && command -v nix &>/dev/null; then
    . "${DOTFILES_PATH}/setup-apt.sh" || error "Failed to setup apt packages"
    . "${DOTFILES_PATH}/nix/install.sh" || error "Failed to setup nix"
fi

success "All done!"
