FROM ubuntu:16.04
MAINTAINER "rendellc@ascendntnu.no"

# install build dependencies, TODO: unite RUN statements
RUN apt-get update && apt-get install -y  \
  build-essential \
  cmake \
  exiftool \
  genromfs \
  git \
  ninja-build \
  python-argparse \
  python-dev \
  python-empy \
  python-numpy \
  python-pip \
  python-toml \
  wget \
  zip 
RUN python -m pip install --upgrade pip \
  && python -m pip install pandas jinja2 pyserial pyulog
WORKDIR /home/user
RUN wget http://www.eprosima.com/index.php/component/ars/repository/eprosima-fast-rtps/eprosima-fast-rtps-1-5-0/eprosima_fastrtps-1-5-0-linux-tar-gz -O eprosima_fastrtps-1-5-0-linux.tar.gz \
    && tar -xzf eprosima_fastrtps-1-5-0-linux.tar.gz eProsima_FastRTPS-1.5.0-Linux/ \
    && tar -xzf eprosima_fastrtps-1-5-0-linux.tar.gz requiredcomponents \
    && tar -xzf requiredcomponents/eProsima_FastCDR-1.0.7-Linux.tar.gz \
    && cpucores=$(( $(lscpu | grep Core.*per.*socket | awk -F: '{print $2}') * $(lscpu | grep Socket\(s\) | awk -F: '{print $2}') )) \
    && cd eProsima_FastCDR-1.0.7-Linux; ./configure --libdir=/usr/lib; make -j$cpucores; make install \
    && cd .. \
    && cd eProsima_FastRTPS-1.5.0-Linux; ./configure --libdir=/usr/lib; make -j$cpucores; make install \
    && cd .. \
    && rm -rf requiredcomponents eprosima_fastrtps-1-5-0-linux.tar.gz 

# get px4, TODO: use ascends private px4 instead
ENV PX4_DIR /home/user/Firmware
RUN git clone -b ascend-v1.8.1 https://github.com/AscendNTNU/Ascend-PX4.git $PX4_DIR

WORKDIR $PX4_DIR
RUN DONT_RUN=1 make posix_sitl_default

CMD ["/bin/bash", "-c", "./build/posix_sitl_default/px4 . ./posix-configs/SITL/init/ekf2/ascend"]

#CMD ["./Tools/sitl_run.sh", \
#  "./build/posix_sitl_default/px4", \
#  "posix-configs/SITL/init/ekf2", \
#  "none", \
#  "none", \ 
#  "ascend", \
#  ".", \
#  "./build/posix_sitl_default"]
