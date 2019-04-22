is_mac() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
		return 0
	fi

	return 1
}

is_ubuntu() {
    if [[ `uname -a | grep -i ubuntu | wc -l`  -gt 0 ]]; then
        return 0
    fi

    return 1
}

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

git_tag() {
    tag=$1
    force=$2
    git tag $force -a $tag -m $tag
    git push $force origin $tag
}
