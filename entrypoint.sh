#!/bin/bash

set +e 
export ROS_IP=$(hostname -i)
rm -rf /tmp/.X1-lock
Xvfb :1 -screen 0 1280x720x16 &
export DISPLAY=:1.0
source $(dpkg -L gazebo7 | grep gazebo/setup.sh)
source /opt/ros/kinetic/setup.bash
source devel/setup.bash

exec $@
