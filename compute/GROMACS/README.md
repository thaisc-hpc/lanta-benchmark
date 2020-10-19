# GROMACS Benchmark 

Benchmark version : 2020.3  
Official document : http://manual.gromacs.org/documentation/

## Benchmark rules

* GROMACS version 2020.3 **only**
* No code modification is allowed

## Installation

Officail installation guide : http://manual.gromacs.org/documentation/current/install-guide/index.html  
Source code : http://manual.gromacs.org/documentation/2020.3/download.html

### Example

#### Download and Install GROMACS

``` bash
wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-2020.3.tar.gz
tar xfz gromacs-2020.3.tar.gz
cd gromacs-2020.3/
mkdir build
cd build

cmake \                                 
        -DCMAKE_INSTALL_PREFIX=$HOME/gromacs/2020.3 \
        -DBUILD_SHARED_LIBS=off \
        -DBUILD_TESTING=off \
        -DREGRESSIONTEST_DOWNLOAD=OFF \
        -DCMAKE_C_COMPILER=`which mpicc` \
        -DCMAKE_CXX_COMPILER=`which mpicxx` \
        -DGMX_BUILD_OWN_FFTW=on \
        -DGMX_SIMD=AVX_512 \
        -DGMX_DOUBLE=off \
        -DGMX_EXTERNAL_BLAS=off \
        -DGMX_EXTERNAL_LAPACK=off \
        -DGMX_FFT_LIBRARY=fftw3 \
        -DGMX_GPU=off \
        -DGMX_MPI=on \
        -DGMX_OPENMP=on \
        -DGMX_X11=off \
        ..
make -j 20
make install
```

It is compulsory to set the `-DGMX_DOUBLE` to `off`. The other options are allowed to be changed unless there is no effect on a scientific accuracy. For CMake advanced options, please check the official installation guide.  
**If using external libraries, all external libraries must be available to and usable by ThaiSC and its users without any restrictions when the system is deployed.**  

**It is important to make sure that the GROMACS version is checked and the verified release checksum is present.**

## Input files

We use the test case-B (lignocellulose-rf) from [UEABS benhmark](https://repository.prace-ri.eu/git/UEABS/ueabs/-/tree/master/). The input files can be downloaded [here](https://sharebox.nstda.or.th/d/d94385bd).  

## Running GROMACS

The test case is expected to perform on **4 compute nodes** (dual-socket CPU-only node).  

To execute GROMACS `mdrun` on 4 compute nodes with Slurm, following command can be used. 

``` bash
srun -N 4 --ntasks-per-node=1 --cpus-per-task=40 $HOME/gromacs/2020.3/bin/gmx_mpi mdrun -s lignocellulose-rf.tpr -maxh 0.50 -resethway -noconfout -nsteps 10000 -g logile 
```
or

``` bash
[mpirun execution] [path to GROMACS gmx_mpi] mdrun -s [input (.tpr)] [mdrun options]
```

### mdrun options

official document : http://manual.gromacs.org/documentation/current/onlinehelp/gmx-mdrun.html  

| options | description |
|:--      |:--|
|`-s`       | the input file (.tpr) (required)
|`-g`       | output log file (required in this benchmark)
|`-maxh`    | maximum wall itme to run job (job will terminate atfer 0.99\*this time (hours) 
|`-nsteps`  | number of running steps (equal or greater than 20,000 steps in this benchmark)
|`-resethway` | Reset timer counters at half steps. This make mdrun reports its performance based on the half of the simulation steps
|`-noconfout` | instructs GROMACS not to write .xtc and .trr output file (coordinate and velocity) at the end of the simulation 

You may consider to use the following options:
* `-dd` and `-npme` to manually tune balance between forces and PME calculation.  
* `-resetstep` to reset timer counters at a given step instead of using `-resethway`. However, **we required at least 10,000 steps for the performance calulation.**
* `-ntmpi` to specify number of thread-MPI ranks 
* `-ntomp` to specify Number of OpenMP threads per MPI rank

The adjustment of `-nstlist` that specifies frequency to update the neighbor list is allowed unless there is no loss of the accuracy.

## Performance 
GROMACS `mdrun` reports its performance in nanoseconds per day (ns/day). This is printed out on the screen at the end of the simulation or listed at the end of log file.
