export CLICOLOR=1
export EDITOR=vim

source ~/.aliases


# Go
[ -d "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"


# Bun
if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"

    # completions
    [ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"
fi

# Coreutils
if [ -d /opt/homebrew/opt/coreutils/ ]; then
    PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Zsh for Homebrew
if [ -d /opt/homebrew/bin/ ]; then
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

# Compinit
autoload -Uz compinit && compinit

# Starship
if type starship >/dev/null; then
    eval "$(starship init zsh)"
else 
    echo "Starship not found"
fi