# skip when performing a headless operation (such as rsync).
[[ -z ${PS1:-} ]] && return

if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://wiki.zshell.dev/ecosystem/category/-annexes
zicompinit # <- https://wiki.zshell.dev/docs/guides/commands
# https://wiki.zshell.dev/ecosystem/category/-annexes
zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes @zsh-users+fast @romkatv

zi ice wait'0' lucid
zi load wfxr/forgit
zi load z-shell/H-S-MW

zi snippet OMZP::asdf
zi snippet OMZP::sudo
zi snippet OMZP::rake
zi snippet OMZP::dirhistory
zi snippet OMZP::colored-man-pages

# examples here -> https://wiki.zshell.dev/community/gallery/collection
zicompinit # <- https://wiki.zshell.dev/docs/guides/commands

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

[[ -f /etc/grc.zsh ]] && . /etc/grc.zsh # Must be AFTER .bash_aliases
