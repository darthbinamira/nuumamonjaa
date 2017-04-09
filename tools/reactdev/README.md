# React Native Development Environment In-A-Box
Because we want to work in a "slower" environment rather than running it on bare metal.  
And it's a lot less of a hassle rather than having to reformat the host if something goes wrong. ;)

## Prerequisites
* A capable machine with virtualization hardware
* Ubuntu 16.04.2 64-bit ISO
* VMware Player with VMware tools

## Bootstrap Scripts
    # run as root to install dependencies
    sudo su
    sh os_setup.sh
    sh watchman.sh
    exit
    
    # run as user for setting up sdk and env vars
    sh user_setup.sh

## Running
    # terminal 1: starting the emulator
    cd ${HOME}/Android/sdk/tools
    ./emulator -avd react_dev
    
    # terminal 2: initialize project and start bundle
    react-native init HelloWorld
    react-native start
    
    # terminal 3: see sample code in action!
    react-native run-android

## Extras

    Comes with Nuclide + all the other bells and whistles
    Flow is not installed globally, so you will have to add the path variable manually

