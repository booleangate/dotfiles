#!/bin/bash

alias ls='ls -lF --color=auto'
alias l='ls -l'
alias ll='ls -la'

alias agent='eval "$(ssh-agent -s)"'
alias git-key='agent;ssh-add ~/.ssh/id_github'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias v='vim'

# Enables alias expansion while using sudo
alias sudo='sudo '
alias unbuffered='stdbuf -i0 -o0 -e0'
alias local-https='caddy reverse-proxy --from localhost --to localhost:8080'
