#
# Go Language Configuration
GO=$(which go)
GOENV="$(which goenv 2>/dev/null)"
GOPATH="$HOME/go"
if [[ -x "$GOENV" ]] && [[ -d "$HOME/.goenv" ]]; then
  export GOENV_ROOT="$HOME/.goenv"
  :appendpath "$GOENV/bin"
  #export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
elif [[ -d "$GOPATH" ]] && [[ -x "$GO" ]]; then
  #export PATH="$PATH:$(go env GOPATH)/bin"
  :appendpath "$(go env GOPATH)/bin"
fi

alias gg="go get -d"

export GO111MODULE=on
