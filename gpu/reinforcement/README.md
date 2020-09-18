# Reinforcement Learning Benchmark [Tentative]

**This benchmark might not be included in the final benchmark depended on vendor's feedback**

**Website**: https://mlperf.org/  
**Version**: v0.7  
**Reference Implementation**: https://github.com/mlperf/training_results_v0.7/tree/master/NVIDIA/benchmarks/minigo/implementations/tensorflow

## Benchmark Rules

This benchmark uses [MLPerf closed division rule](https://github.com/mlperf/training_policies/blob/master/training_rules.adoc#closed-division), which requires the same preprocessing, model, and training method as the reference implementation.

The model and dataset used for this benchmark is specified in `Reinforcement Learning`. 

For this benchmark, we will use **NVIDIA implementation of Minigo from MLPerf training v0.7 submission** as the reference implementation. The code can be found in MLPerf training v0.7 submission [here](https://github.com/mlperf/training_results_v0.7/tree/master/NVIDIA/benchmarks/minigo/implementations/tensorflow).

### Software Tools

Any tools used to build and run the benchmark (including pre-processors, compilers, static and dynamic linkers, operating systems, container systems) must be generally available.

**These tools must be available to and usable by ThaiSC and its users without any restrictions when the system is deployed.**

## Running Benchmark

The benchmark is expected to run on **4 GPU nodes**.

### Running with Slurm and NVIDIA Docker

Please refer to NVIDIA instruction ([README](https://github.com/mlperf/training_results_v0.7/blob/master/NVIDIA/benchmarks/minigo/implementations/tensorflow/README.md) and [`run_and_time.sh`](https://github.com/mlperf/training_results_v0.7/blob/master/NVIDIA/benchmarks/minigo/implementations/tensorflow/run_and_time.sh) ) for running benchmark with Slurm and NVIDIA docker.

### Troubleshooting

#### Bazel cannot find some C header

When building with bazel, use `--spawn_strategy=local` flag to executed bazel commands as local subprocesses instead of sandbox. 

``` bash
mkdir -p "${MINIGO_BAZEL_CACHE_DIR}"  && \ 
  bazel --output_user_root="${MINIGO_BAZEL_CACHE_DIR}" build -c opt \
  --cxxopt="-D_GLIBCXX_USE_CXX11_ABI=0" \
  --copt=-O3 --copt="-v" \
  --define=board_size="${BOARD_SIZE}" \
  --define=tf=1 \
  --spawn_strategy=local \
  cc:minigo_python.so
```
