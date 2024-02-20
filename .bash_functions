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

dump_k8s_env() {
    GOG
    K8S_NAMESPACE=jjohnson

    rm .tmp-envrc-all
    touch .tmp-envrc-all
    kubectl -n jjohnson get pods \
        | tail -n +2 \
        | cut -d' ' -f1 \
        | xargs -I {} kubectl -n $K8S_NAMESPACE exec {} -- printenv >> .tmp-envrc-all
    sort .tmp-envrc-all \
        | uniq \
        | grep -E "^((ACCOUNTS_)|(BRIDGE_)|(CLOUDPOS_)|(ES_)|(INFLUXDB_)|(LOGS_)|(MERCHANT_)|(MMS_)|(MMSI_)|(MYSQL_)|(OM_)|(REDIS_CLUSTER_)|(SCHEDULER_)|(STATSD_)|(TELEGRAF_)|(WEBHOOKS_))" \
        > .envrc-k8s-pods

    rm .tmp-envrc-all
    cd -
}
