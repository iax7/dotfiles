## ---- Zap ----- https://www.zapzsh.com/ --> rm -rf "$ZAP_DIR"
ZAP_INI="${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
[[ ! -f $ZAP_INI ]] && zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep --branch release-v1
source $ZAP_INI
## End Zap

# Helper functions ------------------------------------------------------------
cmd_exist() { command -v "$1" &> /dev/null; }
source_if() { [[ -f "$1" && -r "$1" ]] && source "$1"; } # not very useful, use plug instead (kept for consistency)
eval_if() { command -v "$1" &> /dev/null && source <("$@"); }
mini_t() { echo -e " \e[31m--\e[0m \e[34m${@}\e[0m \e[31m--\e[0m"; }
# -----------------------------------------------------------------------------

# --------------------------------- PLUGINS -----------------------------------
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-history-substring-search"
plug "z-shell/F-Sy-H"    # or "zsh-users/zsh-syntax-highlighting"
plug "Aloxaf/fzf-tab"    # or "zap-zsh/completions"
plug "trapd00r/LS_COLORS"
plug "wintermi/zsh-mise"

plug "$ZDOTDIR/aliases"
plug "$ZDOTDIR/globalalias"
plug "$HOME/.zshrc" # some tools add settings here

# THEME == Oh-My-Posh -- https://ohmyposh.dev/
export POSH_THEME="$HOME/.config/oh-my-posh/p10k.yaml"
plug "wintermi/zsh-oh-my-posh"

# ================================= Config Programs ============================
# ---- Zoxide (better cd) with Workarounds (conflicts with Zi's z command)
eval_if zoxide init --cmd cd zsh
