nsperday=`grep ns/day -A 1 logile.log | grep Performance: | awk '{print $2}'`
printf "Benchmark performance = %10.3f ns/day \n" $nsperday | tee GROMACS_benchmark_result.txt
