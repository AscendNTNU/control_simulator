#!/bin/bash

source /opt/ros/kinetic/setup.bash 
RELEASE_TAG=latest exec make ${@}


