# initialize rbenv if boxen isn't installed
if [[ -z "$BOXEN_HOME" ]]; then
  :prependpath "$HOME/.rbenv/bin"
  [[ $(:binexists rbenv) -eq 0 && $(:inpath "$HOME/.rbenv/shims") -eq 1 ]] && eval "$(rbenv init -)"
fi
