# only try to initialize tmuxifier if we haven't done so before
if [ "$TMUXIFIER_INIT" == "" ]; then
  INSTALLED=0
  [[ -d "$HOME/.tmuxifier" ]] && INSTALLED=1

  if [ $INSTALLED -eq 0 ]; then
    # download and install tmuxifier if we must
    git clone https://github.com/arusso/tmuxifier $HOME/.tmuxifier
  fi

  export PATH="$HOME/.tmuxifier/bin:$PATH"
  export TMUXIFIER_INIT=1
fi
