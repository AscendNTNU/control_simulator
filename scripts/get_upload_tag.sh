#!/bin/bash

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
if [ $BRANCH_NAME == master ]; then
  echo "latest"
else
  echo "edge"
fi

