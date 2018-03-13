VAULT="$(which vault 2>/dev/null)"
[[ $? -eq 0 ]] && complete -C "$VAULT" vault
