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

ENV WORLD_FILE testing.world
CMD ["/bin/bash", "-c", "\
  GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/home/user/gzserver/models \
  && GAZEBO_PLUGIN_PATH=$GAZEBO_PLUGIN_PATH:/home/user/gzserver/plugins \
  && LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/user/gzserver/plugins \
  && echo $GAZEBO_MODEL_PATH \
  && gzserver --pause --verbose worlds/${WORLD_FILE}\
  "]

