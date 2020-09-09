# Object Detection Benchmark

**Website**: https://mlperf.org/  
**Version**: v0.7  
**Reference Implementation**: https://github.com/mlperf/training_results_v0.7/tree/master/NVIDIA/benchmarks/maskrcnn/implementations/pytorch  

## Benchmark Rules

This benchmark uses [MLPerf closed division rule](https://github.com/mlperf/training_policies/blob/master/training_rules.adoc#closed-division), which requires using the same preprocessing, model, and training method as the reference implementation.

The model and dataset used for this benchmark is specified in `Object detection (heavy weight)`. 

For this benchmark, we will use **NVIDIA implementation of Mask R-CNN from MLPerf training v0.7 submission** as the reference implementation. The code can be found in MLPerf training v0.7 submission [here](https://github.com/mlperf/training_results_v0.7/tree/master/NVIDIA/benchmarks/maskrcnn/implementations/pytorch).

### Dataset

Microsoft COCO (**2017 version**)

**Data Preprocessing**: Only horizontal flips are allowed.  
**Training and test data separation**: As provided by MS-COCO.  
**Training data order**: Randomly.  
**Test data order**: Any order.

### Software Tools

Any tools used to build and run the benchmark (including pre-processors, compilers, static and dynamic linkers, operating systems, container systems) must be generally available.

**These tools must be available to and usable by ThaiSC and its users without any restrictions when the system is deployed.**

## Running Benchmark

The benchmark is expected to run on **4 GPU nodes**.

### Running with Slurm and NVIDIA Docker

Please refer to NVIDIA instruction ([README](https://github.com/mlperf/training_results_v0.7/blob/master/NVIDIA/benchmarks/maskrcnn/implementations/pytorch/README.md), [INSTALLATION](https://github.com/mlperf/training_results_v0.7/blob/master/NVIDIA/benchmarks/maskrcnn/implementations/pytorch/INSTALL.md), and [`run.sh`](https://github.com/mlperf/training_results_v0.7/blob/master/NVIDIA/benchmarks/maskrcnn/implementations/pytorch/run_and_time.sh) ) for running benchmark with Slurm and NVIDIA docker.

### Running with Slurm and Singularity

Another approach is to run training with Slurm and Singularity. 

Assuming that you already download COCO dataset and required weight. 
First, build singularity image from NGC using following command.

``` bash
singularity build pytorch20.06-ngc.sif docker://nvcr.io/nvidia/pytorch:20.06-py3
```

Then, build maskrnn with following command 

``` bash
singularity exec --nv pytorch20.06-ngc.sif python setup.py build develop
```

Following is our Slurm submission script for running on TARA cluster.

``` bash
#!/bin/bash

REPO_PATH=/path/to/mlperf/training_results_v0.7/NVIDIA/benchmarks/maskrcnn/implementations/pytorch

ml Singularity

# Configure environment to run on DGX1 machine
. config_DGX1.sh

PYTHONPATH=$REPO_PATH:$PYTHONPATH time singularity exec --nv \ 
 -B path/to/coco/:/data \
 -B path/to/coco/:/coco \
 -B ./modules:/modules \
 pytorch20.06-ngc.sif \
 python -u -m bind_launch \
 --nsockets_per_node=2 \
 --ncores_per_socket=20 \
 --nproc_per_node=8 \
 tools/train_mlperf.py ${EXTRA_PARAMS} \
 --config-file 'configs/e2e_mask_rcnn_R_50_FPN_1x.yaml' \
 DTYPE 'float16' \
 PATHS_CATALOG 'maskrcnn_benchmark/config/paths_catalog_dbcluster.py' \
 MODEL.WEIGHT '/coco/models/R-50.pkl' \
 DISABLE_REDUCED_LOGGING True ${EXTRA_CONFIG}
```
Note that `EXTRA_PARAMS` and `EXTRA_CONFIG` is set by `config_DGX1.sh`.

### Troubleshooting

#### Missing `mlperf-logging` 

`mlperf-logging` Python package can be downloaded from https://github.com/mlperf/logging . The repository contains installation instruction as follows

- For development, you may download the latest version and install from local path:

  ```sh
  git clone https://github.com/mlperf/logging.git mlperf-logging
  pip install -e mlperf-logging
  ```
