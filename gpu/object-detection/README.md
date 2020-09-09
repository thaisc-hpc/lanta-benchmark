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


