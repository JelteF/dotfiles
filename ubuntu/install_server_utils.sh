#!/bin/bash
# Install everything
echo 'Installing important stuff'
sudo apt-get --yes --force-yes install vim ack-grep git python-pip\
    ruby-sass irssi htop ipython python-dev git-flow tig curl fish\
    tmux python-virtualenv whois wget
