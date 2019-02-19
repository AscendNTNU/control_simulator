#!/bin/bash

source /opt/ros/kinetic/setup.bash 
echo "--- DEBUG PRINTS begin ---"
echo $HOME
ls /root/.ssh
ls $HOME/.ssh
ls $HOME
ls ~/.ssh
echo "--- DEBUG PRINTS end ---"

git submodule update --init --recursive
make build-images
exec ${@}


