#
# Go Language Configuration
GOPATH="$HOME/go"
GO=$(which go 2>/dev/null)
if [[ ! -z "$GO" ]]; then
  if [[ -d "$HOME/.goenv" ]]; then
    :prependpath "$HOME/.goenv/bin"
    GOENV_ROOT="$HOME/.goenv"
    [[ $(:inpath "$HOME/.goenv/shims") -eq 1 ]] && eval "$(goenv init -)"
  elif [[ -d "$GOPATH" ]] && [[ -x "$GO" ]]; then
    :prependpath "$(go env GOPATH)/bin"
  fi
fi

alias gg="go get -d"

export GO111MODULE=on
