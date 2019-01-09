#!/bin/sh
script_dir=$(realpath $(dirname $0))
export ROS_IP=$(docker network inspect control_simulator_default | python $script_dir/get_docker_network_ip.py)

