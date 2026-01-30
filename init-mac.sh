#!/usr/bin/env bash
. bin/.common || exit 1

xcode-select --install

# Mise -- https://mise.jdx.dev/
conf.d/install_mise

# Brew -- https://brew.sh
conf.d/install_homebrew
brew bundle # Basic packages

step "Setting up symlinks and configurations"
DOTFILES_DIR="$(basename $PWD)"
set_symlink "$HOME/bin" "$DOTFILES_DIR/bin" | indent

stow -vt ~/.config .config
stow -v zsh

step "Setting up Neovim with Lazy.nvim"
nvim --headless "+Lazy! sync" +qa
