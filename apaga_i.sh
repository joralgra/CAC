#!/bin/bash

if [ $# -lt 2 ]; then
	echo "Error: faltan parametros"  
	exit
fi

i=$2
{printf "$USER\n$PASS\n1\n$i\n1\nyes\n\n\e\e4"; sleep 2;}|telnet $PDU 
