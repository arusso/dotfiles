#
# Go Language Configuration
GOENV="$(which goenv 2>/dev/null)"
if [[ -x "$GOENV" ]] && [[ -d "$HOME/.goenv" ]]; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
elif [[ -d "$GO" ]]; then
  export PATH="$PATH:$(go env GOPATH)/bin"
fi
