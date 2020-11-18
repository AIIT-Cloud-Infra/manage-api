#!/bin/bash

# 引数確認
if [[ $# -ne 3 ]]; then
  echo "require 3 args" 1>&2
  exit 1
fi

ID=$1
MEMORY=$2
CPU=$3

# パス定義
VM_DIR=/home/hmori/vm/${ID}
XML_PATH=${VM_DIR}/kvm_centos7.xml
IMG_PATH=/var/lib/libvirt/images/${ID}.qcow2
# ディレクトリ作成
mkdir -p "${VM_DIR}"
# ベースファイルの複製
sudo virt-clone \
  --connect qemu:///system \
  --original kvm_centos7 \
  --name ${ID} \
  --file ${IMG_PATH}
sudo virsh dumpxml ${ID} > ${XML_PATH}

# メモリ変更
sudo virsh setmaxmem "${ID}" "${MEMORY}MB" --config
sudo virsh setmem "${ID}" "${MEMORY}MB" --config
# CPU変更
sudo virsh setvcpus "${ID}" "${CPU}" --config --maximum
# VMの起動
sudo virsh start "${ID}"
# MACアドレスの取得
sudo virsh domiflist "${ID}" | grep ':' | awk '{print $5}'
