CONSUL="$(which consul)"
[[ $? -eq 0 ]] && complete -C "$CONSUL" consul
