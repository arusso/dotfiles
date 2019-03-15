# load tmuxifier if it hasn't already been done
if test -z "$TMUXIFIER_INIT"; then
  INSTALLED=0
  [[ -d "$HOME/.tmuxifier" ]] && INSTALLED=1

  if [ $INSTALLED -eq 0 ]; then
    # download and install tmuxifier if we must
    git clone https://github.com/arusso/tmuxifier $HOME/.tmuxifier
  fi

  :appendpath "$HOME/.tmuxifier/bin"
  export TMUXIFIER_INIT=1
fi

# resume tmux when it accidentally gets backgrounded via ctrl-z
fix_tmux() { pkill -CONT tmux; }
