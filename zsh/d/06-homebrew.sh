# I don't always use homebrew, but when I do I tend to have a ton of updates
# and a 10 second install often turns into a 30m upgrade.
if [[ "$PLATFORM" == "OSX" ]]; then
  HOMEBREW_NO_AUTO_UPDATE=1
  HOMEBREW_NO_ENV_HINTS=1

  # On Apple Silicon, homebrew has a new path
  if [[ "$(uname -p)" == 'arm' && -d '/opt/homebrew' ]]; then
    :appendpath '/opt/homebrew/bin'
  fi
fi
