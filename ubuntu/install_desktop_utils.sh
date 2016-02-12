#!/bin/bash
sudo apt-get --yes --force-yes install keepass2 keepass2-plugin-keepasshttp\
    keepass2-plugin-keeagent synapse xdotool mono-complete gnuplot \
    google-chrome-stable gparted insync curl awesome xfce4-terminal telegram \
    pavucontrol arandr thunar python-pygments xclip wireshark

wget https://github.com/jgm/pandoc/releases/download/1.16.0.2/pandoc-1.16.0.2-1-amd64.deb
sudo dpkg -i pandoc-*.deb
rm pandoc-*.deb
