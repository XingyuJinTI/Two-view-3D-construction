#!/usr/bin/env bash

# Finetune MarrNet-2 with MarrNet-1 predictions

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

outdir=./output/marrnet
class=drc
marrnet1=/home/${STUDENT_ID}/marrnet1_10.pt
marrnet2=/home/${STUDENT_ID}/marrnet2_7.pt

python train.py \
    --net marrnet \
    --marrnet1 "$marrnet1" \
    --marrnet2 "$marrnet2" \
    --dataset shapenet \
    --classes "$class" \
    --batch_size 4 \
    --epoch_batches 2500 \
    --eval_batches 5 \
    --optim adam \
    --lr 1e-3 \
    --epoch 10 \
    --vis_batches_vali 10 \
    --gpu "0,1,2,3" \
    --save_net 10 \
    --workers 4 \
    --logdir "$outdir" \
    --suffix '{classes}' \
    --tensorboard
