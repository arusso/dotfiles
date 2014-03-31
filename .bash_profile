# This is launched on login
#PATH=~/bin:/usr/local/bin:$PATH

# Do we really want to maintain 2 files?
# No.
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
