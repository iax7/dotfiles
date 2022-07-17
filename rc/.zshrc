# skip when performing a headless operation (such as rsync).
[[ -z ${PS1:-} ]] && return

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# --------------------------------- SETTINGS ----------------------------------
# Lines configured by zsh-newuser-install
TERM="xterm-256color"
HIST_STAMPS="yyyy-mm-dd"
HISTORY_IGNORE='(l[ls]|cd ..|..|pwd|exit|date)' # affects only history written to the history file
PROMPT_EOL_MARK='⏎' #\uf476 nf-oct-no_newline

# Options
setopt auto_cd # cd by typing directory name if it's not a command
setopt autopushd
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_ignore_dups   # Don't record an entry that was just recorded again.
setopt hist_ignore_all_dups # Delete old recorded entry if new entry is a duplicate.
setopt hist_expire_dups_first
setopt hist_save_no_dups  # Don't write duplicate entries in the history file.
setopt hist_ignore_space  # Don't record an entry (or alias) starting with a space.
setopt hist_verify        # Don't execute immediately upon history expansion.
setopt hist_reduce_blanks # Remove superfluous blanks before recording entry.
# setopt SHARE_HISTORY

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  sudo
  jump
  dirhistory
  colored-man-pages
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
  history-substring-search
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export VISUAL=vim
export EDITOR="$VISUAL"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# --------------------------------- ALIASES -----------------------------------
command -v bat > /dev/null && alias cat='bat --pager=never --plain'

if command -v exa &> /dev/null; then
  alias l='exa -Hlg --color-scale --classify --icons --git --group-directories-first'
  alias ll='l -aa'
  alias lt='exa --tree -L2'
else
  alias ll='ls -lahF --color'
fi

# Global Aliases
alias -g  D='| diff-so-fancy'
alias -g  G='| grep -i'
alias -g  H='| head'
alias -g HH='--help'
alias -g  J='| jq'
alias -g  L='| less'
alias -g  T='| tail'
alias -g FN='${PWD##*/}'
alias -g NIL='> /dev/null 2>&1'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---[ APPS ]-------------------------------------------------------------------
export ACK_COLOR_MATCH='bold white on_red' # black on_yellow
export ACK_COLOR_LINENO='bold blue'        # bold yellow
export EXA_COLORS='uu=38;5;47:gu=38;5;40:un=38;5;11:gn=38;5;184'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

[[ -f ~/.forgit/forgit.plugin.zsh ]] && . ~/.forgit/forgit.plugin.zsh
[[ -f /etc/grc.zsh ]] && . /etc/grc.zsh # Must be AFTER .bash_aliases

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
