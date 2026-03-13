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
add_path() { [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"; } # add_path "$HOME/bin"
# -----------------------------------------------------------------------------

# --------------------------------- PLUGINS -----------------------------------
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "z-shell/F-Sy-H"    # or "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"    # or "zap-zsh/completions"
plug "wintermi/zsh-mise"

cmd_exist vivid && export LS_COLORS="$(vivid generate molokai)" || \
  plug "trapd00r/LS_COLORS"

plug "$ZDOTDIR/aliases"
plug "$ZDOTDIR/globalalias"

# THEME == Oh-My-Posh -- https://ohmyposh.dev/
export POSH_THEME="$HOME/.config/oh-my-posh/p10k.yaml"
plug "wintermi/zsh-oh-my-posh"

# ================================= Config Programs ============================
# ---- Homebrew ----
export HOMEBREW_NO_ENV_HINTS=1
# ---- GPG (GNU Privacy Guard) ----
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GPG_TTY=$(tty)
# ---- Zoxide (better cd) with Workarounds ----
eval_if zoxide init --cmd cd zsh
# ---- Atuin (better history) ---- # --disable-up-arrow
eval_if atuin init zsh
