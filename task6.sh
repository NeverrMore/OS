#!/bin/bash

max=0
result=""

for pid in $(ps -A -o pid --no-header); do

if [[ -f /proc/$pid/status ]]; then
	current=$( grep -i VMSIZE /proc/$pid/status | grep -E -o '[[:digit:]]+' )
	if [[ $current -gt $max ]]; then
		max=$current
		result=$pid
	fi
fi
done

echo $result $pid


