FROM ros:kinetic
MAINTAINER "rendellc@ascendntnu.no"

WORKDIR /catkin_ws
COPY ./catkin_ws/src ./src
RUN ["/bin/bash", "-c", "source /opt/ros/kinetic/setup.bash && catkin_make"]

CMD ["/bin/bash", "-c", "source devel/setup.bash && ls && roslaunch ${LAUNCH_PKG} ${LAUNCH_FILE}"]

