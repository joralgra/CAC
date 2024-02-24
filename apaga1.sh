#!/bin/bash

{ printf "$USER\n$PASS\n1\n2\n2\nyes\n\n\e\e4"; sleep 2;}|telnet $PDU