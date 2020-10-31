#!/bin/bash

user="root"

ps -u root | wc -l | awk '{print $1}' > out1.txt
ps -u $user | awk '{print $1 ":" $4}' >> out1.txt

cat out1.txt

