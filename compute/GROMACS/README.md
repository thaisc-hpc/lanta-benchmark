# GROMACS Benchmark 

Benchmark version : 2020.3 (or newer in 2020.x series)  
Official document : http://manual.gromacs.org/documentation/

## Installation
Installation guide : http://manual.gromacs.org/documentation/current/install-guide/index.html  
Source code : http://manual.gromacs.org/documentation/2020.3/download.html

**Example**
```
# Dependencies
1) foss version 2019b
2) CMake version 3.15
3) Python version 3.7

# Download and install GROMACS
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
You may consider to change CMake options:  
-DCMAKE_INSTALL_PREFIX to install GROMACS in the different path  
-DGMX_SIMD to specity the level of SIMD support enabled.

## Input files
We use the test case-B (lignocellulose-rf) from UEABS benhmark (https://repository.prace-ri.eu/git/UEABS/ueabs/-/tree/master/).

## Running GROMACS
To exec GROMACS mdrun command, we specify the following details.
```
#SBATCH -N NODES
#SBATCH --ntasks-per-node=TASKSPERNODE
#SBATCH --cpus-per-task=THREADSPERTASK

srun $HOME/gromacs/2020.3/bin/gmx_mpi mdrun -s lignocellulose-rf.tpr -maxh 0.50 -resethway -noconfout -nsteps 10000 -g logile 
```
or
```
[mpirun execution] [path to GROMACS gmx_mpi] mdrun -s [input (.tpr)] [mdrun options]
```
### mdrun options
official document : http://manual.gromacs.org/documentation/current/onlinehelp/gmx-mdrun.html  
| options | description |
|:--      |:--|
|-s       | the input file (.tpr) (required)
|-g       | output log file (required in this benchmark)
|-maxh    | maximum wall itme to run job (job will terminate atfer 0.99\*this time (hours) 
|-nsteps  | number of running steps (equal or greater than 10,000 steps in this benchmark)
|-resethway | Reset timer counters at half steps. This make mdrun reports its performance based on the half of the simulation steps.
|-noconfout | instructs GROMACS not to write .xtc and .trr output file (coordinate and velocity) at the end of the simulation. 

You may want to manually tune balance between forces and PME calculation by using -dd and -npme options. And also, instead of using -resethway, you can use -resetstep [step] to reset timer counters at a given step. However, we required at least 5,000 steps for performance calulation.  

## Performance 
GROMACS mdrun reports its performance in nanoseconds per day (ns/day). This is printed out on the screen at the end of the simulation or listed at the end of log file.
