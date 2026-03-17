set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx LANG en_US.UTF-8

status is-interactive || return
# ----------------------------- Interactive -----------------------------------
mise activate fish | source
zoxide init fish --cmd cd | source
atuin init fish | source
starship init fish | source
thefuck --alias fk | source

set -gx LS_COLORS (vivid generate molokai)

set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
carapace _carapace | source
