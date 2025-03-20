## ---- Zap ----- https://www.zapzsh.com/ --> rm -rf "$ZAP_DIR"
ZAP_INI="${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
[[ ! -f $ZAP_INI ]] && zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep --branch release-v1
source $ZAP_INI
## End Zap

plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "trapd00r/LS_COLORS" && zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
plug "$HOME/.bash_aliases"
plug "wintermi/zsh-mise"
plug "zap-zsh/completions"

# Load and initialise completion system
autoload -Uz compinit
compinit

# ================================= Config Programs ============================
command -v zoxide >/dev/null && eval "$(zoxide init --cmd cd zsh)"

# --------------------------------- SETTINGS ----------------------------------
export EDITOR=vim
export LANG=en_US.UTF-8
export PROMPT_EOL_MARK='⏎'
HISTSIZE=10000               # Commands kept in memory
SAVEHIST=10000               # Commands saved to history file
HISTFILE=~/.zsh_history      # History file path
setopt HIST_IGNORE_ALL_DUPS  # Ignore all duplicate commands, not just consecutive ones
setopt HIST_IGNORE_SPACE     # Ignore commands that start with a space

autoload -Uz zmv # Enable zmv for renaming files

# Global Aliases
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias -g G='| grep -i'
alias -g H='| head'
alias -g J='| jq'
alias -g L='| less'
alias -g T='| tail'
alias -g V='--version'
alias -g \?\?='--help'
