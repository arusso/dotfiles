# This is launched on login
PATH=/usr/local/bin:$PATH

# Do we really want to maintain 2 files?
# No.
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
