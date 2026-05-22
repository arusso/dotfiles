# alias definitions

# bsd vs gnu utilities
if type "eza" > /dev/null; then
  alias ls='eza --group-directories-first --icons --time-style=iso'
  alias ll='eza --group-directories-first -l --icons --time-style=iso'
elif [[ "$(uname)" == "Linux" ]]; then
  alias ls='ls --color=auto -ahF'
  alias ll='ls --color=auto -alhF'
else
  alias ls='ls -ahGF'
  alias ll='ls -alhGF'
fi
