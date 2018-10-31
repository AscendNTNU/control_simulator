FROM gazebo:libgazebo7
MAINTAINER "rendellc@ascendntnu.no"


# install dependencies
ENV GZWEB_WS /root/gzweb
ENV SCRIPT_DIR /root/scripts

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

# get gzweb
RUN hg clone https://bitbucket.org/osrf/gzweb $GZWEB_WS

# get node: TODO: upgrade to node 9 when it starts lts
RUN curl -sL https://deb.nodesource.com/setup_8.x >> setup_8.sh \
  && chmod +x setup_8.sh \
  && ./setup_8.sh \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

# get local models
WORKDIR $GZWEB_WS
ARG GZRESOURCES_DIR
COPY $GZRESOURCES_DIR/models http/client/assets

# build gzweb
RUN /bin/bash -c "source /usr/share/gazebo/setup.sh \
  && hg up gzweb_1.4.0 \
  && npm run deploy --- -m local"

# setup environemt
CMD ["/bin/bash", "-c", "\
  GAZEBO_MASTER_URI=http://gzserver:11345 \
  && npm start \
  "]

