#!/bin/bash

docker build --rm -f "Dockerfile" -t control_simulator_builder .
docker run --privileged -u root \
  -v $HOME/.ssh:/root/.ssh \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/bin/docker \
  control_simulator_builder

