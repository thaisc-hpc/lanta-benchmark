# MAFFT Benchmark
Version : 7.471  
Website : https://mafft.cbrc.jp/alignment/software/  

## Installation
The official guide : https://mafft.cbrc.jp/alignment/software/source-mpi.html

**Example**
```
# Download and untar
wget https://mafft.cbrc.jp/alignment/software/mafft-7.471-with-extensions-src.tgz
tar xfvz mafft-7.471-with-extensions-src.tgz

# Compile
cd mafft-7.471-with-extensions/core/
vi Makefile (change from: PREFIX = /usr/local to: PREFIX = PATHTOINSTALL)
make clean
make
make install

cd ../MPI/
vi Makefile (change from: PREFIX = /usr/local to: PREFIX = PATHTOINSTALL)
make clean
make
make install
```
You may consider to change the CC and CFLAGS in the Makefile(s).

## Input
The input of MAFFT is a nucleotide or protein sequences in FASTA format (usually .fasta or .fa). We use 1,000 random nucleotide sequences (each sequence has 3,000 nucleotides). Th input file can be found in the INPUT folder.  
The sequnce was genereated using https://www.bioinformatics.org/sms2/random_dna.html.

## Running
You can follow the information in https://mafft.cbrc.jp/alignment/software/mpi.html

**Example (SLURM)**
```
#!/bin/bash
#SBATCH -p PARTITION                    # specific partition
#SBATCH -N 1                            # specific number of nodes required
#SBATCH -c 40 --ntasks-per-node=1       # specific number of cores and task per node

# set enviroment variable according to https://mafft.cbrc.jp/alignment/software/mpi.html
export MAFFT_TMPDIR=$SLURM_TMPDIR   # Set to $scratch if run > 1 nodes
export MAFFT_MPIRUN="srun"
export MAFFT_N_THREADS_PER_PROCESS="40"

# run the command
time $HOME/mafft7.4-foss/bin/mafft --mpi --large --globalpair --thread 40 INPUT.fa > OUTPUT.out

```
We add `time` to measure MAFFT performance.  
Note: MAFFT_TMPDIR is to set the temporary directory which must be shared by all hosts. 

## Performance 
MAFFT itself does not report a performance. We use either `time` or the information from SLURM to get the performance.
