# load our zsh configs
READLINK=$(which readlink)
[[ "$(uname)" == "Linux" ]] && READLINK=($READLINK -e)

DOTFILES_DIR=$(dirname $($READLINK ~/.zshrc))

for file in "$DOTFILES_DIR"/zsh.d/*.sh; do
  . "$file"
done
