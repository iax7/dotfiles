#!/usr/bin/env bash

if command -v apt >/dev/null 2>&1; then
  echo "Installing packages for small-rc"
  sudo apt-get update
  # Outdated packages: bat eza fd-find fzf ripgrep git-delta zoxide
  apps=(git zsh vim tmux jq btop)
  sudo apt install -y ${apps[@]}
fi

# install Mise
curl https://mise.run | sh
mise use -g bat delta eza fd fzf ripgrep yazi zellij zoxide

echo "🔗 Creating symlinks..."
stow -v small-rc

if command -v vim >/dev/null 2>&1; then
  echo "Bootstraping Vim"
  vim '+PlugUpdate' '+PlugClean!' '+PlugUpdate' '+qall'
fi
