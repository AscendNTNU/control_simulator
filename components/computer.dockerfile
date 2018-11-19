FROM ros:kinetic
MAINTAINER "rendellc@ascendntnu.no"

RUN apt-get update \
  && apt-get install -y \
  ros-kinetic-mavros \
  ros-kinetic-mavros-msgs \
  ros-kinetic-mavros-extras \
  ros-kinetic-gazebo-msgs \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /catkin_ws
COPY ./catkin_ws/src ./src
RUN ["/bin/bash", "-c", "source /opt/ros/kinetic/setup.bash &&  catkin_make"]

CMD ["/bin/bash", "-c", "source devel/setup.bash \
  && export ROS_IP=$(hostname -i) \
  && echo \"ROS_IP is ${ROS_IP}\" \
  && echo \"ROS_MASTER_URI is ${ROS_MASTER_URI}\" \
  && roslaunch ${LAUNCH_PKG} ${LAUNCH_FILE}"]

