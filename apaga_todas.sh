PDU=pdu1-labs.disca.upv.es
USER=practica
PASS=cos
for i in 1 2 3 4 5 6 
do
	{printf "$USER\n$PASS\n1\n$i\n2\nyes\n\n\e\e4"; sleep 2;}|telnet $PDU
done