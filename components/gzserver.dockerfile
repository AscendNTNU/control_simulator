FROM gazebo:libgazebo7
MAINTAINER "rendellc@ascendntnu.no"

#RUN apt-get update && apt-get install -q -y \
#  build-essential \
#  cmake \
#  curl \
#  imagemagick \
#  libboost-all-dev \
#  libgazebo7-dev \
#  libjansson-dev \
#  libtinyxml-dev \
#  mercurial \
#  pkg-config \
#  psmisc \
#  xvfb \
#  && rm -rf /var/lib/apt/lists/*

# Install ros
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
  && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 \
  && apt-get update \
  && apt-get install -y \
    ros-kinetic-ros-base \
    ros-kinetic-gazebo-ros \
    xvfb \
  && rm -rf /var/lib/apt/lists/* \
  && rosdep init \
  && rosdep update

# setup environemt
ARG GZRESOURCES_DIR
WORKDIR /home/user/gzserver
COPY $GZRESOURCES_DIR .
ENV GAZEBO_MODEL_PATH ${GAZEBO_MODEL_PATH}:/home/user/gzserver/models
ENV GAZEBO_PLUGIN_PATH ${GAZEBO_PLUGIN_PATH}:/home/user/gzserver/plugins
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/home/user/gzserver/plugins


ENV WORLD_FILE testing.world
CMD ["/bin/bash", "-c", "\
  set +e \
  && export ROS_IP=$(hostname -i) \
  && echo \"ROS_IP is ${ROS_IP}\" \
  && rm -rf /tmp/.X1-lock \
  && Xvfb :1 -screen 0 1280x720x16 & \
  export DISPLAY=:1.0 \ 
  && source /opt/ros/kinetic/setup.bash \
  && rosrun gazebo_ros gzserver --verbose $PWD/worlds/${WORLD_FILE}"]

