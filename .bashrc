[[ -L ~/.bashrc ]] &&  DOTFILES_DIR=$(dirname $(readlink ~/.bashrc)) \
  || DOTFILES_DIR=$(dirname ~/.bashrc)
export DOTFILES_DIR

. "$DOTFILES_DIR/bash/init.sh"
. "$DOTFILES_DIR/bash/colors.sh"
. "$DOTFILES_DIR/bash/aliases.sh"
. "$DOTFILES_DIR/bash/prompt.sh"
. "$DOTFILES_DIR/bash/functions.sh"
if [ "$RVM_LOADED" != "1" ]; then
  . "$DOTFILES_DIR/bash/rvm.sh"
fi
. "$DOTFILES_DIR/bash/vagrant.sh"
. "$DOTFILES_DIR/bash/complete.sh"

# Lastly, lets import our 'private' definitions.  If items are redefined
# likes SSH_DOMAIN, etc.  Then these will be the ones to take precedence
. ~/.bashrc.private
