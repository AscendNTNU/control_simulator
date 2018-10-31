# control_simulator
The most advanced simulator ever


## Build gzserver/gzweb
`docker build -t gzserver --build-arg GZRESOURCES_DIR=./gzresources -f gzserver/Dockerfile .`
`docker build -t gzweb --build-arg GZRESOURCES_DIR=./gzresources -f gzweb/Dockerfile .`
