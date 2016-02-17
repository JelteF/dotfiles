#!/bin/bash

AWESOME=etc/xdg/awesome/rc.lua
sudo mkdir -p /opt/bin
sudo ln -sf $PWD/$AWESOME /$AWESOME
