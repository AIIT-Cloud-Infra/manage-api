#!/bin/bash

# 引数確認
if [[ $# -ne 1 ]]; then
  echo "require 1 args" 1>&2
  exit 1
fi

MAC_ADDRESS=$1

# IP_ADDRESSの取得
IP_ADDRESS=""
while [[ -z "$IP_ADDRESS" ]]; do
  sleep 5s
  IP_ADDRESS=arp -n | grep "${MAC_ADDRESS}" | awk '{print $1}'
done

echo "${IP_ADDRESS}"
