# dotfiles

My personal dotfiles — vim/nvim config, shell profile, fonts, tools, and nix packages, all in one place.

## Structure

```
dotfiles/
├── vim/          # Vim configuration
├── nvim/         # Neovim configuration (lazy.nvim)
├── nix/          # Nix flake & modules
│   └── install.sh
├── config_dirs/  # ~/.config/* directories (alacritty, wezterm, sway, …)
├── config_files/ # ~/. dotfiles (zshrc, gitconfig, tmux.conf, …)
├── fonts/        # Nerd fonts & CJK fonts
├── packages/     # Package lists (apt)
├── ssh/          # SSH config
├── tmux/         # Tmux statusline scripts
├── tools/        # Utility shell scripts
├── wallpapers/   # Desktop / lock screen wallpapers
├── Brewfile      # Homebrew bundle
├── setup-apt.sh  # Apt package installer
├── setup-brew.sh # Brew bundle installer
└── install.sh    # Main installer
```

## Install

### Full setup (profile + vim/nvim)

```bash
curl -sSLf https://raw.githubusercontent.com/mdvis/dotfiles/refs/heads/main/install.sh -o - | bash
```

### Nix only

```bash
curl -sSLf https://raw.githubusercontent.com/mdvis/dotfiles/refs/heads/main/nix/install.sh -o - | bash
```

## Previous repositories

| Repo | Description |
|------|-------------|
| [mdvis/dvim](https://github.com/mdvis/dvim) | vim/nvim config (archived) |
| [mdvis/myprofile](https://github.com/mdvis/myprofile) | shell profile & dotfiles (archived) |
| [mdvis/nix-config](https://github.com/mdvis/nix-config) | nix flake (archived) |
