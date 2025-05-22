#!/usr/bin/env bash

PACKAGES=(
  bash
  git
  tmux
  vim
  zsh
)

# stow -v -t ~/.config oh-my-posh

if [[ "$1" == "--delete" || "$1" == "-D" ]]; then
  options='-v -D'
  echo "🗑️ Deleting symlinks..."
else
  options='-v'
  echo "🔗 Creating symlinks..."
fi

for pkg in "${PACKAGES[@]}"; do
  stow "$options" "$pkg"
done
