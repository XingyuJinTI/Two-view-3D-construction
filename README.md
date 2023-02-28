# Two View 3D construction 

## Introduction

We proposed a generic, simple fusion technique to improve 3D shape reconstruction. 

**Algorithm**. We extend the [MarrNet](https://github.com/xiumingzhang/GenRe-ShapeHD) architecture to take two views of the same object as input. To do so, we maintain the architecture of 2.5D sketch estimator and modify 3D shape estimator to be able to input the two stacked 2.5D sketches. Several fusion strategies are experimented.

This is an intermediate experimental architecture to understand if two-view fusion can really make an improvement as we expected. Please visit [DeepView](https://github.com/Xingyu-Jin/DeepView3D) for the final algorithm that won the first place of IBM Prize for Machine Learning. 

## Architecture 

### Two View MarrNet Architecture

<img src="/assets/Two_View_MarrNet.png" width="600">


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

## Models for two-view MarrNet

In the file 'models', there are different models including two-view marrnets. 2D feature maps of images are fused by concatenation, addition, Max. In addition, we are doing the experiment on the different fusion strategies on Latent Vector level: concatenating two 200-dim vector into one 400-dim, concatenating them parallel (i.e. 2x200 dim) followed by 1 Conv layer or Multi-CNN.

## Training Data

1. For training, the original authors make available their RGB and 2.5D sketch renderings, paired with their corresponding 3D shapes, for ShapeNet cars, chairs, and airplanes, with each object captured in 20 random views. Note that this .tar is 143 GB. The dataset is based on ShapeNet.
	```
	wget http://genre.csail.mit.edu/downloads/shapenet_cars_chairs_planes_20views.tar -P downloads/data/
	mkdir downloads/data/shapenet/
	tar -xvf downloads/data/shapenet_cars_chairs_planes_20views.tar -C downloads/data/shapenet/
	```
## Results

### Quantitive result

<img src="/assets/results.png" width="330">

Two-View MarrNet with each kind of the fusion layer can achieve a higher IoU than the baseline model (MarrNet).

### Qualitive result

<img src="/assets/visualisation.png" width="400">

Two-View Marrnet is able to generate more complete with more details and higher accuracy than MarrNet.

Note, the improvement shown in two-view MarrNet is generalisable fusion strategy which can also be applied to ShapeHD and GenRe as well.


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
