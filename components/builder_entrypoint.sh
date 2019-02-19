#!/bin/bash

source /opt/ros/kinetic/setup.bash 
echo "--- DEBUG PRINTS ---"
echo $HOME
echo $USER
ls $HOME/.ssh
ls $HOME
ls ~/.ssh
echo "--- DEBUG PRINTS ---"

git submodule update --init --recursive
make build-images
exec ${@}


