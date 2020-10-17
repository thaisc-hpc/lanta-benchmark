# VASP Benchmark
**Version**: VASP.5.4.4.18APR17 **or** VASP 6.1.1.19JUN20 
**Website**: https://www.vasp.at/

## Benchmark rules

* Only VASP versions **5.4.4 with 18ARR17 patch** or **6.1.1 19Jun20** is allowed
* No code modification is allowed
* Calculation must be performed with double-precision accuracy
* Only `vasp_std` and `vasp_gam` are allowed (when applicable)
* The tester is responsible for their own VASP license used in the test
* Input files (`POSCAR` and `KPOINTS`) are not allowed to change. For `INCAR`, only `NCORE`, `KPAR`, `LPLANE` and `NSIM` can be changed.

## Input

### Input Systems

VASP benchmark consist of 4 input systems:
- B.hR105
- Pt_111
- TiO2
- ZrO2

Each of the system represent various workload/algorithm that are common among VASP users. Hence, input files (`POSCAR`, `KPOINTS`) are not allowed to change. For `INCAR`, only `NCORE`, `KPAR`, `LPLANE` and `NSIM` can be changed.

### Potentials (POTCAR)

`POTCAR` must be provided by the tester and `potpaw_PBE54` must be used. 


### Summary

| Benchmark     | B.hR105  | Pt_111    |TiO2      |ZrO2      |
| ------------- |---------:| ---------:|---------:|---------:|
| IONS          | 105      | 256       | 384      | 120      |
| POTCAR        | B        | Pt        | Ti_sv, O | Zr_sv, O |
| ENCUT (eV)    | 319      | 400       | 450      | 450      |
| PREC          | Normal   | Normal    | Accurate | Accurate |
| ALGO          | Normal   | Fast      | Fast     | Normal   |
| NELM (NELMDL) | 30 (5)   | 30 (5)    | 30 (5)   | 50 (5)   |
| KPOINTS       | 2 2 2    | 2 2 1     | 1 1 1    | 3 3 1    |

## Running

### Number of nodes

All of the testcases are expected to perform on **4 compute nodes** (dual-socket CPU-only node).

### Example (SLURM)

``` 
srun -N 4 --ntasks-per-node=40 vasp_std
```

Timing will be based on `"LOOP+"` of the first ionic iteration. The result extraction script (`get_result.sh`) is included within each input folder. 

## Correctness of the Benchmark

Benchmark must be performed in the way that the correctness of the scientific result is maintained. In all the VASP gpu benchmarks, the single-point energy calculation is performed.  Therefore, at least, the energy differences between the sucessive self-consistent fields (SCF) iterations of the last few steps of the calculation must be smaller than 1E-4 eV.

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
