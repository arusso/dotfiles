# figure out which platform we are on
case `uname` in
  Darwin)
    PLATFORM="OSX"
    ;;
  Linux)
    PLATFORM="Linux"
    ;;
  *)
    PLATFORM="Unknown"
    ;;
esac
export PLATFORM

# set our custom path
if [ -z "$CUSTOM_PATH_SET" ]; then
  export PATH="$HOME/bin:$PATH"
  export CUSTOM_PATH_SET=1
fi

# ignore commands that begin with whitespace, or that are duplicates
# note: we control flushing our history file after each command on 06-preexec.sh
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT="%d-%b-%Y %T "
export HISTSIZE=2500
export HISTFILESIZE=2500

# define our ansi color codes
Color_Off="\[\033[0m\]"
Red="\[\033[0;31m\]"
Green="\[\033[0;32m\]"
Purple="\[\033[0;35m\]"
BGreen="\[\033[1;32m\]"
BRed="\[\033[1;31m\]"
BPurple="\[\033[1;35m\]"

# set ls color scheme on OSX
export LSCOLORS="Exfxcxdxbxegedabagacad"
