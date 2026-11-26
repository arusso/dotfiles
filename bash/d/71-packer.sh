if [[ $(:binexists packer) -eq 0 ]]; then
  # make sure we use a single packer cache directory so we can minimize the
  # space we take up
  export PACKER_CACHE_DIR="$HOME/.packer/cache"
  [[ ! -d "$PACKER_CACHE_DIR" ]] && mkdir -p "$PACKER_CACHE_DIR"
fi
