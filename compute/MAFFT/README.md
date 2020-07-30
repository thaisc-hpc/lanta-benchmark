# MAFFT Benchmark

Version : 7.471  
Website : https://mafft.cbrc.jp/alignment/software/  

## Installation

The official guide : https://mafft.cbrc.jp/alignment/software/source.html

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
```

You may consider to change the CC and CFLAGS in the Makefile(s).

## Input

The input of MAFFT is a nucleotide or protein sequences in FASTA format (usually .fasta or .fa). We use 1,000 random nucleotide sequences (each sequence has 3,000 nucleotides). The input file can be found in the INPUT folder.  
The sequnce was genereated using https://www.bioinformatics.org/sms2/random_dna.html.

## Running

You can follow the information in https://mafft.cbrc.jp/alignment/software/manual/manual.html  

For this benchmark, the running option is fixed. The MAFFT have to run with --globalpair which specifies Needleman-Wunsch algorithm. Apart from --thread, --threadtb, and --threadit, the others options are **NOT** allowed to be changed.  
The information about MAFFT multithreads is available at https://mafft.cbrc.jp/alignment/software/multithreading.html .

**Example (SLURM)**
```
#!/bin/bash
#SBATCH -p PARTITION                    # specific partition
#SBATCH -N 1                            # specific number of nodes required
#SBATCH --cpus-per-task=40 --ntasks-per-node=1    # specific number of cores and task per node

# run the command
time $HOME/mafft7.4-foss/bin/mafft  --globalpair --thread 40 --threadtb 20 --threadit 20 INPUT.fa > OUTPUT.out

```
Note that we add `time` to measure MAFFT performance.  

## Performance 
MAFFT itself does not report a performance. We use either `time` or the information from SLURM to get the performance. Alternatively, you can use 
`run_and_get_performace_MAFFT.sh` to obtain performance results. The script will generate `benchmark_result.txt` containing performance result. An example benchmark_result.txt is shown below

``` bash
Benchmark performance =    65.455 jobs/day 
```
