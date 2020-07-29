benchtime=`awk '/LOOP\+/{print $7}' OUTCAR`
throughput=`echo "86400 / $benchtime" | bc -l`
printf "Benchmark performance = %10.3f jobs/day \n" $throughput | tee benchmark_result.txt
