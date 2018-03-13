CONSUL="$(which consul 2>/dev/null)"
[[ $? -eq 0 ]] && complete -C "$CONSUL" consul
