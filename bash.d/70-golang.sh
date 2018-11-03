#
# Go Language Configuration

export GOPATH="$HOME/go"
export PATH="$PATH:$(go env GOPATH)/bin"

# configure goenv
if [ -d "$HOME/.goenv" ] && [ "$(which goenv 2>/dev/null)" != "" ]; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
fi
