#!/bin/bash
if [ $# -lt 1 ];
then
	echo "Error: faltan parametros"  
	exit
else
	{ printf "$USER\n$PASS\n1\n$1\n2\nyes\n\n\e\e4"; sleep 2;} | telnet $PDU
fi