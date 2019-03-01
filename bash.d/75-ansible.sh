if [[ -d "$HOME/.pyenv" && $(:binexists python) -eq 0 ]]; then
  export ANSIBLE_PYTHON_INTERPRETER=$HOME/.pyenv/shims/python
fi
