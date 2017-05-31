# initialize pyenv
if [[ -z "$PYENV_ROOT" ]] && [[ -d $HOME/.pyenv ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
fi

which pyenv
if [[ $? -eq 0 ]]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
