function sp() {
  if [[ "$1" == "powerline" || "$1" == "starship" || "$1" == "minimal" || "$1" == "simple" ]]; then
    PROMPTER=$1
  elif [[ -z "$1" ]]; then
    echo "usage: $0 <powerline|starship|minimal|simple>"
  else
    echo "I don't know about prompt '$1'"
  fi
}

(( ! ${+precmd_functions} )) && precmd_functions=()
(( ! ${+preexec_functions} )) && preexec_functions=()

function prompter_precmd() {
  rc=$?
  if [[ "$PROMPTER" == "powerline" ]]; then
    eval "$(powerline-go -error $rc $powerline_args $powerline_lmods $powerline_rmods $powerline_path_aliases)"
  elif [[ "$PROMPTER" == "starship" ]]; then
    setopt promptsubst
    STARSHIP="$(which starship)"
    PROMPT='$("${STARSHIP}" prompt --keymap="$KEYMAP" --status="$STARSHIP_CMD_STATUS" --cmd-duration="$STARSHIP_DURATION" --jobs="$STARSHIP_JOBS_COUNT")'
    RPROMPT=''

    # Save the status, because commands in this pipeline will change $?
    STARSHIP_CMD_STATUS=$rc

    # Compute cmd_duration, if we have a time to consume, otherwise clear the
    # previous duration
    if (( ${+STARSHIP_START_TIME} )); then
        __starship_get_time && (( STARSHIP_DURATION = STARSHIP_CAPTURED_TIME - STARSHIP_START_TIME ))
        unset STARSHIP_START_TIME
    else
        unset STARSHIP_DURATION
    fi

    # Use length of jobstates array as number of jobs. Expansion fails inside
    # quotes so we set it here and then use the value later on.
    STARSHIP_JOBS_COUNT=${#jobstates}
  elif [[ "$PROMPTER" == "minimal" ]]; then
    # minimal prompt used for screen share / 
    PROMPT="> "
    RPROMPT=''
  elif [[ "$PROMPTER" == "simple" ]]; then
    PROMPT="%n@%m %~ > "
    RPROMPT=''
  fi
}

prompter_preexec() {
  if [[ "$PROMPTER" == "starship" ]]; then
    __starship_get_time && STARSHIP_START_TIME=$STARSHIP_CAPTURED_TIME
  fi
}

function install_prompter_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "prompter_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(prompter_precmd)
}

# If starship precmd/preexec functions are already hooked, don't double-hook them
# to avoid unnecessary performance degradation in nested shells
if [[ -z ${precmd_functions[(re)prompter_precmd]} ]]; then
  precmd_functions+=(prompter_precmd)
fi
if [[ -z ${preexec_function[(re)prompter_preexec]} ]]; then
  preexec_functions+=(prompter_preexec)
fi

if [ "$TERM" != "linux" ]; then
  install_prompter_precmd
fi

## Powerline
powerline_lmods=(-modules venv,goenv,user,host,ssh,cwd,perms,jobs,exit,root)
powerline_rmods=(-modules-right git -eval)
powerline_path_aliases=(\~/src=@SRC)
powerline_path_aliases+=(\~/src/ansible=@ANSIBLE)
powerline_path_aliases=(-path-aliases $(:joinarr , $powerline_path_aliases))
powerline_args=(-shell zsh -numeric-exit-codes -colorize-hostname)

## Starship
# ZSH has a quirk where `preexec` is only run if a command is actually run (i.e
# pressing ENTER at an empty command line will not cause preexec to fire). This
# can cause timing issues, as a user who presses "ENTER" without running a command
# will see the time to the start of the last command, which may be very large.

# To fix this, we create STARSHIP_START_TIME upon preexec() firing, and destroy it
# after drawing the prompt. This ensures that the timing for one command is only
# ever drawn once (for the prompt immediately after it is run).

zmodload zsh/parameter  # Needed to access jobstates variable for STARSHIP_JOBS_COUNT

# Defines a function `__starship_get_time` that sets the time since epoch in millis in STARSHIP_CAPTURED_TIME.
if [[ $ZSH_VERSION == ([1-4]*) ]]; then
  # ZSH <= 5; Does not have a built-in variable so we will rely on Starship's inbuilt time function.
  __starship_get_time() {
    STARSHIP_CAPTURED_TIME=$("/usr/local/bin/starship" time)
  }
else
  zmodload zsh/datetime
  zmodload zsh/mathfunc
  __starship_get_time() {
    (( STARSHIP_CAPTURED_TIME = int(rint(EPOCHREALTIME * 1000)) ))
  }
fi

# Set up a function to redraw the prompt if the user switches vi modes
starship_zle-keymap-select() {
  zle reset-prompt
}

## Check for existing keymap-select widget.
# zle-keymap-select is a special widget so it'll be "user:fnName" or nothing. Let's get fnName only.
__starship_preserved_zle_keymap_select=${widgets[zle-keymap-select]#user:}
if [[ -z $__starship_preserved_zle_keymap_select ]]; then
  zle -N zle-keymap-select starship_zle-keymap-select;
else
  # Define a wrapper fn to call the original widget fn and then Starship's.
  starship_zle-keymap-select-wrapped() {
    $__starship_preserved_zle_keymap_select "$@";
    starship_zle-keymap-select "$@";
  }
  zle -N zle-keymap-select starship_zle-keymap-select-wrapped;
fi

__starship_get_time && STARSHIP_START_TIME=$STARSHIP_CAPTURED_TIME

export STARSHIP_SHELL="zsh"

# Set up the session key that will be used to store logs
STARSHIP_SESSION_KEY="$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM"; # Random generates a number b/w 0 - 32767
STARSHIP_SESSION_KEY="${STARSHIP_SESSION_KEY}0000000000000000" # Pad it to 16+ chars.
export STARSHIP_SESSION_KEY=${STARSHIP_SESSION_KEY:0:16}; # Trim to 16-digits if excess.

VIRTUAL_ENV_DISABLE_PROMPT=1
