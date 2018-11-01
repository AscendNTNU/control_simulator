FROM ros:kinetic
MAINTAINER "rendellc@ascendntnu.no"

RUN apt-get update \
  && apt-get install -y \
  ros-kinetic-mavros \
  ros-kinetic-mavros-msgs \
  ros-kinetic-mavros-extras

ARG DONT_BUILD
WORKDIR /catkin_ws
COPY ./catkin_ws/src ./src
RUN ["/bin/bash", "-c", "source /opt/ros/kinetic/setup.bash \
  && echo dont build is ${DONT_BUILD} \
  && if [ $DONT_BUILD != true ] ; then catkin_make; fi"]

CMD ["/bin/bash", "-c", "source devel/setup.bash && echo \"ROS_MASTER_URI is ${ROS_MASTER_URI}\" && roslaunch ${LAUNCH_PKG} ${LAUNCH_FILE}"]

