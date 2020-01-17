#!/bin/bash

repo_path="/media/remote_home/tridiv/VMZ"
epic_kitchens_path="/media/data/tridiv/epic_kitchens/EPIC_KITCHENS_2018/videos"

# Run script for feature extraction
docker run --rm --gpus all \
	--name vmz_feat_ext \
    --workdir /home/$USER/VMZ/ \
	-v $repo_path:"/home/$USER/VMZ" \
	-v $epic_kitchens_path:"/home/$USER/epic_kitchens" \
	vmz:pytorch-cuda10.1-cudnn7 \
    python tools/extract_features.py \
    --test_data=/home/$USER/VMZ/lmdb_data \
    --model_name=r2plus1d --model_depth=152 --clip_length_rgb=32 \
    --gpus=0 \
    --num_iterations=1 \
    --batch_size=1 \
    --load_model_path=/home/$USER/VMZ/weights/r2plus1d_152_ft_kinetics_from_sports1m_f128957437.pkl \
    --output_path=my_features.pkl \
    --features=softmax,final_avg,video_id \
    --sanity_check=0 --get_video_id=1 --use_local_file=1 --num_labels=400