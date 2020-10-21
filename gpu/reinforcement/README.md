# Reinforcement Learning Benchmark

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

### Measuring Performance

The performance measurement method follows [MLPerf instruction](https://github.com/mlperf/training_policies/blob/master/training_rules.adoc#run-results). The performance result is based on a set of run results. For reinforcement learning, **the number of runs is 10**. Note that, text files containing output from each run (one file per run) must be submitted with the results. See. [NVIDIA results](https://github.com/mlperf/training_results_v0.7/tree/master/NVIDIA/results/dgx2_ngc20.06_tensorflow/minigo) for example submission.   

The execution time of each run is taken from [`run_and_time.sh`](https://github.com/mlperf/training_results_v0.7/blob/master/NVIDIA/benchmarks/minigo/implementations/tensorflow/run_and_time.sh) script from the line `Model ...... beat target after XXX.XXXs`.  

Following is an example output one run of reinforcement learning benchmark

```bash
...
...
:::MLLOG {"namespace": "", "time_ms": 1594520079101, "event_type": "INTERVAL_END", "key": "eval_stop", "value": null, "metadata": {"file": "./ml_perf/logger.py", "lineno": 27, "epoch_num": 43}}
:::MLLOG {"namespace": "", "time_ms": 1594520079101, "event_type": "INTERVAL_START", "key": "eval_start", "value": null, "metadata": {"file": "./ml_perf/logger.py", "lineno": 27, "epoch_num": 44}}
:::MLLOG {"namespace": "", "time_ms": 1594520079101, "event_type": "POINT_IN_TIME", "key": "eval_accuracy", "value": 0.51953125, "metadata": {"file": "./ml_perf/logger.py", "lineno": 27, "epoch_num": 44}}
:::MLLOG {"namespace": "", "time_ms": 1594520079101, "event_type": "INTERVAL_END", "key": "eval_stop", "value": null, "metadata": {"file": "./ml_perf/logger.py", "lineno": 27, "epoch_num": 44}}
Model 000061 beat target after 27795.624s
:::MLLOG {"namespace": "", "time_ms": 1594520079101, "event_type": "POINT_IN_TIME", "key": "eval_result", "value": 0.51953125, "metadata": {"file": "./ml_perf/logger.py", "lineno": 27, "epoch_num": 44, "timestamp": 27795.624}}
:::MLLOG {"namespace": "", "time_ms": 1594511656964, "event_type": "INTERVAL_END", "key": "run_stop", "value": null, "metadata": {"file": "./ml_perf/logger.py", "lineno": 27, "status": "success"}}
+ '[' 0 -eq 0 ']'
Done with benchmark REINFORCEMENT - Minigo
+ '[' 0 -eq 0 ']'
+ set +x
ENDING TIMING RUN AT 2020-07-11 07:14:44 PM
```

For this example, the execution time of this run is 27795.624 seconds. 

The performance result is computed by dropping the fastest and slowest runs, then taking the mean of the remaining times. For this purpose, a single non-converging run may be treated as the slowest run and dropped. A benchmark result is invalid if there is more than one non-converging run.

The final mean execution time will be convert to `jobs/day`, which will be used for computing quality score. 

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
