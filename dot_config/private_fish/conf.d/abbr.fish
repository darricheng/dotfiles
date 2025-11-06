# dotfiles/chezmoi
abbr -a cz chezmoi
abbr -a czcd chezmoi cd
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

# github
abbr -a ghv gh pr view
abbr -a ghcr gh pr create
abbr -a ghck gh pr checks
abbr -a ghm gh pr merge
abbr -a ghd 'gh pr diff | bat'

# git with difftastic
abbr -a dgl git -c diff.external=difft log -p --ext-diff
abbr -a dgs git -c diff.external=difft show --ext-diff
abbr -a dgd git -c diff.external=difft diff

# reload config
abbr -a reload-config source ~/.config/fish/**/*.fish

# For ... to go up parent dirs n times
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr -a dotdot --regex '^\.\.+$' --function multicd

# pomodoro
# NOTE: this is just some sample commands, I want to make them much better to use.
# The sleep function call can be changed to something that shows a timer bar, like https://github.com/caarlos0/timer
# I don't want to use the above package because it's a third-party homebrew tap.
# I can even create a simple CLI using the [indicatif crate](https://docs.rs/indicatif/latest/indicatif/) for the progress bar.
function work_fn
    sleep 25m
    osascript -e 'display notification "Get some good work done!" with title "Time to work" sound name "Glass"'
end
# I couldn't do `sleep 25m && osascript ...` because the && is like another command after calling `abbr`,
# so we use a function instead
abbr -a work --function work_fn
function rest_fn
    sleep 5m
    osascript -e 'display notification "Rest up before the next session" with title "Break time!" sound name "Glass"'
end
abbr -a rest --function rest_fn
