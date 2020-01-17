#!/bin/bash

########################################################
# Script to launch the docker container with a bash    #
# terminal                                             #
# Author: tridivb                                      #
########################################################

repo_path="/media/remote_home/tridiv/VMZ"
epic_kitchens_path="/media/data/tridiv/epic_kitchens/EPIC_KITCHENS_2018/videos"

# docker run --rm --gpus "device=$CUDA_VISIBLE_DEVICES" \
# 	--name vmz \
# 	-v $repo_path:"/home/$USER/VMZ" \
# 	-v $epic_kitchens_path:"/home/$USER/epic_kitchens" \
# 	-it vmz:pytorch \
# 	/bin/bash

docker run --rm --gpus all \
	--name vmz \
	-v $repo_path:"/home/$USER/VMZ" \
	-v $epic_kitchens_path:"/home/$USER/epic_kitchens" \
	-it vmz:pytorch-cuda10.1-cudnn7 \
	/bin/bash