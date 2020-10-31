#!/bin/bash
sudo rm task7.txt

for pid in $(ps -A -o pid --no-header); do
	if [[ -f /proc/$pid/io ]]; then
		read_bytes=$(grep read_bytes /proc/$pid/io | grep -E -o '[[:digiy:]]+')
		echo $pid $read_bytes >> temp
	fi
done

cat temp
echo "wait 1 minute"
sleep 60
echo "done"

while read line; do
	pid=$(echo $line | awk '{ print $1 }')
	previous_bytes=$(echo $line | awk '{ print $2 }')
	if [[ -f /proc/$pid/io ]]; then
		new_bytes=$(grep read_bytes /proc/$pid/io | grep -E -o '[[:digit:]]+')
		echo $pid " : " $(echo $new_bytes $previous_bytes | awk '{ print $1-$2 }') >> temp2
	fi
done < temp

sudo sort -n -k3 temp2 | tail -n3 > out7.txt
cat out7.txt

sudo rm temp
sudo rm temp2
