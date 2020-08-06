# Object Detection Benchmark

**Website**: https://mlperf.org/  
**Version**: v0.7

## Benchmark Rules

This benchmark uses [MLPerf closed division rule](https://github.com/mlperf/training_policies/blob/master/training_rules.adoc#closed-division), which requires using the same preprocessing, model, and training method as the reference implementation.

The model and dataset used for this benchmark is specified in `Object detection (heavy weight)`. 

Reference implementation and instruction can be found [here](https://github.com/mlperf/training/tree/master/object_detection).

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

