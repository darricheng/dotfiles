# dotfiles/chezmoi
abbr -a cz chezmoi
abbr -a czg chezmoi git
abbr -a czgs chezmoi git status
abbr -a zshrc chezmoi edit --apply ~/.zshrc
abbr -a nconf chezmoi edit --apply ~/.config/nvim
abbr -a tconf chezmoi edit --apply ~/.config/tmux
abbr -a fconf chezmoi edit --apply ~/.config/fish

# common cli tools
abbr -a n nvim
abbr -a t tmux
abbr -a tk tmux list-keys
abbr -a f fzf
abbr -a man batman

# git
abbr -a g git
abbr -a gs git status
abbr -a gd git diff
abbr -a ga git add
abbr -a gaa git add --all
abbr -a gc git commit -m
abbr -a gcv git commit --verbose
abbr -a gco git checkout
abbr -a gsw git switch
abbr -a gp git push
abbr -a gf git fetch
abbr -a gl git log
abbr -a gpl git pull

# For ... to go up parent dirs n times
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr -a dotdot --regex '^\.\.+$' --function multicd
