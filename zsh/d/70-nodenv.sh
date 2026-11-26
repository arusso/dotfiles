# nodenv is only a fallback for hosts without mise (see 06-mise.sh)
if [[ $RUNTIMES_VIA_MISE -eq 0 ]]; then
  # initialize nodenv
  if [[ -z "$NODENV_ROOT" ]] && [[ -d $HOME/.nodenv ]]; then
    export NODENV_ROOT="$HOME/.nodenv"
  fi

  if [[ ! -z "$NODENV_ROOT" ]]; then
    :appendpath "$NODENV_ROOT/bin"
    :appendpath "$NODENV_ROOT/shims"

    export NODENV_SHELL=zsh
    source "$NODENV_ROOT/libexec/../completions/nodenv.zsh"
    command nodenv rehash 2>/dev/null
    nodenv() {
      local command
      command="${1:-}"
      if [ "$#" -gt 0 ]; then
        shift
      fi

      case "$command" in
      rehash|shell)
        eval "$(nodenv "sh-$command" "$@")";;
      *)
        command nodenv "$command" "$@";;
      esac
    }
  fi
fi
