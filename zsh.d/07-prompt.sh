powerline_lmods=(-modules venv,goenv,user,host,ssh,cwd,perms,jobs,exit,root)
powerline_rmods=(-modules-right git -eval)
powerline_path_aliases=(\~/src=@SRC)
powerline_path_aliases+=(\~/src/ansible=@ANSIBLE)
powerline_path_aliases=(-path-aliases $(:joinarr , $powerline_path_aliases))
powerline_args=(-shell zsh -numeric-exit-codes -colorize-hostname)

function powerline_precmd() {
  eval "$(powerline-go -error $? $powerline_args $powerline_lmods $powerline_rmods $powerline_path_aliases)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi
