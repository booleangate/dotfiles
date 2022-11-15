# If not running interactively, don't do anything
[ -z "$PS1" ] && return

. ~/.bash_functions

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

if is_mac; then
    # General auto-complete
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


    export CLICOLOR=1
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
else
    export TERM=xterm-256color
fi

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_local ] && . ~/.bash_local

export EDITOR=vim

# coreutils 
if [ -d /usr/local/opt/coreutils/ ]; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# Lanaguage crap
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -d ~/.ghcup ] && export PATH="$HOME/.cabal/bin:${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/bin:$PATH"

# Go
export PATH="/opt/homebrew/opt/go@1.17/bin:$PATH"
which go &>/dev/null && export PATH=$(go env GOPATH)/bin:$PATH

if [ -d "$HOME/.volta" ]; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
fi
export AWS_PROFILE=localdev-session

# >>>> Vagrant command completion (start)
. /opt/vagrant/embedded/gems/2.3.2/gems/vagrant-2.3.2/contrib/bash/completion.sh
# <<<<  Vagrant command completion (end)
