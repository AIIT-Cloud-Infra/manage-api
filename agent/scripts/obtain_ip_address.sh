#!/bin/bash

# 引数確認
if [[ $# -ne 1 ]]; then
  echo "require 1 args" 1>&2
  exit 1
fi

MAC_ADDRESS=$1

# IP_ADDRESSの取得
IP_ADDRESS=""
count=1
while [[ -z "$IP_ADDRESS" ]]; do
  sleep 5s
  IP_ADDRESS=`ip neigh | grep "${MAC_ADDRESS}" | awk '{print $1}'`
  if [[ $count == 10 ]]; then
    echo ok
  fi
  count=$((count++))
done

echo "${IP_ADDRESS}"
