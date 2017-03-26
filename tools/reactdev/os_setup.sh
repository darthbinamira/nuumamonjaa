#!/bin/sh

DEBIAN_FRONTEND=noninteractive

# very important! set mirrors
sed -i 's@http://.*ubuntu@mirror://mirrors.ubuntu.com/mirrors.txt@g' /etc/apt/sources.list
sed -i 's/"1"/"0"/g' /etc/apt/apt.conf.d/10periodic

# update and upgrade first!
apt-get update
apt-get upgrade -y
apt-get autoremove -y
apt-get autoclean -y
dpkg --configure -a

# essentials
apt-get install -y git vim zsh curl wget tree tmux

# desktop environment
apt-get install -y gnome-shell gnome-session-flashback terminator
dpkg --configure -a

# react native setup
curl -sL https://deb.nodesource.com/setup_7.x | bash -
apt-get install -y nodejs
npm install -g react-native-cli

# optional build tools required for npm
apt-get install -y build-essential

# VM acceleration for android development
apt-get install -y qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

# android dependencies
apt-get install -y openjdk-8-jdk lib32stdc++6 lib32z1

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update
apt-get install -y yarn

# login screen resolution hack
MODELINE=`gtf 1920 1080 60 | grep Modeline | sed -e 's/^[[:space:]]*//'`
MODENAME=`gtf 1920 1080 60 | grep Modeline | awk '{print $2}' | sed 's/\"//g'`
DEVICE=`xrandr | grep -w connected | awk '{print $1}'`
cat << EOF > /usr/share/X11/xorg.conf.d/10-monitor.conf
Section "Monitor"
	Identifier "Monitor0"
	$MODELINE
EndSection
Section "Screen"
	Identifier "Screen0"
	Device "$DEVICE"
	Monitor "Monitor0"
	DefaultDepth 24
	SubSection "Display"
		Depth 24
		Modes "$MODENAME"
	EndSubSection
EndSection
EOF

