1. Install [homebrew](/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)")
2. `brew install chezmoi`
3. `chezmoi init --apply darricheng`
4. `brew bundle install --file=~/.config/brew/Brewfile`

- Iterm2 -> Preferences -> General -> Preferences Load preferences from a custom folder or URL -> `~/.config/iterm2`, Profiles -> Shell -> Command -> `/opt/homebrew/bin/fish`
- Install tmux plugins: `<prefix> I`
- `broot --install`
- (Optional) Install ohmyzsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
