# Copyright 2018-present, Facebook, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

python /home/tridiv/VMZ/tools/extract_features.py \
--test_data=/home/tridiv/VMZ/lmdb_data \
--model_name=r2plus1d --model_depth=152 --clip_length_rgb=32 \
--gpus=0 \
--num_iterations=1 \
--batch_size=1 \
--load_model_path=/home/tridiv/VMZ/weights/r2plus1d_152_ft_kinetics_from_sports1m_f128957437.pkl \
--output_path=my_features.pkl \
--features=softmax,final_avg,video_id \
--sanity_check=0 --get_video_id=1 --use_local_file=1 --num_labels=400
