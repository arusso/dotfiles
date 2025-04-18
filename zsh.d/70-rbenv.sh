if [[ ${RBENV_ENABLE:-0} -eq 1 ]]; then
  export RBENV_ROOT="${RBENV_ROOT:-$HOME/.rbenv}"
  export RBENV_SHELL=zsh
  source "$RBENV_ROOT/completions/rbenv.zsh"

  :appendpath "$RBENV_ROOT/shims"
  :appendpath "$RBENV_ROOT/bin"
  #[[ $(:binexists rbenv) -eq 0 && $(:inpath "$HOME/.rbenv/shims") -eq 1 ]] && eval "$(rbenv init -)"


  rbenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
      rehash|shell)
        eval "$(rbenv "sh-$command" "$@")";;
      *)
        command rbenv "$command" "$@";;
    esac
  }
fi
