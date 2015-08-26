# if we have gpg-agent installed, and we don't see $HOME/.use_ssh_agent, then
# load gpg-agent. otherwise load ssh-agent
_gpg_agent=$(which gpg-agent)
if [ $? -eq 1 ] || [[ -f "$HOME/.use_ssh_agent" ]]; then
  export USE_GPG_AGENT=0
else
  export USE_GPG_AGENT=1
fi

setup_ssh_agent() {
  _ssh_auth_sock="$HOME/.ssh_auth_sock"
  _ssh_agent_info="$HOME/.ssh_agent_info"
  if test -L "$_ssh_auth_sock" && kill -0 $(head -n 1 "$_ssh_agent_info" | cut -d= -f2) 2>/dev/null; then
    . "$_ssh_agent_info"
  else
    eval $(ssh-agent -s -t 3600) >/dev/null
    rm -f $_ssh_auth_sock
    ln -sf $SSH_AUTH_SOCK $_ssh_auth_sock
    echo "SSH_AGENT_PID=$SSH_AGENT_PID" > $_ssh_agent_info
    echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> $_ssh_agent_info
  fi
  export SSH_AGENT_PID
  export SSH_AUTH_SOCK=$_ssh_auth_sock
}

setup_gpg_agent() {
  export GPG_TTY=$(tty)
  _gpg_agent_info="$HOME/.gpg_agent_info"
  _ssh_auth_sock="$HOME/.ssh_auth_sock"
  # test to see if we have an existing agent loaded, and load gpg-agent if not
  if test -f "$_gpg_agent_info" && kill -0 $(head -n 1 "$_gpg_agent_info" | cut -d: -f2) 2>/dev/null ; then
    eval $(< "$_gpg_agent_info")
  else
    eval $(gpg-agent --daemon --enable-ssh-support --write-env-file "$_gpg_agent_info")
  fi
  export GPG_AGENT_INFO
  rm -f $_ssh_auth_sock
  ln -sf $SSH_AUTH_SOCK $_ssh_auth_sock
  export SSH_AUTH_SOCK=$_ssh_auth_sock
  echo UPDATESTARTUPTTY | gpg-connect-agent &>/dev/null
}

restart_gpg_agent() {
  killall gpg-agent
  setup_gpg_agent
}

# TODO: figure out a better way to have gpg-agent track our tty. the benefit of
#       doing this in particular is we can guarantee that when we type ssh
#       *locally*, gpg-agent will ask for our pin on a pane that is local.
#       However, other tools that require us enter our pin, like gpg itself, can
#       still cause pinentry to try and launch on a pane that is ssh'd
#       somewhere. In fact, this almost guarantees it will. However, it's fairly
#       infrequent, so we'll take the tradeoff for now.
#
#       A solution I think may work is implementing the prexec pattern in bash,
#       which can run a command before each command. But for now, this should be
#       good enough.
#
#       https://github.com/rcaloras/bash-preexec
#ssh() {
#  if [ $USE_GPG_AGENT -eq 1 ]; then
#    # make sure we have the latest environment information
#    setup_gpg_agent
#    # update our TTY
#    echo UPDATESTARTUPTTY | gpg-connect-agent &>/dev/null
#  fi
#  # now we should ssh away
#  $(which ssh) "$@"
#}

if [ $USE_GPG_AGENT -eq 1 ]; then
  setup_gpg_agent
else
  setup_ssh_agent
fi

