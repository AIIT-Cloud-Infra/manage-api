#!/bin/bash

# 引数確認
if [[ $# -ne 1 ]]; then
  echo "require 1 args" 1>&2
  exit 1
fi

ID=$1

# 強制終了
sudo virsh destroy "${ID}"
# 定義削除
sudo virsh undefine "${ID}"

# リソースパス
IMG_PATH=/var/lib/libvirt/images/${ID}.qcow2
# リソース削除
sudo rm -f "${IMG_PATH}"
