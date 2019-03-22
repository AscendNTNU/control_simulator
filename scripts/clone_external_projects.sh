#/bin/bash

TOKEN=$1

git clone https://github.com/AscendNTNU/ascend_msgs.git src/ascend_msgs 
if [ -z "$TOKEN" ]
then
  echo "TOKEN not set, ignoring private repositories"
else
  git clone https://${TOKEN}:@github.com/AscendNTNU/ascend_utils.git src/ascend_utils
  git clone https://${TOKEN}:@github.com/AscendNTNU/fluid_fsm.git src/fluid_fsm 
fi
