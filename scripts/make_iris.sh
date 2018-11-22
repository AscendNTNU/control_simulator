#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "usage: $0 <path-to-iris.sdf directory> <n>"
  exit 1
fi

iris_path=$1
iris_n=$2

for (( i=1; i<=$iris_n; i++ ))
do
  echo "$i"
  cp -rf $iris_path iris_$i
  pushd .
  cd iris_$i
  sed -i -e "s/name='iris'/name='iris_$i'/g" iris.sdf
  sed -i -e "s/<mavlink_addr>INADDR_ANY<\/mavlink_addr>/<mavlink_addr>px4_$i<\/mavlink_addr>/g" iris.sdf
  popd
done

