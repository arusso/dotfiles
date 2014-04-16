# per-interactive shell startup file

# maintain an env variable to keep track of where we store our dotfiles
# we'll assume Darwin (OSX), and check for Linux as an after thought
READLINK=$(which readlink)
[[ "$(uname)" == "Linux" ]] && READLINK="$READLINK -e"
export READLINK

export DOTFILES_DIR=$(dirname $(readlink -e ~/.bashrc))

. "$DOTFILES_DIR/bash/init.sh"
. "$DOTFILES_DIR/bash/colors.sh"
. "$DOTFILES_DIR/bash/aliases.sh"
. "$DOTFILES_DIR/bash/prompt.sh"
. "$DOTFILES_DIR/bash/functions.sh"
. "$DOTFILES_DIR/bash/rvm.sh"
. "$DOTFILES_DIR/bash/heroku.sh"
. "$DOTFILES_DIR/bash/vagrant.sh"
. "$DOTFILES_DIR/bash/complete.sh"

# Lastly, lets import our 'private' definitions.  If items are redefined
# likes SSH_DOMAIN, etc.  Then these will be the ones to take precedence
. ~/.bashrc.private
