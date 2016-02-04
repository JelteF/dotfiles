#!/bin/bash

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

mkdir -p ~/.fonts/

sudo mv PowerlineSymbols.otf ~/.fonts/
sudo fc-cache -vf ~/.fonts/
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

