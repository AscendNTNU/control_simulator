FROM ros:kinetic
MAINTAINER "rendellc@ascendntnu.no"

RUN apt-get update \
  && apt-get install -y \
  libeigen3-dev \
  libgazebo7-dev \
  libprotobuf-dev \
  libprotoc-dev \
  libxml2-utils \
  protobuf-compiler \
  python-rospkg \
  python-jinja2 \
  ros-kinetic-mavros \
  ros-kinetic-mavros-msgs \
  ros-kinetic-mavros-extras \
  && rm -rf /var/lib/apt/lists/*


WORKDIR /catkin_ws
COPY ./catkin_ws/src ./src
RUN . /opt/ros/kinetic/setup.sh

CMD catkin_make

