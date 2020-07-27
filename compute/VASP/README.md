# VASP Benchmark
Version : VASP.5.4.4.18APR17
Website : https://www.vasp.at/

## Benchmark rules
- Only VASP version 5.4.4 with 18ARR17 patch is allowed
- No code modification is allowed
- Calculation must be performed with double-precision accuracy
- Use vasp_gam for gamma-point only systems. Otherwise, only vasp_std is allowed.

## Input

**Input Systems**
VASP benchmark consist of 4 input systems:
- B.hR105 [1]
- Pt_111_252
- TiO2
- ZrO2

Each of the system represent various workload/algorithm that are common among VASP users. Hence, input files (POSCAR, KPOINTS) are now allowed to change. For INCAR, only NCORE and NSIM are allowed to change.

**Potentials (POTCAR)**
POTCAR must be provided by the tester. based on `potpaw_PBE54` must be used. 



**Summary**

| Benchmark     | B.hR105       | Pt_111_252  |TiO2        |ZrO2        |
| ------------- |:-------------:| -----------:|-----------:|-----------:|
| IONS          | 105      | 256       | 384      | 120      |
| POTCAR        | PAW_PBE B 06Sep2000  | PAW_PBE Pt 04Feb2005 | PAW_PBE O 08Apr2002, Ti_sv 26Sep2005      |PAW_PBE Zr_sv 04Jan2005,  PAW_PBE O 08Apr2002 |
| ENCUT (eV)    | 319      | 400       | 450      | 450      |
| PREC.         | Normal   | Normal    | Accurate | Accurate |
| ALGO          | Normal   | Very Fast | Fast     | Normal   |
| NELM (NELMDL) | 6 (5)    | 25 (5)    | 10 (3)   | 10 (3)   |
| KPOINTS       | 2 2 2    | 2 2 1     | 1 1 1    | 3 3 1    |

## Running


**Example (SLURM)**
```
#!/bin/bash
#SBATCH -p PARTITION                    # specific partition
#SBATCH -N 4                            # specific number of nodes required
#SBATCH --ntasks-per-node=40            # specific number of cores and task per node

# run the command
srun vasp_std

```

Timing will be based on "LOOP+" of the first ionic iteration. The result extraction script (`get_result.sh`) is included within each input folders. 

## Performance 
Use performance extraction script (`get_result.sh`) included in each testcase's folder to obtain performance results. See result in "benchmark_result.txt"
