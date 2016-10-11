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
set -x NODE_PATH "$HOME/.node/lib/node_modules $NODE_MODULES"



# Set user $PATH variables
set fish_user_paths /opt/bin ~/.gem/ruby/2.2.0/bin ~/.local/bin $GOPATH/bin /sbin /usr/sbin ~/.cargo/bin ~/.pyenv/bin ~/.bin ~/.node/bin
# source (pyenv init - | psub)
# source (pyenv virtualenv-init - | psub)

# virtualfish
set -x WORKON_HOME = ~/.envs
eval (python -m virtualfish compat_aliases)

# Running Stream aliases
alias stream-local="env ENVIRONMENT=development_local python manage.py"
alias stream-remote="env ENVIRONMENT=development python manage.py"
alias stream-testing="env ENVIRONMENT=testing python manage.py test --noinput"

# Don't let cd complete home directory
set CDPATH .

# Set echangelog user
set -x ECHANGELOG_USER "Jelte Fennema (JelteF) <github-tech@jeltef.nl>"

# Disable clipboard polution
set FISH_CLIPBOARD_CMD "cat"

alias git-root="cd  (git rev-parse --show-toplevel)"

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

function git
    if command -s hub > /dev/null
        hub $argv
    else
        command git $argv
    end
end

abbr -a pvc peerflix --vlc \'

abbr -a gch git checkout
abbr -a gc- git checkout -
abbr -a gcb git checkout -b
abbr -a ga git add
abbr -a gap git add -p
abbr -a gco git commit
abbr -a gcm git commit -m
abbr -a gca git commit --amend
abbr -a gcan git commit --amend --no-edit
abbr -a gd git diff
abbr -a gwd git wdiff
abbr -a gdc git diff --cached
