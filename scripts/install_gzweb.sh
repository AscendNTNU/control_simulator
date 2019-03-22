#!/bin/bash

shdir=$(realpath $(dirname $0))
modeldir=$(realpath $shdir/../src/control_simulator/models)

pushd $HOME
hg clone https://bitbucket.org/osrf/gzweb

curl -sL https://deb.nodesource.com/setup_8.x >> setup_8.sh
chmod +x setup_8.sh
./setup_8.sh
apt-get install -y nodejs
rm setup_8.sh

export GAZEBO_MODEL_PATH=$modeldir
cd gzweb
source /usr/share/gazebo/setup.sh
hg up gzweb_1.4.0
npm run deploy --- -t -m local

popd
