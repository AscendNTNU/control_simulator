#!/bin/bash

if [[ $# -ne 3 ]]; then
  echo "usage: $0 <path-to-sitl_gazebo> <build-dir> <iris-instance>"
  exit 1
fi

#sitl_path=/home/cale/control_simulator/gzresources/sitl_gazebo
sitl_path=$1
build_path=$2
iris_i=$3

echo "building $iris_i in $(realpath $build_path)"

iris_path=$(realpath $build_path/iris_$iris_i)
models_path=$1/models

rm -rf $iris_path
mkdir -p $iris_path


python $sitl_path/scripts/xacro.py -o $models_path/rotors_description/urdf/iris_base.urdf \
  $models_path/rotors_description/urdf/iris_base.xacro \
  enable_mavlink_interface:=true enable_ground_truth:=false enable_wind:=false enable_logging:=false \
  rotors_description_dir:=$models_path/rotors_description send_vision_estimation:=false send_odometry:=false

gz sdf -p $models_path/rotors_description/urdf/iris_base.urdf >> $iris_path/iris.sdf

sed -i -e "s/name='iris'/name='iris_$iris_i'/g" $iris_path/iris.sdf
sed -i -e "s/<mavlink_addr>INADDR_ANY<\/mavlink_addr>/<mavlink_addr>px4_$iris_i<\/mavlink_addr>/g" $iris_path/iris.sdf

rm -f $sitl_path/models/rotors_description/urdf/iris_base.urdf

