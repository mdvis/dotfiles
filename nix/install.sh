#!/usr/bin/env bash

# ------
# name: nix/install.sh
# author: Deve
# date: 2022-03-27
# ------

# When sourced from install.sh, DOTFILES_PATH / msg / success / error
# are already defined. When run standalone, define them here.
if [ -z "${DOTFILES_PATH+x}" ]; then
    DOTFILES_PATH="${HOME}/.dotfiles"

    Red='\033[0;31m'
    Green='\033[0;32m'
    Color_off='\033[0m'

    msg()     { printf '%b\n' "$1" >&2; }
    success() { msg "${Green}[✔]${Color_off} ${1}"; }
    error()   { msg "${Red}[✘]${Color_off} ${1}"; exit 1; }
fi

NIX_CONFIG_PATH="${DOTFILES_PATH}/nix"

# ── preflight ────────────────────────────────────────────────────────────────

[[ "$(uname -s | tr '[:upper:]' '[:lower:]')" != "linux" ]] && error "Nix setup is Linux only"
command -v nix >/dev/null 2>&1 || error "nix is not installed"

# ── nix.conf ─────────────────────────────────────────────────────────────────

if [ -d /etc/nix ]; then
    sudo cp "${NIX_CONFIG_PATH}/etc/nix.conf" /etc/nix/nix.conf
    success "nix.conf installed!"
else
    msg "Skipping nix.conf: /etc/nix not found"
fi

# ── link flake ───────────────────────────────────────────────────────────────

FLAKE_TARGET="${HOME}/.config/nix"
mkdir -p "${FLAKE_TARGET}"
ln -sf "${NIX_CONFIG_PATH}/flake.nix" "${FLAKE_TARGET}/flake.nix"
ln -sf "${NIX_CONFIG_PATH}/modules" "${FLAKE_TARGET}/modules"
success "Nix flake linked!"

# ── install packages ─────────────────────────────────────────────────────────

msg "Installing packages from flake (this may take a while)..."

if nix profile list 2>/dev/null | grep -q "all-pkgs"; then
    nix profile upgrade '.*all-pkgs.*' \
        --extra-experimental-features 'nix-command flakes' \
        --flake "${NIX_CONFIG_PATH}#all-pkgs" \
        || error "Failed to upgrade nix packages"
    success "Nix packages upgraded!"
else
    nix profile install \
        --extra-experimental-features 'nix-command flakes' \
        "${NIX_CONFIG_PATH}#all-pkgs" \
        || error "Failed to install nix packages"
    success "Nix packages installed!"
fi

success "Nix setup done!"
