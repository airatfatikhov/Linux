#! /bin/bash

HOST1="ip port"

nc -z $HOST1

if [[ $? -eq 0 ]]
 then
     echo 0 > /etc/scripts/logs/text.log
  exit 0
 else
     echo 1 > /etc/scripts/logs/text.log
  exit 1
 fi