#!/bin/bash

. ~/.bash_functions

configure_git() {
    if [ ! -e ~/.ssh/id_github ]; then
        echo 'Install ~/.ssh/id_github first'
        exit
    fi

    eval `ssh-agent -s`
    ssh-add -k ~/.ssh/id_github
}

configure_npm_packages() {
    echo 'npm install -g ...'
    npm install -g eslint omnivore-io/eslint-config.git gulp prettyjson
}

configure_vim() {
    mkdir -p ~/.vim/tmp
}


configure_vim
configure_git
configure_npm_packages
