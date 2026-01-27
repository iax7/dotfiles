#!/usr/bin/env bash
alias sudo='sudo '
alias _='sudo su'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias rm='\rm -Iv'

alias e='f(){ [[ -z "$1" ]] && env || env | grep -i "$1"; };f'
alias h='f(){ [[ -z "$1" ]] && history || history | grep -i "$1"; };f'
alias p='f(){ [[ -z "$1" ]] && ps -ef || ps -ef | grep -v grep | grep -i "$1"; };f'
alias n='f(){ [[ -z "$1" ]] && \ss -tulnp || \ss -tulnp | grep -i "$1"; };f'

alias path='f(){ [[ -z "$1" ]] && echo -e "${PATH//:/\\n}" | nl || echo -e "${PATH//:/\\n}" | nl | grep -i "$1"; };f'
alias path+='f(){ [[ -z "$1" ]] && _p="$PWD" || _p="$1"; [[ -d "$_p" ]] && { [[ ":$PATH:" =~ ":$_p:" ]] && echo "$_p already exists." || { export PATH="$_p:$PATH";echo "$_p Added."; }; } || echo "Err, $_p not found."; };f'
alias path-='f(){ [[ -z "$1" ]] && echo Err, parameter missing || { echo "Removing: $1" && export PATH=$(echo $PATH | sed s,:"$1",,); }; };f'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# easier to read disk (human-readable sizes)
alias df='df -h'
alias free='free -h'

# Web Clipboard
alias cw='nc termbin.com 9999'
alias pw='f(){ curl -s "https://termbin.com/$1"; };f'

## Utils =====================================================================
cmd_exist() { command -v "$1" &> /dev/null; }
dir_exist() { [[ -d "$1" ]]; }
mini_t() { echo -e " \e[31m--\e[0m \e[34m${@}\e[0m \e[31m--\e[0m"; }

## Programs ===================================================================
# LazyGit - https://github.com/jesseduffield/lazygit
cmd_exist lazygit && alias lg=lazygit
# IP command --------------------------
cmd_exist ip && alias ip='ip --color=auto'
# EZA - https://eza.rocks/ ------------
if cmd_exist eza; then
  alias ls='eza --group-directories-first --icons'
  alias l='ls -HlgF --git --color-scale'
  alias ll='l -aa'
  alias lt='f(){ ls --tree --git-ignore -L${1:-2}; };f'
else
  alias ls='ls --color=auto'
  alias ll='ls -halF'
fi
# BatCat - https://github.com/sharkdp/bat
if cmd_exist bat; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  alias bathelp='bat --plain --language=help' # Highlighting --help
  alias cat='bat -pp' #= --plain --paging=never
  tf() { tail -f "$1" | cat -l log; } # Tail Follow
fi
# SystemCTL - https://systemd.io/ ---------------------------
if cmd_exist systemctl; then
  __msg() { echo -e "\e[31m>>\e[0m Using systemctl as ${1}\e[0m"; }
  systemctl_aliases() {
    local _base_cmd="systemctl --user"
    [[ "$1" == "sudo" ]] && _base_cmd="sudo systemctl"
    alias   s="${_base_cmd} list-units --no-pager --type=service --plain --legend=false"
    alias  s.="${_base_cmd} start"
    alias  s-="${_base_cmd} stop"
    alias  s,="${_base_cmd} restart"
    alias  s1="${_base_cmd} enable"
    alias  s0="${_base_cmd} disable"
    alias  se="${_base_cmd} show-environment"
    alias s\?="${_base_cmd} --no-pager status"
    alias s_="mini_t daemon-reload; ${_base_cmd} daemon-reload"
    alias st="${_base_cmd} list-timers --all"
  }
  systemctl_aliases  # load USER aliases as default
  alias sw='f(){ [[ -z $1 ]] && { __msg "\e[34mUser"; systemctl_aliases; } || { __msg "\e[1;31mSystem"; systemctl_aliases sudo; }; };f'
fi
# Docker - https://www.docker.com/get-started
if cmd_exist docker; then
  alias d='docker'
  alias dps='d ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"'
  alias di='d image ls'
  alias dp='d system prune --volumes'
fi
# mise - https://github.com/jdx/mise --
if cmd_exist mise; then
  alias ml='mise list'
  alias mD='mise doctor'
  alias mU='mini_t self-update && mise self-update --yes --cd ~ && mini_t update && mise up --cd ~'
  alias mu='mise upgrade --bump -i'
fi

## Functions ==================================================================
update() {
  # Debian/Ubuntu based systems
  cmd_exist nala && sudo nala upgrade -y && return 0
  cmd_exist apt && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
}
