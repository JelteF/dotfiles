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

# Backup current dotfiles
mkdir -p $BACKUP_DIR
mv $ORIGINAL_BASHRC $ORIGINAL_BASH_PROFILE $ORIGINAL_PROFILE \
    $ORIGINAL_GITCONFIG $ORIGINAL_TMUXCONF $ORIGINAL_VIMRC \
    $ORIGINAL_XCOMPOSE $ORIGINAL_XINITRC $ORIGINAL_XRESOURCES \
    $ORIGINAL_INPUTRC $ORIGINAL_XSESSION $ORIGINAL_XPROFILE \
    $ORIGINAL_FISHCONF $BACKUP_DIR

# Create vim folders
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors
mkdir -p ~/.config/fish/completions

# Install vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Install git-flow completion
wget https://github.com/bobthecow/git-flow-completion/raw/master/git.fish -O ~/.config/fish/completions/git.fish

# Install nice color scheme
wget https://raw.github.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Bright.vim -O ~/.vim/colors/Tomorrow-Night-Bright.vim

ln -s $PWD/bash/bashrc $ORIGINAL_BASHRC
ln -s $PWD/bash/bash_profile $ORIGINAL_BASH_PROFILE
ln -s $PWD/bash/profile $ORIGINAL_PROFILE
ln -s $PWD/bash/inputrc $ORIGINAL_INPUTRC
ln -s $PWD/fish/config.fish $ORIGINAL_FISHCONF
ln -s $PWD/git/gitconfig $ORIGINAL_GITCONFIG
ln -s $PWD/tmux/tmux.conf $ORIGINAL_TMUXCONF
ln -s $PWD/vim/vimrc $ORIGINAL_VIMRC
ln -s $PWD/x/XCompose $ORIGINAL_XCOMPOSE
ln -s $PWD/x/Xresources $ORIGINAL_XRESOURCES
ln -s $PWD/x/xinitrc $ORIGINAL_XINITRC
ln -s $PWD/x/xsession $ORIGINAL_XSESSION
ln -s $PWD/x/xprofile $ORIGINAL_XPROFILE

ln -s $PWD/config_dir/* ~/.config/

# Install oh-my-fish
curl -L git.io/omf > install_omf
chmod +x install_omf
./install_omf
rm install_omf
