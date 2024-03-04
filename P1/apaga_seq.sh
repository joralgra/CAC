#!/bin/bash

for i in 2 3 4 5 6 7 8 9
do
	{ printf "$USER\n$PASS\n1\n$i\n2\nyes\n\n\e\e4" ; sleep 2; }|telnet $PDU
done