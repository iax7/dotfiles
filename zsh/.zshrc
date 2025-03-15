# zmodload zsh/zprof
## ---- Zap ----- https://www.zapzsh.com/ --> rm -rf "$ZAP_DIR"
ZAP_INI="${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
[[ ! -f $ZAP_INI ]] && zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep --branch release-v1
source $ZAP_INI
## End Zap

plug "zap-zsh/supercharge"
plug "hlissner/zsh-autopair"
plug "wintermi/zsh-starship"
plug "zsh-users/zsh-autosuggestions"
plug "wintermi/zsh-mise"
plug "z-shell/F-Sy-H" # "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/exa"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"

autoload -Uz zmv # Habilita zmv para renombrar archivos

PROMPT_EOL_MARK='⏎'
# Configuración del historial
HISTSIZE=10000           # Comandos en memoria
SAVEHIST=10000           # Comandos guardados
HISTFILE=~/.zsh_history  # Archivo de historial
setopt HIST_IGNORE_ALL_DUPS  # Ignora todos los duplicados, no solo consecutivos
setopt HIST_IGNORE_SPACE     # Ignorar comandos con espacio al inicio

# Autocompletado avanzado
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # Insensible a mayúsculas

# Variables de entorno
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export EDITOR="nvim"                          # Editor por defecto
export LANG="es_ES.UTF-8"                     # Idioma (ajusta según tu región)
# zprof
