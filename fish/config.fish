# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme bobthefish

set TERM xterm-256color

# Set default editor to vim
set EDITOR vim
set VISUAL vim

set theme_display_user yes
set default_user jelte
set -g theme_display_ruby no

# Disable venv because bob-the-fish does this already
set VIRTUAL_ENV_DISABLE_PROMPT yes

set -x GOPATH $HOME/go


# Set user $PATH variables
set -g fish_user_paths $fish_user_paths /opt/bin ~/.gem/ruby/2.2.0/bin ~/.local/bin $GOPATH/bin

# Don't let cd complete home directory
set CDPATH .

# Set echangelog user
set -x ECHANGELOG_USER "Jelte Fennema (JelteF) <github-tech@jeltef.nl>"

# Disable clipboard polution
set FISH_CLIPBOARD_CMD "cat"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins vi-mode

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
source $fish_path/oh-my-fish.fish
