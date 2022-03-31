if is_ubuntu; then
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt-get update
    sudo apt-get install vim vim-nox
elif is_mac; then
    brew update
    brew upgrade vim
else
    echo 'Ya, but how?'
    exit 1
fi
