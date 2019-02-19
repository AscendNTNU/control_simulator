#!/bin/bash

source /opt/ros/kinetic/setup.bash 
ls ~/.ssh

git submodule update --init --recursive
make build-images
exec ${@}


