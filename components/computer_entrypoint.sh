#!/bin/bash

source devel/setup.bash
export ROS_IP=$(hostname -i) 
export ROS_HOSTNAME=$(hostname -s) 
echo "ROS_IP is ${ROS_IP}" 
echo "ROS_MASTER_URI is ${ROS_MASTER_URI}"

command_to_run="${@}"
echo "command: $command_to_run"

exec $command_to_run


