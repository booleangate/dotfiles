#!/bin/bash

if ! is_mac; then
    alias ls='ls -lF --color=auto'
#else
    # alias oproxy='open /Applications/Royal\ TSX.app/ & haproxy -d -f ~/.raxvm/haproxy.conf'
fi

alias agent='eval "$(ssh-agent -s)"'
alias git-key='agent;ssh-add ~/.ssh/id_github'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias fuck='TF_CMD=$(TF_ALIAS=fuck PYTHONIOENCODING=utf-8 TF_SHELL_ALIASES=$(alias) thefuck $(fc -ln -1)) && eval $TF_CMD && history -s $TF_CMD'
alias g='git'
alias l='ls -l'
alias v='vim'
# Enables alias expansion while using sudo
alias sudo='sudo '
alias unbuffered='stdbuf -i0 -o0 -e0'
alias tp='telepresence'
alias tp-reset='tp quit -ur && infra-init && tp connect'
alias local-https='caddy reverse-proxy --from localhost --to localhost:8080'

if command -v ack-grep >/dev/null; then
  alias ack='ack-grep'
fi
