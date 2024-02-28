#!/bin/bash
if [ $# -lt 1 ]; then
	echo "Error: faltan parametros"  
	exit
fi

input=$1

echo 'psh' $input;
for i in 2 3 4 5 6 7 8  ;do  echo "=======" ; echo cac$i;  echo "------" ; ssh cac$i $input  ; done

