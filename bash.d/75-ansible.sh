if [[ -d "$HOME/.pyenv" && `which python &>/dev/null; echo $?;` -eq 0 ]]; then
  export ANSIBLE_PYTHON_INTERPRETER=$HOME/.pyenv/shims/python
fi
