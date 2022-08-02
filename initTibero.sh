#!/bin/bash

export TB_HOME=/usr/local/tibero6
export TB_SID=tibero
export LD_LIBRARY_PATH=$TB_HOME/lib:$TB_HOME/client/lib
export PATH=$PATH:$TB_HOME/bin:$TB_HOME/client/bin

# apt archive update
apt-get update

# download pkgs
apt-get -y install libaio1 libncurses5

# settings for tibero
/usr/local/tibero6/config/gen_tip.sh

# tibero boot with nomount mode
tbboot nomount

# create database and add DCL 
nohup tbsql sys/tibero @InitDatabase

tbboot

#$TB_HOME/scripts/system.sh < ./input
$TB_HOME/scripts/system.sh -p1 tibero -p2 syscat -a1 y -a2 y -a3 y -a4 y

nohup tbsql sys/tibero @InitAccount

# settings for pvc
cp -r /usr/local/tibero6/database/tibero/* /usr/local/src/.
