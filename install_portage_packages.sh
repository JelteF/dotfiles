#!/bin/bash

# Base
VIM="vim vim-spell-nl vim-spell-en"
GENTOO_UTILS="eix layman gentoolkit gentoo-syntax"
BASH_UTILS="ack the_silver_searcher irssi htop pciutils module-rebuild \
    logrotate"
GIT="git tig"

# X
X_BASE="awesome slim xorg-server volumeicon"
X_THUNAR="thunar thunar-archive-plugin thunar-media-tags-plugin"
X_UTILS="synapse keepass gparted evince eog google-chrome file-roller"
X_UTILS="${X_UTILS} app-arch/p7zip xfce4-screenshooter lxappearance"
X_UTILS="${X_UTILS} faenza-icon-theme unrar xrandr"
X_FONTS="ubuntu-font-family droid dejavu corefonts liberation-fonts"
X_TERMS="xterm xfce4-terminal"

# Extra
PYTHON_UTILS="pypy dev-python/pip ipython"
WEBDEV="flask flask-sqlalchemy sass"
EXTRA="skype sci-visualization/gnuplot wine audacity texlive"
LARGE="firefox libreoffice"

LAPTOP="wireless-tools nm-applet gnome-power-manager"



# Install all
emerge $VIM $GENTOO_UTILS $BASH_UTILS $GIT $X_BASE $X_THUNAR $X_UTILS $X_FONTS \
$X_TERMS $PYTHON_UTILS $WEBDEV $EXTRA $LARGE $LAPTOP \
-a --update --deep --newuse world
