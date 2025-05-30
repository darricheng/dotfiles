if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Env vars
set -gx EDITOR nvim
set -Ux MANPAGER 'nvim +Man!'

# Additions to PATH
# homebrew
fish_add_path /opt/homebrew/bin
# rust binaries installed with cargo 
fish_add_path ~/.cargo/bin
# Postgres
fish_add_path /opt/homebrew/opt/postgresql@16/bin
# make go binaries available on path
fish_add_path (go env GOPATH)/bin
# Use the homebrew-installed ruby instead of the one installed in macos by default
fish_add_path /opt/homebrew/opt/ruby/bin
# add packages installed by mason in Neovim
fish_add_path ~/.local/share/nvim/mason/bin
# llvm
fish_add_path /opt/homebrew/opt/llvm/bin
# Not sure if I'll need the below two when using clang?
# set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
# set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

# Ailytics poetry
fish_add_path ~/.poetry/venv/bin/poetry

# Python
# Use virtualfish? https://github.com/justinmayer/virtualfish
# TODO: Make it such that this only runs when I need it, e.g. when I run a specific command
# See for pyenv installation: https://opensource.com/article/19/5/python-3-default-mac
# Also see pyenv readme: https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv
# can see [fish-nvm](https://github.com/FabioAntunes/fish-nvm) for running pyenv only when needed
# set -Ux PYENV_ROOT $HOME/.pyenv
# fish_add_path $PYENV_ROOT/bin
# pyenv init - | source

# zoxide
zoxide init fish | source

# starship prompt
starship init fish | source

# Set up fzf key bindings
fzf --fish | source

# opam configuration
# source /Users/darricheng/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

