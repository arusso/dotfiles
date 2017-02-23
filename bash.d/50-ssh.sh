# Variable: SSH_AGENT_MODE
#
# Select your operation mode. One of 'client', 'bastion' or 'none',
#
# Determine how to setup your local agent. If set to 'client', it will ensure
# that your the agent (as determined by SSH_AGENT_NAME) is launched and ready
# for operation. If set to 'bastion', will simply setup the environment to use a
# consistent SSH_AUTH_SOCK to avoid breakage across multiple sessions but will
# not setup any agent. If set to 'none', this code is entirely skipped.
export SSH_AGENT_MODE=${SSH_AGENT_MODE:=bastion}

# Variable: SSH_AGENT_NAME
#
# Select your SSH Agent. One of 'ssh-agent', 'gpg-agent', or 'none'.
#
export SSH_AGENT_NAME=${SSH_AGENT_NAME:=gpg-agent}

# Variable: SSH_AGENT_CACHE_TTL
#
# Set a TTL on cache entries for your SSH agent.
export SSH_AGENT_CACHE_TTL=${SSH_AGENT_CACHE_TTL:=1800}

# Variable: SSH_AGENT_SSH_AUTH_SOCK
#
# Set the location of the centralized SSH_AUTH_SOCK_FILE.
export SSH_AGENT_SSH_AUTH_SOCK="${SSH_AGENT_SSH_AUTH_SOCK:=$HOME/.ssh_auth_sock}"

# Function: setup_ssh_env
#
# Setup SSH environment such that a consistent .ssh_auth_sock file is used. This
# prevents breakage of agent forwarding when using terminal multiplexors like
# tmux and screen.
setup_ssh_env() {
  if [[ $SSH_AUTH_SOCK != "$SSH_AGENT_SSH_AUTH_SOCK" ]]; then
    rm -f $SSH_AGENT_SSH_AUTH_SOCK
    ln -sf $SSH_AUTH_SOCK $SSH_AGENT_SSH_AUTH_SOCK
    export SSH_AUTH_SOCK=$SSH_AGENT_SSH_AUTH_SOCK
  fi
}

# Function: setup_ssh_agent
#
# Setup the standard agent, ssh-agent.
setup_ssh_agent() {
  _ssh_agent_info="$HOME/.ssh_agent_info"
  if test -L "$SSH_AGENT_SSH_AUTH_SOCK" && kill -0 $(head -n 1 "$_ssh_agent_info" | cut -d= -f2) 2>/dev/null; then
    . "$_ssh_agent_info"
  else
    eval $(ssh-agent -s -t $SSH_AGENT_CACHE_TTL) >/dev/null
    setup_ssh_env
    echo "SSH_AGENT_PID=$SSH_AGENT_PID" > $_ssh_agent_info
    echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> $_ssh_agent_info
  fi
  export SSH_AGENT_PID
}

# Function: setup_gpg_agent
#
# Setup gpg-agent w/ssh-support.
setup_gpg_agent() {
  export GPG_TTY=$(tty)
  _gpg_agent_info="$HOME/.gpg_agent_info"
  # test to see if we have an existing agent loaded, and load gpg-agent if not
  if test -f "$_gpg_agent_info" && kill -0 $(head -n 1 "$_gpg_agent_info" | cut -d: -f2) 2>/dev/null ; then
    eval $(< "$_gpg_agent_info")
  else
    eval $(gpg-agent --daemon --enable-ssh-support --write-env-file "$_gpg_agent_info" --default-cache-ttl-ssh $SSH_AGENT_CACHE_TTL)
  fi
  export GPG_AGENT_INFO
  setup_ssh_env
  echo UPDATESTARTUPTTY | gpg-connect-agent &>/dev/null
}

# Function: restart_gpg_agent
#
#
# Restart a hosed gpg-agent
restart_gpg_agent() {
  killall gpg-agent
  setup_gpg_agent
}

# Initialize SSH Environment
if [[ $SSH_AGENT_MODE == "bastion" ]]; then
  # no keys on bastions, so disable agents
  export SSH_AGENT_NAME="none"
fi

if [ $SSH_AGENT_NAME == "gpg-agent" ]; then
  # If gpg-agent doesn't exist, send a note and fallback to no agent
  GPG_AGENT=$(which gpg-agent)
  if [[ -z $GPG_AGENT ]]; then
    echo "Warning: gpg-agent not installed! Setting SSH_AGENT_NAME=none"
    export SSH_AGENT_NAME="none"
  fi
  echo "Initializing session to use gpg-agent..."

elif [ $SSH_AGENT_NAME == "ssh-agent" ]; then
  # Do we need to do anything?
  echo "Initializing session to use ssh-agent..."

elif [ $SSH_AGENT_NAME != "none" ]; then
  echo "Invalid SSH_AGENT_NAME (${SSH_AGENT_NAME}). Setting to 'none'"
  export SSH_AGENT_NAME="none"
fi

if [[ $SSH_AGENT_NAME == 'none' ]]; then
  echo "Initializing ssh environment in ${SSH_AGENT_MODE} mode, using no agent"
else
  echo "Initializing ssh environment in ${SSH_AGENT_MODE} mode, using agent ${SSH_AGENT_NAME}"
fi

if [ $SSH_AGENT_MODE == 'client' ]; then
  if [ $SSH_AGENT_NAME == 'gpg-agent' ]; then
    setup_gpg_agent
  elif [ $SSH_AGENT_NAME == 'ssh-agent' ]; then
    setup_ssh_agent
  fi
elif [ $SSH_AGENT_MODE == 'bastion' ]; then
  setup_ssh_env
fi
