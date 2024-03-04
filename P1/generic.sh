#!/bin/bash

while  [ $# -ge 1 ]
do
	case $1 in 
		-1) ACTION="Encender" ;;
		-2) ACTION="Apagar" ;;
		-a) ALL=1 ;;
		-n) NUM=$2 ; shift ;;
		-f) FROM=$2 ; shift ;;
		-t) TO=$2 ; shift ;;
		*) break ;;
	esac
	shift
done

# Lógica para manipular las salidas de la PDU según la acción y salida especificada
case $ACTION in
  "Encender")
    if [ "$ALL"  ]; then
      echo "Encendiendo todas las salidas"
      { printf "$USER\n$PASS\n1\n9\n1\nyes\n\n\e\e4"; sleep 2;}|telnet $PDU
    elif [ "$NUM" ]; then
      echo "Encendiendo salida $NUM"
      { printf "$USER\n$PASS\n1\n$NUM\n1\nyes\n\n\e\e4"; sleep 2;}|telnet $PDU
    elif [ "$FROM" ] && [ "$TO" ]; then
      echo "Encendiendo desde la salida $FROM hasta la salida $TO"
       for ((i = FROM; i <= TO; i++)); do
            { printf "$USER\n$PASS\n1\n$i\n1\nyes\n\n\e\e4"; sleep 2;}|telnet $PDU
        done
    else
      echo "Falta el argumento requerido para la opción -n, -f o -t.$TO $FROM $NUM"
      exit 1
    fi
    ;;
  "Apagar")
    if [  $ALL ]; then
      echo "Apagando todas las salidas"
      { printf "$USER\n$PASS\n1\n9\n2\nyes\n\n\e\e4"; sleep 2;}|telnet $PDU
    elif [ "$NUM" ]; then
      echo "Apagando salida $NUM"
      { printf "$USER\n$PASS\n1\n$NUM\n2\nyes\n\n\e\e4"; sleep 2;}|telnet $PDU
    elif [ "$FROM" ] && [ "$TO" ]; then
      echo "Apagando desde la salida $FROM hasta la salida $TO"
       for ((i = FROM; i <= TO; i++)); do
            { printf "$USER\n$PASS\n1\n$i\n2\nyes\n\n\e\e4"; sleep 2;}|telnet $PDU
        done
    else
      echo "Falta el argumento requerido para la opción -n, -f o -t. "
      exit 1
    fi
    ;;
  *)
    echo "Acción no válida: $ACTION $NUM dfggfgdf"
    exit 1
    ;;
esac

echo "Operación completada."
