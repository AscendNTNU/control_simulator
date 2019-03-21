#!/bin/bash

gzwebdir=$1
httpport=$2

cd $gzwebdir
npm_config_port=$httpport npm start
