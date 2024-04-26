My tmux configs

The original is based off [oh my tmux](https://github.com/gpakosz/.tmux), which is a set of sensible default tmux configs.

I want to get familiar with my tmux configs, so the evolution of this repo represents my journey of turning the configs into my own.

Currently, the main configs are in the tmux.conf file. It then sources the tmux.conf.local file at the bottom of the uncommented code.

The large section of commented lines at the bottom of the tmux.conf file are shell scripts that are bound to certain keybindings. For example, pressing <prefix>+ calls the \_maximize_pane() function in the commented section.
