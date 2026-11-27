# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal + work dotfiles for **macOS and Enterprise Linux (EL)**, zsh-first with a minimal bash. Changes must not break either platform: guard platform- or tool-specific behavior (`$PLATFORM` is `OSX`/`Linux`; check `(( $+commands[tool] ))` before using a tool). Deployment and runtimes are both handled by [mise](https://mise.jdx.dev); see README.md for the user-facing docs.

## Layout

```
mise.toml          dotfile map for `mise dot` (target -> source). Source of truth for deployment.
mise.<env>.toml    optional overlays, e.g. mise.work.toml, used with `mise -E <env> dot ...`
mise/              global mise config: mise.toml (tools, all hosts; macOS-only brew packages use `os = ["macos"]`)
zsh/               zshrc, d/ (numbered init snippets), func/ (fpath), completion/
bash/              bashrc, bash_profile, profile, d/ (older/minimal; not the primary shell)
git/               gitconfig, gitignore, commit-template, git-completion.bash, bin/ (git-* scripts)
.mailmap           this repo's author mapping (git only reads it from the repo root)
nvim/  vim/  tmux/  ghostty/  starship/  atuin/  gnupg/  misc/   per-tool config
```

Files are symlinked into `$HOME` by `mise dot`; edit the repo copy, never the link target path in `$HOME`. To add a new dotfile, put it in the repo and add an entry to `mise.toml`.

## Shell startup (zsh)

`~/.zshrc` -> `zsh/zshrc` resolves its own symlink to find `DOTFILES_DIR` (the repo root), then sources `zsh/d/*.sh` **in filename order**; the number is the load order:

- `02` config (`~/.config/dotfiles/config`, then `config.$HOSTNAME`), `03` helper functions (`:appendpath`, `:prependpath`, `:inpath`, `:binexists`)
- `05` init/PATH (on macOS it wipes and rebuilds `PATH`), `06` Homebrew PATH then **mise activation** (so every later file sees tools mise installs), `07` prompt
- `11` aliases, `2x` git/fzf, `50` ssh, `70`+ legacy runtime fallbacks, `90` atuin, `99` post-init (`~/.zshrc.post-init`, then `compinit`)

When adding a file, pick a number that comes after anything it depends on. A tool check like `type foo` only works if `foo` is already on `PATH` at that point.

### Runtimes

mise provides go, node, python, rust, uv, kubectl, fzf, eza, etc. (`mise/mise.toml`; `mise use -g <tool>` edits it through the symlink). The old version managers (`zsh/d/70-{pyenv,rbenv,nodenv}.sh`, goenv in `71-golang.sh`, tenv/tfenv in `71-terraform.sh`) run only when `RUNTIMES_VIA_MISE=0`, i.e. a host without mise. mise accepts exact versions, prefixes (`"3.12"`) and `latest`, not `>=` ranges.

### Settings (in `~/.config/dotfiles/config` or `config.$HOSTNAME`)

- `USE_MISE=0` ignore mise; `USE_MISE_SHIMS=1` use shims instead of `mise activate`
- `PROMPT_SIMPLE=1`, `PROMPT_BATTERY_STATUS=0`, `PROMPT_NONZERO_RC` / `PROMPT_ZERO_RC`
- `SSH_AGENT_MODE=bastion` (default), `SSH_AGENT_NAME=gpg-agent` (default) or `ssh-agent`, `SSH_AGENT_CACHE_TTL=1800`
- `ATUIN_ENABLE`, `PYENV_ENABLE`, `RBENV_ENABLE`, `GOENV_ENABLE` (legacy fallbacks)

Per-host/per-role differences go in those config files (shell-level) or a `mise.<env>.toml` overlay (whole files). Do not hardcode host names in the repo.

## Neovim Architecture

**Entry point**: `nvim/init.lua` loads:
1. `config/options.lua` - Global options (leader keys, tab settings, clipboard)
2. `config/keymaps.lua` - Keybindings
3. `config/lazy.lua` - Bootstraps lazy.nvim and imports plugins

**Plugin system**: lazy.nvim manages plugins from `plugins/`:
- `lsp.lua` - LSP configuration (lua_ls, ansiblels, etc.)
- `languages.lua` - Language plugins (vim-go, ansible-vim, vim-terraform, rust.vim)
- `formatting.lua` - Format-on-save
- `ui.lua` - nvim-tree, Comment.nvim
- `git.lua`, `solarized.lua`

**Key configuration**: leader `-`, 2-space tabs, clipboard `unnamedplus`, colorscheme solarized.nvim.

## Testing and verification

No test suite. Validate by hand:

- Syntax: `zsh -n zsh/d/<file>.sh` for each changed zsh file (don't use `bash -n` on zsh files).
- Real shell: `TERM=xterm zsh -ic '<check>'`. Note `~/.zshrc` points at the main checkout, so to test a worktree use a throwaway `ZDOTDIR` whose `.zshrc` sets `DOTFILES_DIR` and sources the worktree's `zsh/d/*.sh`.
- Deployment: `mise -C <repo> dot apply --dry-run`. `mise dot` reads `mise.toml` only from the repo dir, hence `-C`.
- Linux/EL: test in a throwaway container, e.g. `podman run --rm -v "$PWD":/src:ro,Z rockylinux:9 ...` (install zsh, copy the repo, install mise via `curl https://mise.run | sh`, run `mise dot apply --force`, start a shell). The stock image has no `which`.

## Gotchas

- `mise dot apply` refuses to overwrite existing files without `--force` (EL ships default `~/.bashrc` etc.).
- Run `mise use` without `-g` inside this repo and it edits the repo's dotfile `mise.toml`; use `-g` for global tools.
- Never `git add -A` here without checking `git status`: untracked local files may be present.
- A rollback script for the original (pre-mise) symlink layout lives in `~/.config/dotfiles/backups/pre-mise/` on the main Mac only.
