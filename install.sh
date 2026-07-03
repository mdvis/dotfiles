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

sync_repo "${DOTFILES_PATH}" "${REPO_URI}"
cd "${DOTFILES_PATH}" || exit 1

if command -v brew &>/dev/null; then
    . "${DOTFILES_PATH}/setup-brew.sh" || error "Failed to setup brew packages"
    . "${DOTFILES_PATH}/setup-agent.sh" || error "Failed to setup agent packages"
fi

if [ "${SYSTEM}" == "linux" ] && command -v apt &>/dev/null && command -v nix &>/dev/null; then
    . "${DOTFILES_PATH}/setup-apt.sh" || error "Failed to setup apt packages"
    . "${DOTFILES_PATH}/nix/install.sh" || error "Failed to setup nix"
    . "${DOTFILES_PATH}/setup-agent.sh" || error "Failed to setup agent packages"
fi

success "All done!"
