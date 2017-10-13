if not echo $TERM | grep 256color > /dev/null
    set TERM xterm-256color
end

# Base16 Shell
if status --is-interactive
    eval sh $HOME/.config/base16-shell/scripts/base16-harmonic16-dark.sh
end

# Set default editor to vim
set -x EDITOR vim
set -x VISUAL vim

# Don't let cd complete home directory
set CDPATH .

# Disable venv because bob-the-fish does this already
set VIRTUAL_ENV_DISABLE_PROMPT yes
set VIRTUALGO_DISABLE_PROMPT yes

set -x GOPATH $HOME/go

set -x NPM_CONFIG_PREFIX ~/.npm-global

# Set user $PATH variables
set fish_user_paths /opt/bin ~/.gem/ruby/2.2.0/bin ~/.local/bin $GOPATH/bin /sbin /usr/sbin ~/.cargo/bin ~/.fzf/bin ~/.npm-global/bin

if not status --is-interactive
    exit
end

eval (python -m virtualfish compat_aliases auto_activation 2> /dev/null)

set theme_display_user yes
set default_user jelte
# set -g theme_display_ruby no
set -g theme_nerd_fonts yes
set -g theme_color_scheme solarized-dark

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

function redis-cli
    if command -s rlwrap > /dev/null
        rlwrap -a -- redis-cli $argv
    else
        command redis-cli $argv
    end
end

function rg
    command rg --smart-case $argv
end


abbr -a pvc peerflix --vlc \'

abbr -a gc git checkout
abbr -a gch git checkout
abbr -a gc- git checkout -
abbr -a gc-- git checkout --
abbr -a gc--. git checkout -- .
abbr -a gcma git checkout master
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
abbr -a gs git status
abbr -a gr git rebase
abbr -a gro git rebase origin
abbr -a grm git rebase master
abbr -a grh git rebase HEAD
abbr -a grc git rebase --continue
abbr -a gra git rebase --abort
abbr -a gf git fetch
abbr -a gp git pull
abbr -a gpr git pull --rebase
abbr -a gpf git pull --force
abbr -a gps git push
abbr -a gpsf git push --force

function _gen_fzf_default_opts
  set base03 "234"
  set base02 "235"
  set base01 "240"
  set base00 "241"
  set base0 "244"
  set base1 "245"
  set base2 "254"
  set base3 "230"
  set yellow "136"
  set orange "166"
  set red "160"
  set magenta "125"
  set violet "61"
  set blue "33"
  set cyan "37"
  set green "64"

  # Comment and uncomment below for the light theme.

  # Solarized Dark color scheme for fzf
  echo "--color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow"
end

set -x FZF_DEFAULT_OPTS (_gen_fzf_default_opts)
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

command -v vg >/dev/null 2>&1; and vg eval --shell fish | source
