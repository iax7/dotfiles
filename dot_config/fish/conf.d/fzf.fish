status is-interactive || return # Guard against non-interactive shells

fzf --fish | source
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --ansi --color=16"
set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always {}' --preview-window right:50%"

set -f fd_opts --type f --strip-cwd-prefix --hidden --follow --exclude .git
set -gx FZF_DEFAULT_COMMAND "fd $fd_opts"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
