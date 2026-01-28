# =============================================================================
# .zshenv - Zsh Environment Configuration
# =============================================================================
# Sourced on all invocations of the shell, unless the -f option is set.
# Should not contain commands that produce output or assume shell is interactive.
# Sets environment variables needed by all shells (login, interactive, scripts).
# =============================================================================

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Zsh Configuration
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# System Defaults
export EDITOR=vim
export VISUAL="${VISUAL:-$EDITOR}"
export LANG=en_US.UTF-8

# PATH Configuration
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
