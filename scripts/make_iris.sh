#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <n>"
  exit 1
fi

iris_n=$1
shdir=$(realpath $(dirname $0))

for (( i=1; i<=$iris_n; i++ ))
do
  source $shdir/make_single_iris.sh $shdir/../gzresources/sitl_gazebo $shidir/../gzresources/models $i
done

