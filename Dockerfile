FROM ros:kinetic

RUN apt-get update && apt-get install -y \
		curl \
		gazebo7 \
		imagemagick \
		libboost-all-dev \
		libeigen3-dev \
		libgazebo7 \
		libgazebo7-dev \
		libjansson-dev \
		libopencv-dev \
		libprotobuf-dev \
		libprotoc-dev \
		libtinyxml-dev \
		libxml2-utils \
		mercurial \
		pkg-config \
		protobuf-compiler \
		psmisc \
    python-catkin-tools \
    python-jinja2 \
    python-rospkg \
    python-rosinstall-generator \
    ros-kinetic-angles \
    ros-kinetic-cv-bridge \
    ros-kinetic-control-toolbox \
    ros-kinetic-gazebo-ros \
    ros-kinetic-gazebo-msgs \
    ros-kinetic-libmavconn \
    ros-kinetic-tf2-eigen \
    ros-kinetic-urdf \
		xvfb && \
    # install mavros dependencies so we can build from source
    apt-get install -y \
    $(apt-cache depends ros-kinetic-mavros | grep Depends | sed "s/.*ends://" | tr '\n' ' ') \ 
    $(apt-cache depends ros-kinetic-mavlink | grep Depends | sed "s/.*ends://" | tr '\n' ' ') 

RUN apt-get install -y python-pip && \
    python -m pip install --upgrade pip && \
    python -m pip install --user toml numpy future

WORKDIR /control_simulator
COPY scripts scripts
COPY src/control_simulator/models src/control_simulator/models
RUN bash scripts/install_gzweb.sh

COPY . .
RUN git submodule update --init --recursive

# Get external projects
ARG GITHUB_PAT
RUN bash scripts/clone_external_projects.sh ${GITHUB_PAT}

RUN bash -c "source /opt/ros/kinetic/setup.bash && catkin build"

ENTRYPOINT ["./entrypoint.sh"]
CMD bash
