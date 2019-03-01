# initialize rbenv if boxen isn't installed
if [[ -z "$BOXEN_HOME" ]]; then
  :prependpath "$HOME/.rbenv/bin"
  [[ $(:inpath "$HOME/.rbenv/shims") -eq 1 ]] && eval "$(rbenv init -)"
fi
