#!/usr/bin/env bash

# Test ShapeHD

export CUDA_HOME=/opt/cuda-9.0.176.1/

export CUDNN_HOME=/opt/cuDNN-7.0/

export STUDENT_ID=$(whoami)

export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH

export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH

export CPATH=${CUDNN_HOME}/include:$CPATH

export PATH=${CUDA_HOME}/bin:${PATH}

export PYTHON_PATH=$PATH

mkdir -p /disk/scratch/${STUDENT_ID}


export TMPDIR=/disk/scratch/${STUDENT_ID}/
export TMP=/disk/scratch/${STUDENT_ID}/

mkdir -p ${TMP}/datasets/
export DATASET_DIR=${TMP}/datasets/


out_dir="./output/test"
net1=./downloads/models/marrnet1_with_minmax.pt
net2=./downloads/models/shapehd.pt
rgb_pattern='./downloads/data/test/shapehd/*_rgb.*'
mask_pattern='./downloads/data/test/shapehd/*_mask.*'



python 'test.py' \
    --net shapehd \
    --net_file "$net2" \
    --marrnet1_file "$net1" \
    --input_rgb "$rgb_pattern" \
    --input_mask "$mask_pattern" \
    --output_dir "$out_dir" \
    --suffix '{net}' \
    --overwrite \
    --workers 1 \
    --batch_size 1 \
    --vis_workers 4 \
    --gpu "0"


