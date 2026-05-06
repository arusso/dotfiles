# load our zsh configs
READLINK=$(which readlink)
[[ "$(uname)" == "Linux" ]] && READLINK=($READLINK -e)

DOTFILES_DIR=$(dirname $($READLINK ~/.zshrc))
[[ "$DOTFILES_DIR" != /* ]] && DOTFILES_DIR="$HOME/$DOTFILES_DIR"

for file in "$DOTFILES_DIR"/zsh.d/*.sh; do
  . "$file"
done
