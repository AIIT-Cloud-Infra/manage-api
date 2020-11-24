#!/bin/bash

# 引数確認
if [[ $# -ne 1 ]]; then
  echo "require 1 args" 1>&2
  exit 1
fi

ID=$1

sudo virsh shutdown "${ID}"
