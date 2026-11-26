if [[ $(:binexists vagrant) -eq 0 ]]; then
  alias v='vagrant'
  alias vd='vagrant destroy'
  alias vu='vagrant up'
  alias vs='vagrant ssh'
fi
