# HPL Benchmark

**Website**: https://www.netlib.org/benchmark/hpl/  
**Recommended Version**: 2.3  

## Benchmark Rules

HPL rule is based on a modified version of [HPCC rule](https://icl.utk.edu/hpcc/overview/index.html). Moreover, all HPL submissions must comply with [top500 rules](https://www.top500.org/submit/). The rule is as follows

### Optimization

Optimizations as described below are allowed.

* Compiler and linker options
  * Compiler or linker flags which are supported and documented by the supplier are allowed. These include porting, optimization, and preprocessor invocation.

* Libraries
  * Linking to optimized versions of the following libraries is allowed:
    * BLAS
    * FFT
    * MPI
  * Acceptable use of such libraries is subject to the following rules:
    * All libraries used shall be disclosed with the results submission. Each library shall be identified by library name, revision, and institution supplying the source code.
  * Libraries which are not generally available are not permitted. These libraries must be available to and usable by ThaiSC and its users without any restrictions when the system is deployed.
  * ~Calls to library subroutines should have the same syntax and semantics as in the released benchmark code. Code modifications to accommodate various library call formats are not allowed.~

* Code Modification
  * Code modification to HPL source code are allowed as long as the modification is complied with [top500 rules](https://www.top500.org/submit/).
  * No changes are allowed in the DGEMM testing harness and the substituted DGEMM routine (if any) should conform to BLAS definition.

### Software Tools

Any tools used to build and run the benchmark (including pre-processors, compilers, static and dynamic linkers, operating systems) must be generally available. 

**These tools must be available to and usable by ThaiSC and its users without any restrictions when the system is deployed.**

### Input File

Input file `HPL.dat` can be edited for the target system.

## Getting HPL

HPL source code can be downloaded from https://www.netlib.org/benchmark/hpl/. We recommend the latest version (2.3) for this evaluation.

## Building HPL

Extract HPL source code

``` bash
tar -xvzf hpl-2.3.tar.gz
```

This will create a `hpl-2.3` directory containing all of HPL source files. We will refer to this directory as the top directory.

This directory contains instructions (the files `README` and `INSTALL`) on how to build HPL on your system. The `setup` directory contains many examples of build script files.  

## Running HPL

HPL benchmark is expected to run on **8 compute nodes**. An input file for HPL is `HPL.dat`. The explanation of each configuration can be read from `README.txt`. Following is an example input file.

```bash
HPLinpack benchmark input file
Innovative Computing Laboratory, University of Tennessee
HPL.out      output file name (if any)
8            device out (6=stdout,7=stderr,file)
1            # of problems sizes (N)
266880       Ns
1            # of NBs
192          NBs
0            PMAP process mapping (0=Row-,1=Column-major)
1            # of process grids (P x Q)
8            Ps
20           Qs
16.0         threshold
1            # of panel fact
2            PFACTs (0=left, 1=Crout, 2=Right)
1            # of recursive stopping criterion
4            NBMINs (>= 1)
1            # of panels in recursion
2            NDIVs
1            # of recursive panel fact.
1            RFACTs (0=left, 1=Crout, 2=Right)
1            # of broadcast
1            BCASTs (0=1rg,1=1rM,2=2rg,3=2rM,4=Lng,5=LnM)
1            # of lookahead depth
1            DEPTHs (>=0)
2            SWAP (0=bin-exch,1=long,2=mix)
64           swapping threshold
0            L1 in (0=transposed,1=no-transposed) form
0            U  in (0=transposed,1=no-transposed) form
1            Equilibration (0=no,1=yes)
8            memory alignment in double (> 0)
``` 

The exact way to run the HPL benchmark depends on the MPI implementation and system details. An example command to run the benchmark with 4 compute nodes on TARA is 

``` bash
srun -N 4 -n 160 ./hpl
```

Other possible command is 

``` bash
mpirun -np 160 ./hpl
```

`mpirun` is the command that starts execution of an MPI code. Depending on the system, it might also be `mpiexec`, or something appropriate for your computer.

HPL will generate `HPL.out` at the end of its execution. This file contains the results of the HPL benchmark. An example `HPL.out` is shown below.

``` bash
================================================================================
HPLinpack 2.3  --  High-Performance Linpack benchmark  --   December 2, 2018
Written by A. Petitet and R. Clint Whaley,  Innovative Computing Laboratory, UTK
Modified by Piotr Luszczek, Innovative Computing Laboratory, UTK
Modified by Julien Langou, University of Colorado Denver
================================================================================

An explanation of the input/output parameters follows:
T/V    : Wall time / encoded variant.
N      : The order of the coefficient matrix A.
NB     : The partitioning blocking factor.
P      : The number of process rows.
Q      : The number of process columns.
Time   : Time in seconds to solve the linear system.
Gflops : Rate of execution for solving the linear system.

The following parameter values will be used:

N      :  100000 
NB     :     192 
PMAP   : Row-major process mapping
P      :       8 
Q      :      10 
PFACT  :   Right 
NBMIN  :       4 
NDIV   :       2 
RFACT  :   Crout 
BCAST  :  1ringM 
DEPTH  :       1 
SWAP   : Mix (threshold = 64)
L1     : transposed form
U      : transposed form
EQUIL  : yes
ALIGN  : 8 double precision words

--------------------------------------------------------------------------------

- The matrix A is randomly generated for each test.
- The following scaled residual check will be computed:
      ||Ax-b||_oo / ( eps * ( || x ||_oo * || A ||_oo + || b ||_oo ) * N )
- The relative machine precision (eps) is taken to be               2.220446e-16
- Computational tests pass if scaled residuals are less than                16.0

================================================================================
T/V                N    NB     P     Q               Time                 Gflops
--------------------------------------------------------------------------------
WR11C2R4      100000   192     8    10             194.35             3.4303e+03
HPL_pdgesv() start time Fri Jul 24 19:58:59 2020

HPL_pdgesv() end time   Fri Jul 24 20:02:13 2020

--------------------------------------------------------------------------------
||Ax-b||_oo/(eps*(||A||_oo*||x||_oo+||b||_oo)*N)=   9.03510675e-04 ...... PASSED
================================================================================

Finished      1 tests with the following results:
              1 tests completed and passed residual checks,
              0 tests completed and failed residual checks,
              0 tests skipped because of illegal input values.
--------------------------------------------------------------------------------

End of Tests.
================================================================================
```

## Performance Results

Performance result is reported in the `Gflops` column of `HPL.out` file. We only accept performance result from a complete run that passes residual check.

## Submission

HPL benchmark submission includes following files

* Benchmark configuration. (See. [Benchmark Configuration](#Benchmark-Configuration-Example) )
* HPL binary
* A document describing all optiomizations and code modification.
* HPL input file `HPL.dat`
* HPL-generated output file `HPL.out`

### Benchmark Configuration Example

Following is an example benchmark configuration for TARA compute node. 

| Items                                                    | Description                     |
|----------------------------------------------------------|---------------------------------|
| System Manufacturer                                      | Lenovo                          |
| System Model                                             | SR650                           |
| Operating System                                         | CentOS 7.6                      |
| Processor Type                                           | Intel Xeon Gold 6148            |
| Processor Speed                                          | 2.4GHz                          |
| Cores per chip                                           | 20                              |
| Processor per node                                       | 2                               |
| Memory per node                                          | 192GB                           |
| GPU                                                      | -                               |
| GPUs per node                                            | -                               |
| Interconnect                                             | Mellanox Infiniband EDR 100Gbps |
| Interconnect per node                                    | 1                               |
| Theoretical peak double-precision performance (per node) | 3.072 TFlops                    |
| Compiler                                                 | GCC 8.3.0                       |
| Compiler Flags                                           | -O3                             |
| MPI library                                              | OpenMPI 3.1.4                   |
| BLAS library                                             | OpenBLAS 0.3.7                  |
| FFT library                                              | -                               |
| Other softwares                                          | -                               |



