#!/bin/bash

source /opt/ros/kinetic/setup.bash 
git submodule update --init --recursive
make build-images
exec ${@}


