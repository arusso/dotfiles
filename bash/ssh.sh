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
  GPG_TTY=$(tty); export GPG_TTY
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
}

fix_gpg_agent() {
  killall gpg-agent
  setup_gpg_agent
}

# check if we have gpg-agent installed, and use that in favor of ssh-agent when
# we can.
_gpg_agent=$(which gpg-agent)
if [ $? -eq 1 ] || [[ -f "$HOME/.use_ssh_agent" ]]; then
  setup_ssh_agent
else
  setup_gpg_agent
fi
