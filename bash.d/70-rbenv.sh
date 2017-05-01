# initialize rbenv if boxen isn't installed
if [[ -z "$BOXEN_HOME" ]]; then
  if which rbenv &> /dev/null; then
    eval "$(rbenv init -)"
  elif [[ -d "$HOME/.rbenv/bin" ]]; then
    PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
  fi
fi
