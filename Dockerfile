FROM ros:kinetic

ARG GITHUB_PAT

RUN apt-get update && apt-get install -y \
		curl \
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
    python-jinja2 \
    python-rospkg \
    ros-kinetic-cv-bridge \
    ros-kinetic-mavros \
    ros-kinetic-mavros-msgs \
    ros-kinetic-mavros-extras \
    ros-kinetic-gazebo-ros \
    ros-kinetic-gazebo-msgs \
		xvfb && \
    . /opt/ros/kinetic/setup.sh && \
    rosrun mavros install_geographiclib_datasets.sh
    
RUN apt-get install -y python-pip && \
    python -m pip install --upgrade pip && \
    python -m pip install --user toml numpy

WORKDIR /control_simulator
COPY . . 
RUN bash scripts/install_gzweb.sh
RUN git submodule update --init --recursive

# Get external projects
RUN git clone https://${GITHUB_PAT}:@github.com/AscendNTNU/ascend_utils.git src/ascend_utils && \
    git clone https://${GITHUB_PAT}:@github.com/AscendNTNU/fluid_fsm.git src/fluid_fsm && \
    git clone https://${GITHUB_PAT}:@github.com/AscendNTNU/ascend_msgs.git src/ascend_msgs
RUN bash -c "source /opt/ros/kinetic/setup.bash && catkin_make"

CMD bash
