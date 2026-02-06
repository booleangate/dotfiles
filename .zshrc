autoload -Uz compinit
compinit

source ~/.functions
source ~/.aliases

eval "$(starship init zsh)"

# Go
export PATH="$HOME/go/bin:$PATH"
