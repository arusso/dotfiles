# Somehow I have come to a place where I can't really operate w/vim key bindings
# in my shell, and must resort to forcing emacs key bindings. Shame.
bindkey -e

# Setup keybindings since zsh doesn't use readline bindings and thus doesn't
# honor /etc/inputrc / ~/.inputrc
#
# moreinfo: https://wiki.archlinux.org/index.php/Zsh#Key_bindings
typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"


[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
