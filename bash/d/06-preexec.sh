# This will run before any command is executed.
function PreCommand() {
  if [ -z "$AT_PROMPT" ]; then
    return
  fi
  unset AT_PROMPT

   # Do stuff.
   [[ $DISABLE_SSH_AGENT_SETUP -ne 1 && $USE_GPG_AGENT -eq 1 ]] && echo UPDATESTARTUPTTY | gpg-connect-agent 2>&1 >/dev/null

  # append new entries to histfile from histlist
  #history -a
  # clear our history file completely, then reload it
  #history -c
  #history -r
 }
trap "PreCommand" DEBUG

# This will run after the execution of the previous full command line.  We don't
# want it PostCommand to execute when first starting a bash session (i.e., at
# the first prompt).
FIRST_PROMPT=1
function PostCommand() {
  AT_PROMPT=1

  if [ -n "$FIRST_PROMPT" ]; then
    unset FIRST_PROMPT
    return
  fi
}
