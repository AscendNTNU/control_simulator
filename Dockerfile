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
COPY scripts scripts
COPY src/control_simulator/models src/control_simulator/models
RUN bash scripts/install_gzweb.sh

COPY . .
RUN git submodule update --init --recursive

# Get external projects
ARG GITHUB_PAT
RUN bash scripts/clone_external_projects.sh ${GITHUB_PAT}

RUN bash -c "source /opt/ros/kinetic/setup.bash && catkin_make"

ENTRYPOINT ["./entrypoint.sh"]
CMD bash
