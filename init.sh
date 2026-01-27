#!/usr/bin/env bash

# -- Clean broken symlinks --
# find ~ -type l -xtype l -delete

echo "🔗 Creating symlinks..."
stow -v $1
