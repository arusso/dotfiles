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

if [ -z "$CUSTOM_PATH_SET" ]; then
  PATH=~/bin:~/local/bin:/usr/local/bin:$PATH
  CUSTOM_PATH_SET=1
  export CUSTOM_PATH_SET
fi
HISTCONTROL=ignoreboth
export HISTCONTROL
