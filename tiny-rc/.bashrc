alias ..='cd ..'
alias ...='cd ../../'
alias l='ls -l --color=auto'
alias ll='ls -halF --color'
alias grep='grep --color=auto'
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
PS1='\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\$ '
PS2='\[\e[32m\]> \[\e[m\]'
