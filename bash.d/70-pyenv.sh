# initialize pyenv
if [[ -z "$PYENV_ROOT" ]] && [[ -d $HOME/.pyenv ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
fi
:prependpath "$PYENV_ROOT/bin"

which pyenv &>/dev/null
if [[ $? -eq 0 ]]; then
  if [[ $(:inpath "$HOME/.pyenv/shims") -eq 1 ]]; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init - 2>/dev/null)"
  fi
fi
