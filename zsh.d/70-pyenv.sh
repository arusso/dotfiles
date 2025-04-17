# Keep support for pyenv while we transition to uv entirely
if [[ ${PYENV_ENABLE:-0} -eq 1 ]]; then
  # initialize pyenv
  if [[ -z "$PYENV_ROOT" ]] && [[ -d $HOME/.pyenv ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
  fi
  :prependpath "$PYENV_ROOT/bin"
  :prependpath "$PYENV_ROOT/shims"

  if [[ $(:binexists pyenv) -eq 0 ]]; then
    if [[ $(:inpath "$PYENV_ROOT/shims") -eq 1 ]]; then
      eval "$(pyenv init --path --no-rehash -)"
      eval "$(pyenv virtualenv-init - 2>/dev/null)"
    fi
  fi

  pyenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
    activate|deactivate|rehash|shell)
      eval "$(pyenv "sh-$command" "$@")";;
    *)
      command pyenv "$command" "$@";;
    esac
  }
fi
