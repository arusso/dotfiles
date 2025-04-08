DOTFILES_CONF_DIR=$HOME/.config/dotfiles

# Load our default config, and then a per-hostname configuration
for file in config config.$HOSTNAME; do
  [[ -f "${DOTFILES_CONF_DIR}/${file}" ]] && source "${DOTFILES_CONF_DIR}/${file}"
done
