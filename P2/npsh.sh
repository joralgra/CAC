#!/bin/bash



while  [ $# -ge 1 ]
do
	case $1 in 
		-m) NUM=1 ;;
		-a) ALL=1 ;;
		-f) FROM=$2 ; shift ;;
		-t) TO=$2 ; shift ;;
		*) break ;;
	esac
	shift
done

orden=${@: -1}

    if [ "$ALL"  ]; then
	for i in 2 3 4 5 6 7 8  ;do  echo "=======" ; echo cac$i;  echo "------" ; ssh cac$i $orden  ; done
    elif [ "$NUM" ]; then
	 $orden
    elif [ "$FROM" ] && [ "$TO" ]; then
       for ((i = FROM; i <= TO; i++)); do
			  echo "=======" ; echo cac$i;  echo "------" ; ssh cac$i $orden
		done
    else
      exit 1
    fi