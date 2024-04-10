export CLICOLOR=1
export EDITOR=vim

source ~/.functions
source ~/.aliases

# Prefer GNU coreutils over non-portable mac versions
if [ -d /usr/local/opt/coreutils/ ]; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

eval "$(/opt/homebrew/bin/brew shellenv zsh)"
autoload -Uz compinit && compinit

[ "$TERM_PROGRAM" = "Apple_Terminal" ] || eval "$(starship init zsh)"