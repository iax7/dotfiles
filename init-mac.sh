#!/usr/bin/env bash
cmd_exist() { command -v "$1" &> /dev/null; }

xcode-select --install

# Mise -- https://mise.jdx.dev/
cmd_exist mise || curl https://mise.run | sh

# Brew -- https://brew.sh
if ! cmd_exist brew; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew analytics off
fi

# Basic packages
APPS=(
  libyaml # Required for Ruby
  gnupg   # gpg2
  pinentry-mac
  bat
  eza
  fd
  fzf
  git-delta
  lazygit
  neovim
  ripgrep
  stow
  tmux
  xh
  zoxide
)
brew install "${APPS[@]}"
brew install --cask font-jetbrains-mono-nerd-font

stow -vt ~/.config .config
./init.sh zsh
