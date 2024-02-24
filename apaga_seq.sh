#!/bin/bash

if [ $# -lt 2 ]; then
	echo "Error: faltan parametros"  
	exit
fi

i="$2"
{ printf "$USER\n$PASS\n1\n$i\n2\nyes\n\n\e\e4" ; sleep 5; }|telnet $PDU
