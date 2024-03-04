#!/bin/bash
if [ $# -lt 1 ]; then
	echo "Error: faltan parametros"  
	exit
fi

input=$1

echo 'ppsh' $input;
for i in 2 3 4 5 6 7 8  ;do ssh cac$i $input &  done

