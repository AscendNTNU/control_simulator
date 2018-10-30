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

CMD ["gzserver", "--verbose", "worlds/testing.world"]

