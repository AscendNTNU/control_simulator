FROM gazebo:libgazebo7
MAINTAINER "rendellc@ascendntnu.no"

RUN apt-get update && apt-get install -q -y \
  build-essential \
  cmake \
  curl \
  imagemagick \
  libboost-all-dev \
  libgazebo7-dev \
  libjansson-dev \
  libtinyxml-dev \
  mercurial \
  pkg-config \
  psmisc \
  xvfb \
  && rm -rf /var/lib/apt/lists/*

# setup environemt
ARG GZRESOURCES_DIR
WORKDIR /home/user/gzserver
COPY $GZRESOURCES_DIR .
ENV GAZEBO_MODEL_PATH ${GAZEBO_MODEL_PATH}:/home/user/gzserver/models
ENV GAZEBO_PLUGIN_PATH ${GAZEBO_PLUGIN_PATH}:/home/user/gzserver/plugins
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/home/user/gzserver/plugins


ENV WORLD_FILE testing.world
CMD ["/bin/bash", "-c", "\
  Xvfb :1 -screen 0 1280x720x16 & \
  export DISPLAY=:1.0 \ 
  && gzserver --verbose worlds/${WORLD_FILE}"]

