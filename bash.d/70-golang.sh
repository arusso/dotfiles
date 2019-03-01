#
# Go Language Configuration
GO=$(which go)
GOENV="$(which goenv 2>/dev/null)"
GOPATH="$HOME/go"
if [[ -x "$GOENV" ]] && [[ -d "$HOME/.goenv" ]]; then
  export GOENV_ROOT="$HOME/.goenv"
  :prependpath "$GOENV/bin"
  [[ $(:inpath "$HOME/.goenv/shims") -eq 1 ]] && eval "$(goenv init -)"
elif [[ -d "$GOPATH" ]] && [[ -x "$GO" ]]; then
  :prependpath "$(go env GOPATH)/bin"
fi

alias gg="go get -d"

export GO111MODULE=on
