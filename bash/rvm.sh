PATH=$PATH:$HOME/.rvm/bin
if [ $? -eq 0 ]; then
  RVM_LOADED=1
  export RVM_LOADED
fi
