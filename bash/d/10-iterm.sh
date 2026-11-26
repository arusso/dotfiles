if [[ "$PLATFORM" == "OSX" ]]; then
  set_iterm_profile() {
    local profile="$1"
   echo -e "\033]50;SetProfile=${profile}\a"
  }
fi
