#!/bin/sh
script_dir=$(realpath $(dirname $0))
export ROS_IP=$(docker network inspect control_simulator_default | python $script_dir/get_docker_network_ip.py)
export ROS_MASTER_URI=http://$ROS_IP:11311

