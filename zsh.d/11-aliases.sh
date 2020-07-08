# alias definitions

# bsd vs gnu utilities
if [[ "$(uname)" == "Linux" ]]; then
  alias ls='ls --color=auto -ahF'
  alias ll='ls --color=auto -alhF'
else
  alias ls='ls -ahGF'
  alias ll='ls -alhGF'
fi
