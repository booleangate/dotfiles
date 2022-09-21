source $HOME/.bashrc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/go@1.17/bin:$PATH"

if [ -d "$HOME/.nvm" ]; then 
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi


if [ -d "/Library" ]; then
    # Setting PATH for Python 3.6
    export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
fi
