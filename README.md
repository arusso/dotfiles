## Introduction

Welcome to my dotfiles. I try to keep them tidy, but you know, they are just
'aight. They're largely bash, vim, git and tmux centric.

## Highlights

* Supports gpg-agent as an alternative to ssh-agent when installed
* Displays battery percentage on OSX for Systems with a battery installed

## Environment Variables

* **SIMPLE_PROMPT**: (Default: 0) Disables fancy prompts.
* **SSH_AGENT_MODE**: (Default: bastion) Set the operation mode of our SSH environment
* **SSH_AGENT_NAME**: (Default: gpg-agent) Select the agent to use
* **SSH_AGENT_SSH_AUTH_SOCK**: (Default: $HOME/.ssh_auth_sock) What to set SSH_AUTH_SOCK
* **SSH_AGENT_CACHE_TTL**: (Default: 1800) How long (in seconds) that an agent caches a key.

## TODO

- [ ] Move configuration data somewhere under $HOME/.config/ ($HOME/.config/env?)
- [ ] Create installation script to speed up deployment
- [ ] Create a configuration utility to help set various flags
