#!/bin/bash

source /opt/ros/kinetic/setup.bash 
git submodule update --init --recursive
make -j4 build-images
exec ${@}


