## Introduction

Welcome to my dotfiles. I try to keep them tidy, but you know, they are just
'aight. They're largely bash, vim, git and tmux centric.

## Highlights

* Supports gpg-agent as an alternative to ssh-agent when installed
* Displays battery percentage on OSX for Systems with a battery installed

## Configuration

The behavior of our environment can be controlled by setting any one of these
variables in `$HOME/.config/dotfiles/config`

* **PROMPT_SIMPLE**: (Default: 0) Use a simple prompt
* **PROMPT_BATTERY_STATUS**: (Default: 1) On supported hosts, show battery status on prompt. This has no effect if `PROMPT_SIMPLE=1`.
* **PROMPT_NONZERO_RC**: (Default: [✘]) Added to prompt if RC of last command is not 0
* **PROMPT_ZERO_RC**: (Default: [✓]) Added to prompt if RC of last command is 0
* **SSH_AGENT_MODE**: (Default: bastion) Set the operation mode of our SSH environment
* **SSH_AGENT_NAME**: (Default: gpg-agent) Select the agent to use
* **SSH_AGENT_SSH_AUTH_SOCK**: (Default: $HOME/.ssh_auth_sock) What to set SSH_AUTH_SOCK
* **SSH_AGENT_CACHE_TTL**: (Default: 1800) How long (in seconds) that an agent caches a key.

## TODO

- [ ] Create installation script to speed up deployment
- [ ] Create a configuration utility to help set various flags
