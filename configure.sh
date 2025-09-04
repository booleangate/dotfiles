#!/bin/bash

. ~/.bash_functions

configure_deps() {
    if ! has_bin 'brew'; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    has_bin 'node' || brew install node

    if [ ! -d /usr/local/opt/coreutils ]; then
        brew install coreutils
    fi
}

configure_git() {
    if [ ! -e ~/.ssh/id_github ]; then
        echo 'Install ~/.ssh/id_github first'
        exit
    fi

    eval `ssh-agent -s`
    ssh-add -k ~/.ssh/id_github
}

configure_vim() {
    mkdir -p ~/.vim/tmp
    mkdir -p ~/.vim/bundle
    mkdir -p ~/.vim/colors
    install_vim_vundle
    vim +PluginInstall +qall
    install_vim_ycm
}

install_vim_vundle() {
    [ ! -d ~/.vim/bundle/Vundle.vim ] && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cd ~/.vim/bundle/Vundle.vim
    git pull
    cd -
}

install_vim_ycm() {
    ## see https://github.com/Valloric/YouCompleteMe#full-installation-guide
    # Uncomment this business if you need C-family auto-completion
    if ! command -v cmake >/dev/null; then
        brew install cmake
    fi
}

configure_deps
configure_vim
configure_git
