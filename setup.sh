#!/bin/bash

BACKUP_DIR=$PWD/backup
ORIGINAL_BASHRC=$HOME/.bashrc
ORIGINAL_BASH_PROFILE=$HOME/.bash_profile
ORIGINAL_FISHCONF=$HOME/.config/fish/config.fish
ORIGINAL_PROFILE=$HOME/.profile
ORIGINAL_INPUTRC=$HOME/.inputrc
ORIGINAL_GITCONFIG=$HOME/.gitconfig
ORIGINAL_TMUXCONF=$HOME/.tmux.conf
ORIGINAL_VIMRC=$HOME/.vimrc
ORIGINAL_XCOMPOSE=$HOME/.XCompose
ORIGINAL_XRESOURCES=$HOME/.Xresources
ORIGINAL_XINITRC=$HOME/.xinitrc
ORIGINAL_XPROFILE=$HOME/.xprofile
ORIGINAL_XSESSION=$HOME/.xsession

# Create vim folders
mkdir -p ~/.vim/bundle
mkdir -p ~/.ptpython
mkdir -p ~/.vim/colors
mkdir -p ~/.config/fish/completions

# Install vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Install git-flow completion
wget https://github.com/bobthecow/git-flow-completion/raw/master/git.fish -O ~/.config/fish/completions/git.fish

# Install nice color scheme
wget https://raw.github.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Bright.vim -O ~/.vim/colors/Tomorrow-Night-Bright.vim

ln -sf $PWD/bash/bashrc $ORIGINAL_BASHRC
ln -sf $PWD/bash/bash_profile $ORIGINAL_BASH_PROFILE
ln -sf $PWD/bash/profile $ORIGINAL_PROFILE
ln -sf $PWD/bash/inputrc $ORIGINAL_INPUTRC
ln -sf $PWD/git/gitconfig $ORIGINAL_GITCONFIG
ln -sf $PWD/tmux/tmux.conf $ORIGINAL_TMUXCONF
ln -sf $PWD/vim/vimrc $ORIGINAL_VIMRC
ln -sf $PWD/x/XCompose $ORIGINAL_XCOMPOSE
ln -sf $PWD/x/Xresources $ORIGINAL_XRESOURCES
ln -sf $PWD/x/xinitrc $ORIGINAL_XINITRC
ln -sf $PWD/x/xsession $ORIGINAL_XSESSION
ln -sf $PWD/x/xprofile $ORIGINAL_XPROFILE

ln -sf $PWD/ptpython/* ~/.ptpython/
ln -sf $PWD/config_dir/* ~/.config/

# Install fisherman
# git clone https://github.com/fisherman/fisherman ~/.fisherman
cd ~/.fisherman
make
cd -

ln -sf $PWD/fish/config.fish $ORIGINAL_FISHCONF

exec fish < /dev/tty
