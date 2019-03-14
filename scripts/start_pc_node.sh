#!/bin/bash

containerID=$(docker run -it -d \
  -e ROS_MASTER_URI=http://offboard_computer:11311 \
  -e ROS_NAMESPACE=alpha \
  ascendntnu/control_simulator_pc_node bash)
docker network connect control_simulator_default $containerID
echo $containerID
docker attach $containerID
