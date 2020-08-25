#!/bin/bash
echo -e "File\tSize\tOwner"
totalSize=0
ls -l | egrep -s '^-' | tr -s " " |  
{
while read -r c1 c2 c3 c4 c5 c6 c7 c8 c9
do
  echo $c9 $c5 $c3
  totalSize=`echo "$c5 + $totalSize" | bc`
done 
	echo "total size = $totalSize"
	echo " - DONE -"
}
