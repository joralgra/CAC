#!/bin/bash

for i in 1 2 3 4 5 6 
do
	{ printf "$USER\n$PASS\n1\n$i\n1\nyes\n\n\e\e4"; sleep 2;}|telnet $PDU
done