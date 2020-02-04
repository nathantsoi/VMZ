#!/bin/bash

########################################################
# Script to build the docker image                     #
# Author: tridivb                                      #
########################################################

# Build the image (if it exists, on top of the previous one)
echo "Building docker image..."
docker build --build-arg USER=$USER \
    --build-arg UID=$UID \
    -t vmz:pytorch-cuda10.1-cudnn7 \
    .

# Remove dangling images
echo "Removing dangling images..."
docker image prune -f