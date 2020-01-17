#
# Go Language Configuration
GOPATH="$HOME/go"
GO=$(which go 2>/dev/null)
if [[ ! -z "$GO" ]]; then
  if [[ -d "$HOME/.goenv" ]]; then
    :prependpath "$HOME/.goenv/bin"
    GOENV_ROOT="$HOME/.goenv"
    [[ $(:inpath "$HOME/.goenv/shims") -eq 1 ]] && eval "$(goenv init -)"

    # enable shell integration
    goenv() {
      local command
      command="$1"
      if [ "$#" -gt 0 ]; then
        shift
      fi

      case "$command" in
      rehash|shell)
        eval "$(goenv "sh-$command" "$@")";;
      *)
        command goenv "$command" "$@";;
      esac
    }
  elif [[ -d "$GOPATH" ]] && [[ -x "$GO" ]]; then
    :prependpath "$(go env GOPATH)/bin"
  fi
fi

alias gg="go get -d"
