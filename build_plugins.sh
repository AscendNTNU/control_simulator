#!/bin/bash

gzres=$(dirname $(realpath $0))/gzresources

cd $gzres
if [ ! -d "sitl_gazebo" ]; then
  echo "sitl_gazebo not found, fetching"
  git submodule update --recursive --init
fi

cd sitl_gazebo
if [ ! -d "build" ]; then
  mkdir build
fi

cd build
cmake ..
make

echo "Compilation done, transfering files"
cp *.so $gzres/plugins


