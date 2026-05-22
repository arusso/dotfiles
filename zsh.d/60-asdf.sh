export ASDF_DATA_DIR="$HOME/.asdf"

if [[ ! -z "$(which asdf)" ]]; then
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

  if [[ ! -d "$ASDF_DATA_DIR/completions" ]]; then
    mkdir -p "$ASDF_DATA_DIR/completions"
    chown -R 0750 "$ASDF_DATA_DIR"
  fi
  if [[ ! -f "$ASDF_DATA_DIR/completions/_asdf" ]]; then
    asdf completion zsh > "$ASDF_DATA_DIR/completions/_asdf"
  fi
  fpath=("$ASDF_DATA_DIR/completions" $fpath)
  # handled at the end of our init scripts
  #autoload -Uz compinit && compinit
fi
