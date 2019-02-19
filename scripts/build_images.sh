#!/bin/bash

docker build --rm -f "Dockerfile" -t control_simulator_builder .
docker run --privileged \
  -v $HOME/.ssh:/root/.ssh:ro \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/bin/docker \
  control_simulator_builder

