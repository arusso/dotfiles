# shell initialization file, launched for login shells

# per-host motd
HOSTSHORT="$(hostname -s)"
[[ -f "$HOME/.config/motd/${HOSTSHORT}" ]] && cat "$HOME/.config/motd/${HOSTSHORT}"

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
