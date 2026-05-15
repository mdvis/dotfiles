#!/usr/bin/env bash

# ------
# name: nix/install.sh
# author: Deve
# date: 2022-03-27
# ------

set -e
set -o pipefail

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"
NIX_CONFIG_PATH="${DOTFILES_PATH}/nix"

Red='\033[0;31m'
Green='\033[0;32m'
Color_off='\033[0m'

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

# Install nix.conf
if [ -d /etc/nix ]; then
    sudo cp "${NIX_CONFIG_PATH}/etc/nix.conf" /etc/nix/nix.conf
    success "nix.conf installed!"
else
    msg "Skipping nix.conf: /etc/nix not found"
fi

# Install flake
FLAKE_TARGET="${HOME}/.config/nix"
mkdir -p "${FLAKE_TARGET}"
ln -sf "${NIX_CONFIG_PATH}/flake.nix" "${FLAKE_TARGET}/flake.nix"
ln -sf "${NIX_CONFIG_PATH}/modules" "${FLAKE_TARGET}/modules"
success "Nix flake linked!"

success "Nix setup done!"
