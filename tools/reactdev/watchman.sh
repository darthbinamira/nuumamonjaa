#!/bin/sh

# dependencies
apt-get update
apt-get install -y autoconf automake python-setuptools python-dev

# compile and install
cd /tmp
git clone https://github.com/facebook/watchman.git
cd watchman
git checkout v4.7.0
./autogen.sh
./configure
make
make install

