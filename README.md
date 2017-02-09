## Introduction

Welcome to my dotfiles. I try to keep them tidy, but you know, they are just
'aight. They're largely bash, vim, git and tmux centric.

## Highlights

* Supports gpg-agent as an alternative to ssh-agent when installed
* Displays battery percentage on OSX for Systems with a battery installed

## Environment Variables

* **DISABLE_SSH_AGENT_SETUP**: (Default: unset) Disable setup and customization of ssh-agent/gpg-agent
* **SIMPLE_PROMPT**: Disables fancy prompts
* **SSH_CACHE_TTL**: How long in seconds that the gpg-agent or ssh-agent should
                    cache ssh keys.
* **USE_GPG_AGENT**: Set to 0 to disable ssh agent

## TODO

- [ ] Move configuration data somewhere under $HOME/.config/ ($HOME/.config/env?)
- [ ] Create installation script to speed up deployment
- [ ] Create a configuration utility to help set various flags
