VAULT="$(which vault)"
[[ $? -eq 0 ]] && complete -C "$VAULT" vault
