#
# Go Language Configuration
GOPATH="$HOME/go"
GO=$(which go 2>/dev/null)
if [[ ! -z "$GO" ]]; then
  GOENV="$(which goenv 2>/dev/null)"
  if [[ -x "$GOENV" ]] && [[ -d "$HOME/.goenv" ]]; then
    export GOENV_ROOT="$HOME/.goenv"
    :prependpath "$GOENV/bin"
    [[ $(:inpath "$HOME/.goenv/shims") -eq 1 ]] && eval "$(goenv init -)"
  elif [[ -d "$GOPATH" ]] && [[ -x "$GO" ]]; then
    :prependpath "$(go env GOPATH)/bin"
  fi
fi

alias gg="go get -d"

export GO111MODULE=on
