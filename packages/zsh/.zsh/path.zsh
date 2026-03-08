# Settings for neovim
export XDG_CONFIG_HOME="$HOME/.config"

# Git
export PATH=/usr/local/bin/git:$PATH
export PATH="$PATH:/usr/local/share/git-core/contrib/diff-highlight"

# MySQL client
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# Development directory
export dev=$HOME/dev

# Homebrew
export PATH=/opt/homebrew/bin:$PATH

# pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")
