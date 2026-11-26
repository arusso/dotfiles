if [[ ${GOENV_ENABLE:-1} -eq 1 ]]; then
  GOPATH="$HOME/go"
  GO=$(which go 2>/dev/null)
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
  fi
fi
