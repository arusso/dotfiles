if [[ $SHIM_DOCKER_ENABLE -eq 1 && $(:binexists docker) -eq 0 ]]; then
  docker ()
  {
    [[ $UID -ne 0 ]] && DOCKER="sudo docker" || DOCKER="docker";
    $DOCKER $@
  }
fi
