#!/bin/bash

#����1��100������֮��

#����һ

echo "����һ";
for i in `seq 1 2 100`
do
        #echo $i
        sum=$[$sum+$i];
done
echo $sum

#������
sum2=0
echo "������";

for i in `seq 1 100` 
do 
	[ $[$i%2] -eq 1 ] && sum2=$[$sum2+$i]	
done
echo $sum2

#������
echo "������";
sum3=0
for i in `seq 100`
do 
	[ $[$i%2] -eq 0 ] && continue
	sum3=$[$sum3+$i]
done 
echo $sum3

