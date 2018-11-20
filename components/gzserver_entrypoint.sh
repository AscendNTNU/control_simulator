#!/bin/bash

set +e 
export ROS_IP=$(hostname -i)
echo "ROS_IP is ${ROS_IP}"
echo "ROS_MASTER_URI is ${ROS_MASTER_URI}"
echo "WORLD_FILE is ${WORLD_FILE}"
rm -rf /tmp/.X1-lock
Xvfb :1 -screen 0 1280x720x16 &
export DISPLAY=:1.0
source /opt/ros/kinetic/setup.bash

echo "Launching server, world: $PWD/worlds/${WORLD_FILE}"
roslaunch --wait gazebo_ros empty_world.launch world_name:=$PWD/worlds/${WORLD_FILE}
