autoload -Uz compinit
compinit

source ~/.functions
source ~/.aliases

eval "$(starship init zsh)"

# Go
export PATH="$HOME/go/bin:$PATH"

# bun completions
[ -s "${HOME}/.bun/_bun" ] && source "/Users/jjohnson/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
