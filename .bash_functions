git_key() {
    eval `ssh-agent -s`
    ssh-add -k ~/.ssh/id_github
}

has_bin() {
    if command -v $1 >/dev/null; then
        return 0
    fi

    return 1
}
