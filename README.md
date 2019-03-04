# Two View 3D construction

## Fork from https://github.com/xiumingzhang/GenRe-ShapeHD
In order to extend the MarrNet architecture to take two views of the same object as input, we maintain the architecture of 2.5D sketch estimator and modify 3D shape estimator to be able to input the two stacked 2.5D sketches. Several fusion strategies are experimented.

## Environment Setup

All code was built and tested on Ubuntu 16.04.5 LTS with Python 3.6, PyTorch 0.4.1, and CUDA 9.0. Versions for other packages can be found in `environment.yml`.

1. Clone this repo with
	```
    # cd to the directory you want to work in
	```
	The code below assumes you are at the repo root.

1. Create a conda environment named `shaperecon` with necessary dependencies specified in `environment.yml`. In order to make sure trimesh is installed correctly, please run `install_trimesh.sh` after setting up the conda environment.
	```
	conda env create -f environment.yml
	./install_trimesh.sh
	```
	The TensorFlow dependency in `environment.yml` is for using TensorBoard only. Remove it if you do not want to monitor your training with TensorBoard.

1. The instructions below assume you have activated this environment with
	```
	source activate shaperecon
	```

## Citation


@article{marr1982vision,
  title={Vision: A computational investigation into the human representation and processing of visual information. MIT Press},
  author={Marr, David},
  journal={Cambridge, Massachusetts},
  year={1982}
}

@article{deepfuse,
  author    = {K. Ram Prabhakar and
               V. Sai Srikar and
               R. Venkatesh Babu},
  title     = {DeepFuse: {A} Deep Unsupervised Approach for Exposure Fusion with
               Extreme Exposure Image Pairs},
  journal   = {CoRR},
  volume    = {abs/1712.07384},
  year      = {2017},
  url       = {http://arxiv.org/abs/1712.07384},
  archivePrefix = {arXiv}
}

@article{
  author    = {Joseph Redmon and
               Ali Farhadi},
  title     = {YOLOv3: An Incremental Improvement},
  journal   = {CoRR},
  volume    = {abs/1804.02767},
  year      = {2018},
  url       = {http://arxiv.org/abs/1804.02767},
  archivePrefix = {arXiv}
}

## Citation
@inproceedings{stgcn2018aaai,
  title     = {Spatial Temporal Graph Convolutional Networks for Skeleton-Based Action Recognition},
  author    = {Sijie Yan and Yuanjun Xiong and Dahua Lin},
  booktitle = {AAAI},
  year      = {2018},
}

