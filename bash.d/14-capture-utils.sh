# utility functions for capturing terminal output w/timing info
CAPROOT="$HOME/.captures"


capture_terminal() {
  [[ -d "$CAPROOT" ]] || mkdir -p "$CAPROOT"

  CAPNAME=${1-capture-$(date +%s)}
  CAPDIR="$CAPROOT/$CAPNAME"
  if [[ -d "$CAPDIR" ]]; then
      echo "capture ${CAPNAME} already exists!" >&2
      return 1
  else
     mkdir "$CAPDIR"
  fi

  TIMEFILE="$CAPDIR/time.txt"
  CAPFILE="$CAPDIR/script.log"


  echo "Beginning capture ${CAPNAME}. Type 'exit' to complete!"
  script --timing="$TIMEFILE" "$CAPFILE" -q
}

capture_playback() {
  CAPNAME="$1"
  CAPDIR="$CAPROOT/$CAPNAME"

  if [[ -d "$CAPDIR" ]]; then
    scriptreplay -t "$CAPDIR"/time.txt "$CAPDIR"/script.log
  else
    echo "capture $CAPNAME not found"
  fi
}

capture_list() {
  echo "Available Captures":
  echo
  ls -1 "$CAPROOT" | sed 's/\/$//'
}
