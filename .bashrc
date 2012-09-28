# This file is launched whenever a terminal is opened
#PATH=/usr/local/bin:$PATH

# We'll create aliases and other functions that may be platform dependant
# here well define and ENV variable to use for this purpose
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

# generic aliases
alias dir='echo This is not Windows, Stupid.'
alias ll='ls -alh'

# OSX Specific Aliases
if [[ "$PLATFORM"  == "OSX" ]]; then
    alias desk='cd ~/Desktop'
    alias docs='cd ~/Documents'
    alias lsusb='system_profiler SPUSBDataType' # list usb devices
    alias mygit='docs; cd git'
    export LC_ALL="en_US.UTF-8"
fi

# exports
export PS1="\u@\h:\W\$ "  # custom prompt

# hourglass function
hourglass(){ trap 'tput cnorm' EXIT INT;local s=$(($SECONDS +$1));(tput civis;while [[ $SECONDS -lt $s ]];do for f in '|' '\' '-' '/';do echo -n "$f" && sleep .2s && echo -n $'\b';done;done;);tput cnorm;}

# runon function
# makes use of pubkey authentication to connect to a host, execute a command
# and display the results locally.
runon() { CLIENT=$1; COMMAND=$2; if [[ "$1" == "" || "$2" == "" ]]; then echo "USAGE: $0 <client> \"<command>\""; else ssh -a -T ${CLIENT} "$2"; fi }

# ff/ffs functions
# finds files of size $1 or greater.  Useful for tracking down fat files.
# ffs version runs sudo first.
ff() { find . -size +${1} -print0 | xargs -0 du -h; }
ffs() { sudo ff ${1}; }

if [[ "$PLATFORM"  == "OSX" ]]; then
  BASE64_BREAK="--break=0"
elif [[ "$PLATFORM" == "Linux" ]]; then
  BASE64_BREAK="-w 0"
else
  BASE64_BREAK=
fi

newpass() { read -s pass; echo $pass $(date) | shasum -a 512 | base64 ${BASE64_BREAK} | cut -c -30; }

# Lastly, lets import our 'private' definitions.  If items are redefined
# likes SSH_DOMAIN, etc.  Then these will be the ones to take precedence
. ~/.bashrc.private
