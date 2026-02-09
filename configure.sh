#!/bin/bash

install_deps() {
    type brew &>/dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    [ -d /opt/homebrew/opt ] || brew install coreutils
    brew install terminal-notifier

    type node &> /dev/null|| brew install node
}

configure_git() {
    if [ ! -e ~/.ssh/id_github ]; then
        echo 'Install ~/.ssh/id_github first'
        exit
    fi

    eval `ssh-agent -s` > /dev/null
    ssh-add -q -k ~/.ssh/id_github
}

configure_vim() {
    mkdir -p ~/.vim/tmp
    mkdir -p ~/.vim/bundle
    mkdir -p ~/.vim/colors

    # install vundle
    vundle_dir="$HOME/.vim/bundle/Vundle.vim"
    [ ! -d ~/.vim/bundle/Vundle.vim ] && git clone --quiet https://github.com/gmarik/Vundle.vim.git "${vundle_dir}"
    cd "${vundle_dir}" || exit
    git pull --quiet
    cd - > /dev/null


    vim +PluginInstall +qall

    # install ycm
    ## see https://github.com/Valloric/YouCompleteMe#full-installation-guide
    # Uncomment this business if you need C-family auto-completion
    if ! command -v cmake >/dev/null; then
        brew install cmake
    fi
}

install_fonts() {
    for zip in configure/fonts/*.zip; do
        unzip -q -o $zip -d /Library/Fonts/
    done
}

install_starship() {
    # TODO: force install with FORCE
    if ! type starship &> /dev/null; then 
        curl -sS https://starship.rs/install.sh | FORCE=1 sh > /dev/null
        echo "🚀 Starship installed - Be sure to set your terminal font to one of the automatically installed Fira fonts."
        echo "Or, install a custom Nerd Font from https://www.nerdfonts.com/font-downloads."
    fi
}

update_shell() {
    # If in zsh, start a new shell
    if [ "$SHELL" = "/bin/zsh" ]; then
        exec zsh
    fi
}

install_deps
install_fonts
install_starship
configure_vim
configure_git
update_shell
