#!/bin/bash

export TB_HOME=/usr/local/tibero6
export TB_SID=tibero
export LD_LIBRARY_PATH=$TB_HOME/lib:$TB_HOME/client/lib
export PATH=$PATH:$TB_HOME/bin:$TB_HOME/client/bin

FILE=/usr/local/tibero6/database/tibero/c1.ctl

if [ ! -f "$FILE" ]; then
 cp -r /usr/local/src/* /usr/local/tibero6/database/tibero
fi

tbdown clean
tbboot

while :; do echo ''.''; sleep 5 ; done
