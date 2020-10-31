#!/bin/bash
result=""
for pid in $(ps -A -o pid --no-header); do

if [[ -f /proc/$pid/status ]]; then
	ppid=$(grep "^PPid" /proc/$pid/status | grep -E -o '[[:digit:]]+')
	sumExecRuntime=$(grep  "sum_exec_runtime" "/proc/$pid/sched" | awk '{print $3}')
	nrSwitcher=$(grep "nr_switches" "/proc/$pid/sched" | awk '{print $3}')
	if [[ -n $ppid ]]; then
		art=0
		if [ "$nrSwitcher" -ne 0 ]; then 
           		art=$(echo "scale=4; $sumExecRuntime/$nrSwitcher" | bc)
			fi
	echo "PricessID= $pid : Parent_ProcessID= $ppid : Average_Running_Time= $art"
	fi
fi
done | sort --key=2 -V > out4.txt
cat out4.txt

