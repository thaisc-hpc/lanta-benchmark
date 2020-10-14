# VASP Benchmark
**Version**: VASP.6.1.1 19Jun20  
**Website**: https://www.vasp.at/

## Benchmark rules

* Only VASP version **6.1.1 19Jun20** is allowed
* No code modification is allowed
* Calculation must be performed with double-precision accuracy
* VASP GPU with OpenACC implementation must be used
* Compiling using NVIDIA HPC SDK is recommended
* Only `vasp_std` and `vasp_gam` are allowed (when applicable)
* The tester is responsible for their own VASP license used in the test
* Input files (`POSCAR`, `INCAR` and `KPOINTS`) are not allowed to change

## Input

### Input Systems

VASP gpu benchmark consist of 4 input systems:
- B.hR105
- Pt_111_512
- TiO2
- ZrO2

Each of the system represent various workload/algorithm that are common among VASP users. Hence, input files (`POSCAR`, `KPOINTS`, `INCAR`) are not allowed to change.

### Potentials (POTCAR)

`POTCAR` must be provided by the tester and `potpaw_PBE54` must be used. 


### Summary

| Benchmark     | B.hR105  | Pt_111_512|TiO2      |ZrO2      |
| ------------- |---------:| ---------:|---------:|---------:|
| IONS          | 105      | 512       | 384      | 120      |
| POTCAR        | B        | Pt        | Ti_sv, O | Zr_sv, O |
| ENCUT (eV)    | 319      | 400       | 450      | 450      |
| PREC          | Normal   | Normal    | Accurate | Accurate |
| ALGO          | Normal   | Fast      | Fast     | Normal   |
| NELM (NELMDL) | 30 (5)   | 30 (5)    | 30 (5)   | 50 (5)   |
| KPOINTS       | 2 2 2    | 2 2 1     | 1 1 1    | 3 3 1    |


## Running

### Number of nodes

All of the testcases are expected to perform on **2 gpu nodes with 4 NVIDIA A100 GPUs on each server**.

### Example (SLURM)

``` 
srun -N 2 --ntasks-per-node=4 vasp_std_openacc
```

Timing will be based on `"LOOP+"` of the first ionic iteration. The result extraction script (`get_result.sh`) is included within each input folder. 

## Correctness of the Benchmark

Benchmark must be performed in the way that the correctness of the scientific result is maintained. In all the VASP gpu benchmarks, the single-point energy calculation is performed.  Therefore, as least, the energy differences between the sucessive self-consistent fields (SCF) iterations of the last few steps of the calculation must be less than 1E-5 eV.

Note that there might be some warning messages such as `num prob` and `WARNING in EDDRMM:` in the STDOUT of some benchmarks. As long as the SCF iterations are scientifically sound, these messages can be safely disregarded.

## Performance 

Use performance extraction script (`get_result.sh`) in each testcase's folder to obtain performance results. The script will generate `benchmark_result.txt` containing performance result. An example `benchmark_result.txt` is shown below


```
Benchmark performance =    199.298 jobs/day 
```

Here, benchmark performance of 199.298 jobs/day will be used in a benchmark report.

## Reference

1. https://github.com/smaintz-nv/gpu-vasp-files/blob/master/benchmarks/B.hR105
1. https://www.nersc.gov/assets/Uploads/Using-VASP-at-NERSC-20180629.pdf
