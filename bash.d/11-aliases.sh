
if [[ "$PLATFORM"  == "OSX" ]]; then
  alias ll='ls -hAlpG'
  alias lsusb='system_profiler SPUSBDataType'
  alias mygit='cd ~/git'
  alias truecrypt='/Applications/TrueCrypt.app/Contents/MacOS/Truecrypt --text'
else
  alias ll='ls -hAlp --color=auto'
fi

alias please='sudo !!'
alias vi='/usr/bin/vim'
alias mux='tmuxifier'
