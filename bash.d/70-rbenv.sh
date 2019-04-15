# initialize rbenv if boxen isn't installed
if [[ -z "$BOXEN_HOME" ]]; then
  :prependpath "$HOME/.rbenv/bin"
  [[ $(:binexists rbenv) -eq 0 && $(:inpath "$HOME/.rbenv/shims") -eq 1 ]] && eval "$(rbenv init -)"
fi

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
