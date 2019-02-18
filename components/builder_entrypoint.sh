#!/bin/bash

source /opt/ros/kinetic/setup.bash 
make build-images
exec ${@}


