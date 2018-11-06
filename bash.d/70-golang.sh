#
# Go Language Configuration

export GOPATH="$HOME/go"
GO="$(which go 2>/dev/null)"

if [ "$GO" != "" ]; then
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

# configure goenv
#if [ -d "$HOME/.goenv" ] && [ "$(which goenv 2>/dev/null)" != "" ]; then
#  export GOENV_ROOT="$HOME/.goenv"
#  export PATH="$GOENV_ROOT/bin:$PATH"
#  eval "$(goenv init -)"
#fi
