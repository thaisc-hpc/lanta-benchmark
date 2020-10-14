#!/bin/bash -l
#SBATCH -p gpu     			#specific partition
#SBATCH -N 2 --ntasks-per-node=2   	#specific number of nodes and task per node
#SBATCH -t 5:00:00      		#job time limit <hr:min:sec>
#SBATCH -J vasp_bench			#job name
ulimit  -s unlimited

##Module Load##
module load OpenMPI/3.1.4-PGI-19.10-GCC-8.3.0-2.3
module load CUDA
module load nvhpc/20.7
module load NCCL

module load VASP-GPU   			#load VASP module

WORKDIR=$SLURM_SUBMIT_DIR

##Start time##
START=`date`
starttime=$(date +%s)

##Run VASP###
srun vasp_std_openacc 

##Job Report##
echo "####################JobID Report####################"
echo "Job start at" $START
echo "Job directory is" $WORKDIR
END=`date`
endtime=$(date +%s)
echo "Job end   at" $END
DIFF=$(( $endtime - $starttime ))
convertsecs() {
 ((h=${1}/3600))
 ((m=(${1}%3600)/60))
 ((s=${1}%60))
 printf "%02d:%02d:%02d\n" $h $m $s
}
echo "The calculation time is $(convertsecs $DIFF) [$DIFF:s]"

