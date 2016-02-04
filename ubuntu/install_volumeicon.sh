#!/bin/bash

sudo apt-get install libgtk-3-dev intltool libasound2-dev

wget http://softwarebakery.com/maato/files/volumeicon/volumeicon-0.5.1.tar.gz
tar xzvf volumeicon-0.5.1.tar.gz
cd volumeicon-0.5.1

./configure
make
sudo make install

cd ..
rm -rf volumeicon-0.5.1*
