FROM px4io/px4-dev-nuttx
MAINTAINER "rendellc@ascendntnu.no"

ENV PX4_DIR /src/firmware/Firmware
RUN git clone https://github.com/PX4/Firmware.git $PX4_DIR 

RUN cd $PX4_DIR \
  && git checkout v1.8.1 \
  && /bin/bash -c "DONT_RUN=1 make posix_sitl_default"



