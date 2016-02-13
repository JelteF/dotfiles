set fisher_home ~/.fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish
if not echo $TERM | grep 256color > /dev/null
    set TERM xterm-256color
end

# Set default editor to vim
set -x EDITOR vim
set -x VISUAL vim

set theme_display_user yes
set default_user jelte
set -g theme_display_ruby no

# Disable venv because bob-the-fish does this already
set VIRTUAL_ENV_DISABLE_PROMPT yes

set -x GOPATH $HOME/go


# Set user $PATH variables
set fish_user_paths /opt/bin ~/.gem/ruby/2.2.0/bin ~/.local/bin $GOPATH/bin /sbin /usr/sbin ~/.cargo/bin

# Don't let cd complete home directory
set CDPATH .

# Set echangelog user
set -x ECHANGELOG_USER "Jelte Fennema (JelteF) <github-tech@jeltef.nl>"

# Disable clipboard polution
set FISH_CLIPBOARD_CMD "cat"

function su
    if test (count $argv) = 0
        command su jelte_root
    else
        command su $argv
    end
end

function vim
    if command -s nvim > /dev/null
        nvim $argv
    else
        command vim $argv
    end
end

function ovim
    command vim $argv
end
