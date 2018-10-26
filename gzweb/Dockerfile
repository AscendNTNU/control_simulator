FROM gazebo:libgazebo7

# install dependencies
ENV SCRIPT_DIR /root/scripts
RUN mkdir -p $SCRIPT_DIR
COPY scripts $SCRIPT_DIR
RUN $SCRIPT_DIR/install_gzweb_deps.sh

# get gzweb
ENV GZWEB_WS /root/gzweb
RUN hg clone https://bitbucket.org/osrf/gzweb $GZWEB_WS
WORKDIR $GZWEB_WS

# build gzweb
RUN hg up default 

# setup environemt
EXPOSE 8080




