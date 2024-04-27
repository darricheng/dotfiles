if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Env vars
set -gx EDITOR nvim

# aliases
abbr -a zshrc chezmoi edit --apply ~/.zshrc
abbr -a nconf chezmoi edit --apply ~/.config/nvim
abbr -a tconf chezmoi edit --apply ~/.config/tmux
abbr -a fconf chezmoi edit --apply ~/.config/fish
abbr -a n nvim
abbr -a g git
abbr -a gs git status
abbr -a gd git diff
abbr -a ga git add
abbr -a gaa git add --all
abbr -a gc git commit -m
abbr -a gcv git commit --verbose
abbr -a gco git checkout
abbr -a gp git push
abbr -a t tmux
abbr -a tk tmux list-keys
abbr -a f fzf
abbr -a man batman
abbr -a cz chezmoi
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr -a dotdot --regex '^\.\.+$' --function multicd

# Additions to $PATH
# Postgres
fish_add_path /opt/homebrew/opt/postgresql@16/bin
# make go binaries available on path
fish_add_path $(go env GOPATH)/bin
# Make brew's binutils available to the system
fish_add_path /opt/homebrew/opt/binutils/bin
# Use the homebrew-installed ruby instead of the one installed in macos by default
fish_add_path /opt/homebrew/opt/ruby/bin
# add packages installed by mason in Neovim
fish_add_path /Users/darricheng/.local/share/nvim/mason/bin
# llvm
fish_add_path /opt/homebrew/opt/llvm/bin
# Not sure if I'll need the below two when using clang?
# set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
# set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

# Python
# Use virtualfish? https://github.com/justinmayer/virtualfish
# TODO: Make it such that this only runs when I need it, e.g. when I run a specific command
# See for pyenv installation: https://opensource.com/article/19/5/python-3-default-mac
# Also see pyenv readme: https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv
# fish_add_path $(pyenv root)/bin
# pyenv init - | source

# zoxide
zoxide init fish | source

# thefuck
thefuck --alias | source

# starship prompt
starship init fish | source

# Set up fzf key bindings
fzf --fish | source

# opam configuration
# source /Users/darricheng/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# TODO: Setup nvm (see zshrc)
# Make it such that nvm only sources when I need it
