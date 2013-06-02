#/bin/bash

# Base
VIM="vim vim-spell-nl vim-spell-en"
GENTOO_UTILS="eix layman gentoolkit"
BASH_UTILS="ack the_silver_searcher irssi htop wireless-tools pciutils module-rebuild"
GIT="git tig"

# X
X_BASE="awesome slim xorg-server volumeicon"
X_UTILS="synapse nautilus keepass gparted evince google-chrome"
X_FONTS="ubuntu-font-family"
X_TERMS="xterm gnome-terminal"

# Extra
PYTHON_UTILS="pypy dev-python/pip ipython"
WEBDEV="flask flask-sqlalchemy sass"
EXTRA="skype sci-visualization/gnuplot wine audacity texlive"
LARGE="firefox libreoffice"

LAPTOP="wpa_supplicant gnome-power-manager"



# Install all
emerge $VIM $GENTOO_UTILS $BASH_UTILS $GIT $X_BASE $X_UTILS $X_FONTS $X_TERMS \
$PYTHON_UTILS $WEBDEV $EXTRA $LARGE $LAPTOP -a --update --deep --newuse world
