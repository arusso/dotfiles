function __ps1_rc() {
  if [ $? -eq 0 ]; then
    echo -en "$BGreen[✓]$Color_Off"
  else
    echo -en "$BRed[✘]$Color_Off"
  fi
}

function __ps1_git_prompt() {
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      local Color_On=$Green
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      local Color_On=$Purple
    else
      local Color_On=$Red
    fi

    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
    else
      # Detached HEAD. (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
    fi

    echo -en "$Color_On[$branch]$Color_Off "
  fi
}

function __get_ps1_prompt() {
  PS1="$(__ps1_rc) \u@\h:\W $(__ps1_git_prompt)\$ "
  if [ "$SIMPLE_PROMPT" == "1" ]; then
    PS1="\u@\h:\W \$ "
  fi
  # if we are using our GPG_AGENT, we should setup the startup TTY each time we
  # set our prompt. This is a hacky way of having the gpg-agent follow us, since
  # it requires we redraw the prompt (by hitting enter first) for it to follow
  # us. The better solution, (see bash/ssh.sh) requires a bit more hackery that
  # im not quite ready to commit to.
  [[ $USE_GPG_AGENT -eq 1 ]] && echo UPDATESTARTUPTTY | gpg-connect-agent 2>&1 >>/tmp/gpg-connect-agent
}

PROMPT_COMMAND=__get_ps1_prompt
