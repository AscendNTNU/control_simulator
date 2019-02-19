FROM gazebo:libgazebo7

# Install ros and build tools
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
  && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 \
  && apt-get update \
  && apt-get install -y \
    ros-kinetic-ros-base \
    ros-kinetic-gazebo-ros \
    ros-kinetic-mavlink \
    ros-kinetic-mavros \
    ros-kinetic-mavros-extras \
    ros-kinetic-mavros-msgs \
    geographiclib-tools \
    libeigen3-dev \
    libopencv-dev \
    libprotoc-dev \
    git \
    protobuf-compiler \
    python-pip \
  && rm -rf /var/lib/apt/lists/* \
  && python -m pip install jinja2 \
  && rosdep init \
  && rosdep update 

WORKDIR /home/user/control_simulator
COPY . .
RUN mv components/builder_entrypoint.sh ./entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
CMD bash
