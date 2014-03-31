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
  if [ "$SIMPLE_PROMPT" == "1" ]; then
    PS1="\u@\h\W \$ "
  else
    PS1="$(__ps1_rc) $Color_Off\
\u@\h:\W \
$(__ps1_git_prompt)\
\$ "
  fi
}

PROMPT_COMMAND=__get_ps1_prompt
