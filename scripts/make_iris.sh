#!/bin/bash

verify_argument()
{
  local d="$1"
  [[ -z $d ]] && { echo "usage: $0 <path-to-sitl_gazebo> <build-dir> <iris-instance>"; exit 1; }
}

make_single_iris()
{
  sitl_path=$1
  build_path=$2
  iris_i=$3

  verify_argument $sitl_path
  verify_argument $build_path
  verify_argument $iris_i

  echo "building $iris_i in $(realpath $build_path)"

  iris_path=$(realpath $build_path/iris_$iris_i)
  models_path=$1/models

  rm -rf $iris_path
  mkdir -p $iris_path

  # iris.sdf
  python $sitl_path/scripts/xacro.py -o $models_path/rotors_description/urdf/iris_base.urdf \
    $models_path/rotors_description/urdf/iris_base.xacro \
    enable_mavlink_interface:=true enable_ground_truth:=false enable_wind:=false enable_logging:=false \
    rotors_description_dir:=$models_path/rotors_description send_vision_estimation:=false send_odometry:=false

  gz sdf -p $models_path/rotors_description/urdf/iris_base.urdf >> $iris_path/iris.sdf

  # Add custom mesh
  sed -i -e "s/iris.stl/ascend_body.dae/g" $iris_path/iris.sdf

  # Realign rotors
  sed -i -e "s/0.13\ -0.22\ 0.023/0.15\ -0.15\ 0.023/g" $iris_path/iris.sdf
  sed -i -e "s/-0.13\ 0.2\ 0.023/-0.15\ 0.15\ 0.023/g" $iris_path/iris.sdf
  sed -i -e "s/0.13\ 0.22\ 0.023/0.15\ 0.15\ 0.023/g" $iris_path/iris.sdf
  sed -i -e "s/-0.13\ -0.2\ 0.023/-0.15\ -0.15\ 0.023/g" $iris_path/iris.sdf

  # Network configuration
  sed -i -e "s/name='iris'/name='iris_$iris_i'/g" $iris_path/iris.sdf
  sed -i -e "s/<mavlink_addr>INADDR_ANY<\/mavlink_addr>/<mavlink_addr>px4_$iris_i<\/mavlink_addr>/g" $iris_path/iris.sdf
  #sed -i -e "s/<mavlink_addr>INADDR_ANY<\/mavlink_addr>/<mavlink_addr>drone_$iris_i<\/mavlink_addr>/g" $iris_path/iris.sdf

  # model.config
  cp $models_path/iris/model.config $iris_path/
}

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <n>"
  exit 1
fi

iris_n=$1
shdir=$(realpath $(dirname $0))

for (( i=1; i<=$iris_n; i++ ))
do
  make_single_iris $shdir/../gzresources/sitl_gazebo $shdir/../gzresources/models $i
done

