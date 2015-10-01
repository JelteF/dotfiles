# vim: ft=bash ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for BASH
#
# (Converted from ZSH theme by Kenny Root)
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.
 
### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts
 
CURRENT_BG='NONE'
SEGMENT_SEPARATOR='⮀'
 
text_effect() {
  case "$1" in
    reset)     echo 0;;
    bold)      echo 1;;
    underline) echo 4;;
  esac
}

fg_color() {
  case "$1" in
    black)   echo 30;;
    red)     echo 31;;
   	green)   echo 32;;
  	yellow)  echo 33;;
  	blue)    echo 34;;
  	magenta) echo 35;;
  	cyan)    echo 36;;
  	white)   echo 37;;
  esac
}

bg_color() {
  case "$1" in
    black)   echo 40;;
    red)     echo 41;;
   	green)   echo 42;;
  	yellow)  echo 43;;
  	blue)    echo 44;;
  	magenta) echo 45;;
  	cyan)    echo 46;;
  	white)   echo 47;;
  esac;
}

ansi() {
  local seq
  declare -a codes=("${!1}")

  seq=""
  for ((i = 0; i < ${#codes[@]}; i++)); do
    if [[ -n $seq ]]; then
      seq="${seq};"
    fi
    seq="${seq}${codes[$i]}"
  done
  echo -ne '\[\033['${seq}'m\]'
}

ansi_single() {
  echo -ne '\[\033['$1'm\]'
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  declare -a codes
  if [[ -z $1 || ( -z $2 && $2 != default ) ]]; then
    codes=("${codes[@]}" $(text_effect reset))
  fi
  if [[ -n $1 ]]; then
    bg=$(bg_color $1)
    codes=("${codes[@]}" $bg)
  fi
  if [[ -n $2 ]]; then
    fg=$(fg_color $2)
    codes=("${codes[@]}" $fg)
  fi

  if [[ $CURRENT_BG != NONE && $1 != $CURRENT_BG ]]; then
    declare -a intermediate=($(fg_color $CURRENT_BG) $(bg_color $1))
    echo -ne " $(ansi intermediate[@])$SEGMENT_SEPARATOR$(ansi codes[@]) "
  else
    echo -ne "$(ansi codes[@]) "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}
 
# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    declare -a codes=($(text_effect reset) $(fg_color $CURRENT_BG))
    echo -ne " $(ansi codes[@])$SEGMENT_SEPARATOR"
  fi
  declare -a reset=($(text_effect reset))
  echo -ne " $(ansi reset[@])"
  CURRENT_BG=''
}
 
### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown
 
# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`
 
  if [[ $user != $DEFAULT_USER || -n $SSH_CLIENT ]]; then
    prompt_segment black default "$user@\h"
  fi
}
 
git_status_dirty() {
  dirty=$(git status -s 2> /dev/null | tail -n 1)
  [[ -n $dirty ]] && echo "*"
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    ZSH_THEME_GIT_PROMPT_DIRTY='±'
    dirty=$(git_status_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green black
    fi
    echo -n "${ref/refs\/heads\//⭠ }$dirty"
  fi
}
 
# Dir: current working directory
prompt_dir() {
  prompt_segment blue black '\w'
}
 
# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="$(ansi_single $(fg_color red))✘"
  [[ $UID -eq 0 ]] && symbols+="$(ansi_single $(fg_color yellow))⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="$(ansi_single $(fg_color cyan))⚙"
 
  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}
 
## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}
 
PS1='$(ansi_single $(text_effect reset))$(build_prompt) '