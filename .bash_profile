source $HOME/.bashrc

export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
    . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

export GPG_TTY=$(tty)
