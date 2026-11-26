# mise manages language runtimes (go, node, python, ruby, terraform, ...).
# It replaces asdf and the *env tools. Those are kept below only as a fallback
# for hosts that don't have mise installed yet: each of them is skipped when
# DOTFILES_MISE=1.
#
# Settings (in ~/.config/dotfiles/config or config.$HOSTNAME):
#   DOTFILES_MISE_ENABLE: (Default: 1) set to 0 to ignore mise entirely
#   DOTFILES_MISE_SHIMS:  (Default: 0) use shims instead of `mise activate`
#                         (handy for editors/cron that don't run a prompt)
DOTFILES_MISE=0

if [[ ${DOTFILES_MISE_ENABLE:-1} -eq 1 ]] && (( $+commands[mise] )); then
  DOTFILES_MISE=1
  if [[ ${DOTFILES_MISE_SHIMS:-0} -eq 1 ]]; then
    eval "$(mise activate zsh --shims)"
  else
    eval "$(mise activate zsh)"
  fi
fi
