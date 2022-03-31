source $HOME/.bashrc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/go@1.17/bin:$PATH"


if [ -d "/Library" ]; then
    # Setting PATH for Python 3.6
    export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
fi
