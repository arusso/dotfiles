export KUBECONFIG_DIR=$HOME/.kube/configs

# ensure krew is in our path if installed
if [[ "$HOME/.krew" ]]; then
  :appendpath "$HOME/.krew/bin"
fi
