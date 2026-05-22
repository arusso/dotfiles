# load some stuff at the very end
[[ -f $HOME/.zshrc.post-init ]] && source "$HOME/.zshrc.post-init"

# initialize completions with compinit
autoload -Uz compinit && compinit
