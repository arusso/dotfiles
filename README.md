# dotfiles

Personal and work shell/editor configuration for macOS and Enterprise Linux
(zsh primary, a minimal bash). One repo, one deploy tool ([mise](https://mise.jdx.dev)):

* **`mise dot`** links the files in this repo into `$HOME` (see `mise.toml`).
* **`mise`** installs language runtimes (go, node, python, ...), replacing
  asdf/pyenv/rbenv/nodenv/goenv/tenv.

## Layout

```
mise.toml        what gets linked where (the source of truth for deployment)
mise.<env>.toml  optional per-role overlays, used with `mise -E <env>`
zsh/             zshrc, d/ (numbered init snippets), func/, completion/
bash/            bashrc, bash_profile, profile, d/ (older, minimal)
git/             gitconfig, gitignore, commit-template, mailmap, bin/ (git-*)
vim/  nvim/      vimrc + ftplugin; Neovim (lazy.nvim, see nvim/README.md)
tmux/  ghostty/  terminal config
starship/ atuin/ prompt and shell history
gnupg/ misc/     gpg.conf; curlrc, gemrc, inputrc
```

## Install on a new machine

```sh
git clone <repo> ~/cfg && cd ~/cfg
# install mise: `brew install mise` (macOS) or `curl https://mise.run | sh` (Linux)
mise trust
mise dot apply --dry-run     # review
mise dot apply               # add --force if default files (~/.bashrc, ...) exist
```

`apply` refuses to overwrite existing files unless you pass `--force`, so on a
fresh EL host expect to need it for the stock `~/.bashrc`, `~/.bash_profile`
and `~/.profile`. Re-running `apply` is safe.

Open a new shell afterwards. Runtimes come from mise: add them to
`~/.config/mise/config.toml` (`mise use -g go@1.27`).

## Per-host and per-role differences

There are two layers; use whichever fits:

1. **Shell settings**: `~/.config/dotfiles/config`, then
   `~/.config/dotfiles/config.$HOSTNAME`, are sourced early, so they can set
   any option below. `~/.zshrc.post-init` is sourced last for anything else
   (aliases, PATH additions).
2. **Whole files**: add `mise.<env>.toml` next to `mise.toml` and deploy with
   `mise -E <env> dot apply` to link or write extra/different files for a role.

## Options

Set these in `~/.config/dotfiles/config` (or `config.$HOSTNAME`):

| Variable | Default | Effect |
|---|---|---|
| `USE_MISE` | `1` | `0` ignores mise and uses the legacy *env tools if present |
| `USE_MISE_SHIMS` | `0` | `1` uses mise shims instead of `mise activate` |
| `PROMPT_SIMPLE` | `0` | simple prompt |
| `PROMPT_BATTERY_STATUS` | `1` | battery on prompt (hosts with a battery) |
| `PROMPT_NONZERO_RC` / `PROMPT_ZERO_RC` | `[✘]` / `[✓]` | exit status markers |
| `SSH_AGENT_MODE` | `bastion` | SSH agent behaviour |
| `SSH_AGENT_NAME` | `gpg-agent` | which agent to use |
| `SSH_AGENT_SSH_AUTH_SOCK` | `$HOME/.ssh_auth_sock` | `SSH_AUTH_SOCK` value |
| `SSH_AGENT_CACHE_TTL` | `1800` | agent key cache, seconds |
| `PYENV_ENABLE` / `RBENV_ENABLE` / `GOENV_ENABLE` | `0` / `0` / `1` | legacy fallbacks, only used when mise is absent |
| `ATUIN_ENABLE` | `1` | shell history via atuin |

## How shell startup works

`~/.zshrc` -> `zsh/zshrc` finds the repo root by resolving its own symlink
(`DOTFILES_DIR`), then sources `zsh/d/*.sh` in filename order. The numeric
prefix is the load order: `02` config, `05` init/PATH, `07` prompt, `2x`
git/fzf, `50` ssh, `70`+ tools (`70-mise` activates mise), `90` atuin,
`99` post-init (`~/.zshrc.post-init`, then `compinit`). `bash/bashrc` does the
same for `bash/d`.

## Notes

* Legacy runtime managers (`zsh/d/70-{pyenv,rbenv,nodenv}.sh`, goenv in
  `71-golang.sh`, tenv/tfenv in `71-terraform.sh`) only run when mise is
  missing. Delete them once every host has mise.
* `mise dot` is new; if it changes under you, `mise.toml` is a plain
  source/target map that ports easily to other tools.
