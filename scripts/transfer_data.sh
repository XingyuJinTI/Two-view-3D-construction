#!/usr/bin/env bash
#SBATCH -N 1	  # nodes requested
#SBATCH -n 1	  # tasks requested
#SBATCH --partition=LongJobs
#SBATCH --gres=gpu:1
#SBATCH --mem=12000  # memory in Mb
#SBATCH --time=0-08:00:00
#SBATCH --exclude=landonia[02-20]

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

mkdir -p ${TMP}/datasets/downloads/data/shapenet/03001627/
rsync -ua --progress /home/s1836694/mlpractical/GenRe-ShapeHD/downloads/data/shapenet/03001627/ ${TMP}/datasets/downloads/data/shapenet/03001627/
mkdir -p ${TMP}/datasets/downloads/data/shapenet/status/
rsync -ua --progress /home/s1836694/mlpractical/GenRe-ShapeHD/downloads/data/shapenet/status/ ${TMP}/datasets/downloads/data/shapenet/status/
export DATASET_DIR=/disk/scratch/${STUDENT_ID}/datasets/downloads/data/shapenet/


outdir=./output/marrnet2_multi

if [ $# -lt 2 ]; then
    echo "Usage: $0 gpu class[ ...]"
    exit 1
fi
gpu="$1"
class="$2"
shift # shift the remaining arguments
shift

set -e

python train.py \
    --net marrnet2 \
    --dataset shapenet \
    --classes "$class" \
    --canon_sup \
    --batch_size 4 \
    --epoch_batches 2500 \
    --eval_batches 5 \
    --optim adam \
    --lr 1e-3 \
    --epoch 200 \
    --vis_batches_vali 10 \
    --gpu "$gpu" \
    --save_net 10 \
    --workers 1 \
    --logdir "$outdir" \
    --suffix '{classes}_canon-{canon_sup}' \
    --tensorboard \
    --resume -1 \
    $*

