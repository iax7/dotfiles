# sourced on all invocations of the shell, unless the -f option is set.
# should not contain commands that produce output
# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export EDITOR=vim
export LANG=en_US.UTF-8
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
