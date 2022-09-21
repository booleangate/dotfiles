source $HOME/.bashrc

eval "$(/opt/homebrew/bin/brew shellenv)"

export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH="/opt/homebrew/opt/go@1.17/bin:$PATH"

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
. `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

if [ -d "$HOME/.nvm" ]; then 
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi


if [ -d "/Library" ]; then
    # Setting PATH for Python 3.6
    export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
fi
export PATH="/opt/homebrew/opt/mysql-client@5.7/bin:$PATH"
