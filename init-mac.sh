#!/usr/bin/env bash

xcode-select --install

# Mise -- https://mise.jdx.dev/
conf.d/install_mise

# Brew -- https://brew.sh
conf.d/install_homebrew

# Basic packages
APPS=(
  libyaml      # Required for Ruby
  gnupg        # gpg2
  pinentry-mac # gpg2 GUI password prompt
  bash
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
  oh-my-posh   # Prompt theming engine
)
brew install "${APPS[@]}"
brew install --cask font-jetbrains-mono-nerd-font

DOTFILES_DIR="$(basename $PWD)"
ln -sfv "$DOTFILES_DIR/bin" "$HOME/bin"

stow -vt ~/.config .config
stow -v zsh

nvim --headless "+Lazy! sync" +qa
