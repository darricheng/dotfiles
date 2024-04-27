if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Env vars
set -gx EDITOR nvim

# aliases
alias zshrc="nvim ~/.zshrc"
alias nconf="nvim ~/.config/nvim"
alias tconf="nvim ~/.config/tmux"
alias fconf="nvim ~/.config/fish"
alias n="nvim"
alias g="git"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -m"
alias gcv="git commit --verbose"
alias gco="git checkout"
alias gp="git push"
alias t="tmux"
alias tk="tmux list-keys"
alias f="fzf"
alias man="batman"
alias cz="chezmoi"
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

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
# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

# zoxide
zoxide init fish | source

# starship prompt
starship init fish | source

# Set up fzf key bindings
fzf --fish | source
