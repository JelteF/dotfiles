#!/bin/bash

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

sudo mv PowerlineSymbols.otf
sudo fc-cache -vf ~/.fonts/
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

