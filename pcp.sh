#!/bin/bash
if [ $# -lt 2 ]; then
	echo "Error: faltan parametros"  
	exit
fi

input=$1
output=$2

echo 'pcp' $input;
for i in 2 3 4 5 6 7 8  ;do scp cac$i:$input %output & done

