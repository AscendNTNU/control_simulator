FROM ros:kinetic
MAINTAINER "rendellc@ascendntnu.no"

RUN apt-get update \
  && apt-get install -y \
  gazebo7 \
  libeigen3-dev \
  libgazebo7-dev \
  libopencv-dev \
  libprotobuf-dev \
  libprotoc-dev \
  libxml2-utils \
  protobuf-compiler \
  python-rospkg \
  python-jinja2 \
  ros-kinetic-cv-bridge \
  ros-kinetic-mavros \
  ros-kinetic-mavros-msgs \
  ros-kinetic-mavros-extras \
  && rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/kinetic/setup.sh \
  && mkdir /.gazebo \
  && chown jenkins /.gazebo

WORKDIR /home/user

CMD bash
