#1/bin/bash

ps a x | grep /sbin/ | awk '{print $1}' > out2.txt

cat out2.txt

