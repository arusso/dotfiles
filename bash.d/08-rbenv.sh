# initialize rbenv if boxen isn't installed
if [[ -z "$BOXEN_HOME" ]]; then
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
fi
