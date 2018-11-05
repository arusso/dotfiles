if [[ $SHIM_DOCKER_ENABLE -eq 1 && $(which docker 2>/dev/null) ]]; then
  docker ()
  {
    [[ $UID -ne 0 ]] && DOCKER="sudo docker" || DOCKER="docker";
    $DOCKER $@
  }
fi
