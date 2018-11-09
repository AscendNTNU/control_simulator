# control_simulator
The goal of this simulator is to provide a simulation environment where we can test the fsm, path planning, obstacle avoidance, enemy drone interaction, and more. 

## Requirements
Need to have recent versions of docker and docker-compose installed. 

## Getting started
`docker-compose up`

## Build gzserver/gzweb
`docker build -t gzserver --build-arg GZRESOURCES_DIR=./gzresources -f gzserver/Dockerfile .`

`docker build -t gzweb --build-arg GZRESOURCES_DIR=./gzresources -f gzweb/Dockerfile .`
