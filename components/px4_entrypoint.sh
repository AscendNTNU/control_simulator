#!/bin/bash

set +e 

./build/posix_sitl_default/px4 -d . posix-configs/SITL/init/ekf2/ascend

#CMD ["./Tools/sitl_run.sh", \
#  "./build/posix_sitl_default/px4", \
#  "posix-configs/SITL/init/ekf2", \
#  "none", \
#  "none", \ 
#  "ascend", \
#  ".", \
#  "./build/posix_sitl_default"]
