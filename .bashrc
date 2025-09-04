# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source ~/.functions
source ~/.aliases

# don't put duplicate lines in the history. See bash(1) for more options
HISTCONTROL=ignoredups
HISTTIMEFORMAT='%F %T '
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3000
HISTFILESIZE=$HISTSIZE
# Configure BASH to append (rather than overwrite the history):
shopt -s histappend
# Attempt to save all lines of a multiple-line command in the same entry
shopt -s cmdhist

export PROMPT_COMMAND="history -a"
#export PROMPT_COMMAND="echo -ne \"\033]0;$1 ($HOSTNAME)\007\"; history -a;"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# General auto-complete
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export EDITOR=vim
export GOPATH=~/go

# coreutils
if [ -d /usr/local/opt/coreutils/ ]; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# # prompt
# parse_git_branch() {
#      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }
# export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

export PATH=$PATH:/usr/local/opt/go/libexec/bin:/usr/local/go/bin:$GOPATH/bin


[ -f ~/.bash_local ] && . ~/.bash_local
eval "$(starship init bash)"
