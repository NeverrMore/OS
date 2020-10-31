#!/bin/bash
rm outTask5.txt

prevPPid="0"
curNum="0"
curSumSleepAVG="0"

while read newLine; do
    tempPPid=$(echo $newLine | awk -F '=' '{ print $3 }' | awk '{ print $1 }')
    if [[ $N -eq $tempPPid ]]; then
      tempSleepAVG=$(echo $newLine | awk -F '=' '{ print $4 }')
      if [ $prevPPid == $tempPPid ]; then
          let curNum=curNum+1
          curSumSleepAVG=$(echo "scale=10; $curSumSleepAVG+$tempSleepAVG" | bc)
      else
          if [ "$curNum" -ne  0 ]; then
            resultAvarageSleepAVG=$(echo "scale=10; $curSumSleepAVG/$curNum" | bc)
          fi
          printf "Average_Sleeping_Children_of_ParentID=$tempPPid is $resultAvarageSleepAVG\n" >> outTask5
          prevPPid=$tempPPid
          curNum="1"
          curSumSleepAVG=$tempSleepAVG
      fi
    fi  
    echo $newLine >> $outTask5.txt

done < outTask4.sh

resultAvarageSleepAVG=$(echo "scale=10; $curSumSleepAVG/$curNum" | bc)
printf "Average_Sleeping_Children_of_ParentID=$tempPPid is $resultAvarageSleepAVG\n" >> outTask5.txt
