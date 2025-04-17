# initialize nodenv
if [[ -z "$NODENV_ROOT" ]] && [[ -d $HOME/.nodenv ]]; then
  export NODENV_ROOT="$HOME/.nodenv"
fi
:prependpath "$NODENV_ROOT/bin"

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
