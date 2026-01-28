#!/usr/bin/env bash

if command -v apt >/dev/null 2>&1; then
  echo "Installing packages for small-rc"
  sudo apt-get update
  apps=(git zsh vim tmux jq eza bat fzf fd-find ripgrep git-delta \
        btop zoxide)
  sudo apt install -y ${apps[@]}
fi

echo "🔗 Creating symlinks..."
stow -v small-rc

if command -v vim >/dev/null 2>&1; then
  echo "Bootstraping Vim"
  vim '+PlugUpdate' '+PlugClean!' '+PlugUpdate' '+qall'
fi
