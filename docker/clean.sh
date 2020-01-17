# /usr/bin/env bash

# Remove stopped containers
docker rm $(docker ps -a -q)

# Remove image
# docker rmi vmz:caffe2
docker rmi vmz:pytorch