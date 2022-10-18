#
# Go Language Configuration
GOPATH="$HOME/go"
GO=$(which go 2>/dev/null)
if [[ -z "$GO" ]]; then
  if [[ -d "$HOME/.goenv" ]]; then
    # assume at this point goenv is installed. when installe with homebrew, the
    # executable is installed under /opt/homebrew/bin/goenv, so as long as
    # homebrew bin is in our path we don't need to add the goenv bindir (which
    # wont even exist).
    [[ -d "$HOME/.goenv/bin" ]] && :appendpath "$HOME/.goenv/bin"
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
    :appendpath "$(go env GOPATH)/bin"
  fi
fi

alias gg="go get -d"

func getgolint() {
  local version="${1:-latest}"
  go install golang.org/x/lint/golint@$version
}
