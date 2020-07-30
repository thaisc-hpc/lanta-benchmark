#!/bin/bash
starttime=$(date +%s)

mafft --globalpair --thread 40 --threadtb 20 --threadit 20 R3000x1000.fasta > aligned_R3000x1000.out

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
throughput=`echo "86400 / $DIFF" | bc -l`

printf "Benchmark performance = %10.3f jobs/day \n" $throughput | tee benchmark_result.txt
