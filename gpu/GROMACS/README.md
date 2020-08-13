# GROMACS GPU Benchmark 

Benchmark version : 2020.3  
Official document : http://manual.gromacs.org/documentation/

In this GPU benchmark, we will consider GROMACS performance in 2 different situations. 
1. Mixing CPUs and GPUs (traditional run) 
2. GPU Optimization 

## Benchmark rules

* GROMACS version 2020.3 **only**
* No code modification is allowed

## Installation

Installation guide : http://manual.gromacs.org/documentation/current/install-guide/index.html  
Source code : http://manual.gromacs.org/documentation/2020.3/download.html

### Example

#### Download and Install GROMACS

1. Mixing CPUs and GPUs (traditional case)

``` bash
wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-2020.3.tar.gz
tar xfz gromacs-2020.3.tar.gz
cd gromacs-2020.3/
mkdir build
cd build

cmake \                                 
        -DCMAKE_INSTALL_PREFIX=$HOME/gromacs/2020.3-MPI \
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
        -DGMX_GPU=on \
        -DGMX_MPI=on \
        -DGMX_OPENMP=on \
        -DGMX_X11=off \
        ..
make -j 20
make install
```

2. GPU Optimization

``` bash
wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-2020.3.tar.gz
tar xfz gromacs-2020.3.tar.gz
cd gromacs-2020.3/
mkdir build
cd build

cmake \
        -DCMAKE_INSTALL_PREFIX=$HOME/gromacs/2020.3-GPU \
        -DBUILD_SHARED_LIBS=off \
        -DBUILD_TESTING=off \
        -DREGRESSIONTEST_DOWNLOAD=OFF \
        -DCMAKE_C_COMPILER=`which gcc` \
        -DCMAKE_CXX_COMPILER=`which g++` \
        -DGMX_BUILD_OWN_FFTW=on \
        -DGMX_SIMD=AVX_512 \
        -DGMX_DOUBLE=off \
        -DGMX_EXTERNAL_BLAS=off \
        -DGMX_EXTERNAL_LAPACK=off \
        -DGMX_FFT_LIBRARY=fftw3 \
        -DGMX_GPU=on \
        -DGMX_THREAD_MPI=on \
        -DGMX_OPENMP=on \
        -DGMX_X11=off \
        ..
make -j 20
make install
```

For both cases, it is compulsory to set the `-DGMX_DOUBLE` to `off`.  
**If using external libraries, all external libraries must be available to and usable by ThaiSC and its users without any restrictions when the system is deployed.**  
You may consider to change CMake options:  
-DCMAKE_INSTALL_PREFIX to install GROMACS in the different path  
-DGMX_SIMD to specity the level of SIMD support enabled.

## Input files

In the traditional case, we use the Satellite tobacco mosaic virus (STMV) system and the test case-B (lignocellulose-rf) from [UEABS benhmark](https://repository.prace-ri.eu/git/UEABS/ueabs/-/tree/master/).   

In the GPU Optimization case, we only use the Satellite tobacco mosaic virus (STMV) system.  

The input files can be downloaded here [lignocellulose-rf](https://sharebox.nstda.or.th/d/d94385bd) and [stmv](https://sharebox.nstda.or.th/d/b16a7e96).  

## Running GROMACS

1. The traditional test case is expected to perform on **4 gpu nodes**.  

To execute GROMACS `mdrun` on 4 gpu nodes with 4 GPUs per node using Slurm, the following command can be used. 

``` bash
srun -N 4 --ntasks-per-node=4 --cpus-per-task=10 $HOME/gromacs/2020.3-MPI/bin/gmx_mpi mdrun -s lignocellulose-rf.tpr -maxh 0.50 -resethway -noconfout -nsteps 10000 -g logile -ntomp 10
```
or

``` bash
[mpirun execution] [path to GROMACS gmx_mpi] mdrun -s [input (.tpr)] [mdrun options]
```

2. The GPU Optimization test case is expected to perform on a **1 gpu node**.  

To enable all gpu implementations, we execute GROMACS `mdrun` using the following set of commands.

```bash

export GMX_GPU_DD_COMMS=true
export GMX_GPU_PME_PP_COMMS=true
export GMX_FORCE_UPDATE_DEFAULT_GPU=true

$HOME/gromacs/2020.3-GPU/bin/gmx mdrun -s stmv.tpr -maxh 0.50 -resethway -noconfout -nsteps 10000 -g logile -nb gpu -bonded gpu -pme gpu -ntmpi 4 -ntomp 10 -npme 1 -nstlist 80 

```

see [NVIDIA Developer Blog](https://developer.nvidia.com/blog/creating-faster-molecular-dynamics-simulations-with-gromacs-2020/) for the explanation.

### mdrun options

official document : http://manual.gromacs.org/documentation/current/onlinehelp/gmx-mdrun.html  

| options | description |
|:--      |:--|
|`-s`       | the input file (.tpr) (required)
|`-g`       | output log file (required in this benchmark)
|`-maxh`    | maximum wall itme to run job (job will terminate atfer 0.99\*this time (hours) 
|`-nsteps`  | number of running steps (equal or greater than 10,000 steps in this benchmark)
|`-resethway` | Reset timer counters at half steps. This make mdrun reports its performance based on the half of the simulation steps
|`-noconfout` | instructs GROMACS not to write .xtc and .trr output file (coordinate and velocity) at the end of the simulation 

You may consider to use the following options:
* `-dd` and `-npme` to manually tune balance between forces and PME calculation. , you can use 
* `-resetstep` to reset timer counters at a given step, instead of using `-resethway`. However, we required at least 5,000 steps for the performance calulation.
* `-ntmpi` to specify number of thread-MPI ranks 
* `-ntomp` to specify Number of OpenMP threads per MPI rank

The adjustment of `-nstlist` that specifies frequency to update the neighbor list is allowed unless there is no loss of the accuracy.


https://developer.nvidia.com/blog/creating-faster-molecular-dynamics-simulations-with-gromacs-2020/
## Performance 
GROMACS `mdrun` reports its performance in nanoseconds per day (ns/day). This is printed out on the screen at the end of the simulation or listed at the end of log file.
