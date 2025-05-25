# dotfiles/chezmoi
abbr -a cz chezmoi
abbr -a czg chezmoi git
abbr -a czgs chezmoi git status
abbr -a czgaa chezmoi git add .
abbr -a czgc chezmoi git -- commit -v
abbr -a zshrc chezmoi edit --apply ~/.zshrc
abbr -a nconf chezmoi edit --apply ~/.config/nvim
abbr -a tconf chezmoi edit --apply ~/.config/tmux
abbr -a fconf chezmoi edit --apply ~/.config/fish
abbr -a aconf chezmoi edit --apply ~/.config/alacritty
abbr -a update-nvim-lazy-lock chezmoi add ~/.config/nvim/lazy-lock.json 

# common cli tools
abbr -a n nvim
abbr -a view nvim -R # by default, `view` runs `vim -R`
abbr -a t tmux
abbr -a tk tmux list-keys
abbr -a f fzf
abbr -a j just

# homebrew gcc
abbr -a hgcc /opt/homebrew/bin/gcc-14
abbr -a hg++ /opt/homebrew/bin/g++-14

# git
abbr -a g git
abbr -a gs git status
abbr -a gd git diff
abbr -a ga git add
abbr -a gaa git add --all
abbr -a gc git commit -v
abbr -a gco git checkout
abbr -a gsw git switch
abbr -a gpu git push
abbr -a gf git fetch -p
abbr -a gl git log
abbr -a gpl git pull
abbr -a gb git branch

# reload config
abbr -a reload-config source ~/.config/fish/**/*.fish

# For ... to go up parent dirs n times
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr -a dotdot --regex '^\.\.+$' --function multicd

