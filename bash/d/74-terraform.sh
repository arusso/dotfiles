
if [[ $(:binexists terraform) -eq 0 ]]; then
  alias tf="terraform"
  complete -C "$(which terraform)" terraform
fi
