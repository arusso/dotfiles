# mise manages language runtimes (go, node, python, ruby, terraform, ...).
# It replaces asdf and the *env tools. Those are kept below only as a fallback
# for hosts that don't have mise installed yet: each of them is skipped when
# RUNTIMES_VIA_MISE=1.
#
# Settings (in ~/.config/dotfiles/config or config.$HOSTNAME):
#   USE_MISE:       (Default: 1) set to 0 to ignore mise entirely
#   USE_MISE_SHIMS: (Default: 0) use shims instead of `mise activate`
#                   (handy for editors/cron that don't run a prompt)
RUNTIMES_VIA_MISE=0

if [[ ${USE_MISE:-1} -eq 1 ]] && (( $+commands[mise] )); then
  RUNTIMES_VIA_MISE=1
  if [[ ${USE_MISE_SHIMS:-0} -eq 1 ]]; then
    eval "$(mise activate zsh --shims)"
  else
    eval "$(mise activate zsh)"
  fi
fi
