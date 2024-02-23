if [[ -d "$HOME/.tenv" ]]; then
  :prependpath "$HOME/.tenv/bin"
  TENV_ROOT="$HOME/.tenv"
else
  if [[ -d "$HOME/.tofuenv" ]]; then
    # we want this to outrank any system install versions
    :prependpath "$HOME/.tofuenv/bin"
    TOFUENV_ROOT="$HOME/.tofenv"
  fi

  if [[ -d "$HOME/.tfenv" ]]; then
    :prependpath "$HOME/.tfenv/bin"
    TFENV_ROOT="$HOME/.tfenv"
  fi
fi
