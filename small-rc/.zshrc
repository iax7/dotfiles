## ---- Zap ----- https://www.zapzsh.com/ --> rm -rf "$ZAP_DIR"
ZAP_INI="${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
[[ ! -f $ZAP_INI ]] && zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep --branch release-v1
source $ZAP_INI
## End Zap

plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-history-substring-search"
plug "z-shell/F-Sy-H"      # fast-theme -t default | or "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/completions" # or "Aloxaf/fzf-tab"
plug "trapd00r/LS_COLORS"
plug "wintermi/zsh-mise"
plug "$HOME/.bash_aliases"

plug "zap-zsh/zap-prompt"

# ================================= Config Programs ============================
command -v zoxide >/dev/null && eval "$(zoxide init --cmd cd zsh)"

# --------------------------------- SETTINGS ----------------------------------
export EDITOR=vim
export LANG=en_US.UTF-8
export PROMPT_EOL_MARK='⏎'

# Global Aliases
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias -g G='| grep -i'
alias -g H='| head'
alias -g J='| jq'
alias -g L='| less'
alias -g T='| tail'
alias -g V='--version'
alias -g \?\?='--help'
