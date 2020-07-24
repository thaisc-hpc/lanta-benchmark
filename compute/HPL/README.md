# HPL Benchmark

**Website**: https://www.netlib.org/benchmark/hpl/  
**Recommended Version**: 2.3  

## Benchmark Rules

HPL rule is based on a modified version of [HPCC baseline runs](https://icl.utk.edu/hpcc/overview/index.html) and [top500](https://www.top500.org/submit/). The rule is as follows

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
  * Calls to library subroutines should have the same syntax and semantics as in the released benchmark code. Code modifications to accommodate various library call formats are not allowed.

* Code Modification
  * Code modification to HPL source code are allowed as long as the modification is complied with [top500 rules](https://www.top500.org/submit/).

## Software Tools

Any tools used to build and run the benchmark (including pre-processors, compilers, static and dynamic linkers, operating systems) must be generally available. 

**These tools must be available to and usable by ThaiSC and its users without any restrictions when the system is deployed.**

## Input File

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

An input file for HPCC is `HPL.dat` in the top directory. A sample input file used for our reference run is as follows

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

The explanation of each configuration from README.txt is as follows

``` bash
   - Line 1: ignored 
   - Line 2: ignored 
   - Line 3: ignored 
   - Line 4: ignored 
   - Line 5: number of matrix sizes for HPL (and PTRANS) 
   - Line 6: matrix sizes for HPL (and PTRANS) 
   - Line 7: number of blocking factors for HPL (and PTRANS) 
   - Line 8: blocking factors for HPL (and PTRANS) 
   - Line 9: type of process ordering for HPL 
   - Line 10: number of process grids for HPL (and PTRANS) 
   - Line 11: numbers of process rows of each process grid for HPL (and
   PTRANS) 
   - Line 12: numbers of process columns of each process grid for HPL
   (and PTRANS) 
   - Line 13: threshold value not to be exceeded by scaled residual for
   HPL (and PTRANS) 
   - Line 14: number of panel factorization methods for HPL 
   - Line 15: panel factorization methods for HPL 
   - Line 16: number of recursive stopping criteria for HPL 
   - Line 17: recursive stopping criteria for HPL 
   - Line 18: number of recursion panel counts for HPL 
   - Line 19: recursion panel counts for HPL 
   - Line 20: number of recursive panel factorization methods for HPL 
   - Line 21: recursive panel factorization methods for HPL 
   - Line 22: number of broadcast methods for HPL 
   - Line 23: broadcast methods for HPL 
   - Line 24: number of look-ahead depths for HPL 
   - Line 25: look-ahead depths for HPL 
   - Line 26: swap methods for HPL 
   - Line 27: swapping threshold for HPL 
   - Line 28: form of L1 for HPL 
   - Line 29: form of U for HPL 
   - Line 30: value that specifies whether equilibration should be used
   by HPL 
   - Line 31: memory alignment for HPL 
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

HPL will generate `HPL.out` at the end of its execution. This file contains the results of the HPL benchmark.

## Submission

HPL benchmark submission includes following files

* Benchmark configuration
* A document describing all optiomizations and code modification.
* HPL input file `HPL.dat`
* HPL-generated output file `HPL.out`
