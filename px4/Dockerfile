FROM px4io/px4-dev-nuttx
MAINTAINER "rendellc@ascendntnu.no"

# get px4, TODO: use ascends private px4 instead
WORKDIR /src/firmware
RUN git clone https://github.com/PX4/Firmware.git 

RUN cd Firmware \
  && git checkout v1.8.1 \
  && /bin/bash -c "DONT_RUN=1 make posix_sitl_default"



