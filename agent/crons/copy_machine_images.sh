#!/bin/bash

# パス
IMG_DIR=/var/lib/libvirt/images/
DIF_DIR=/home/hmori/base_imgs/
# イメージのコピー
sudo rsync -avxu img-master::base_img/*.qcow2 "${IMG_DIR}" >> /var/log/rsync.log 2>&1
# 定義のコピー
sudo rsync -avxu img-master::base_img/*.xml "${DIF_DIR}" >> /var/log/rsync.log 2>&1

# クローンできるようにVMの登録
xml_list=($(ls ${DIF_DIR}*.xml))
for path in ${xml_list[@]}; do
  sudo virsh define ${path}
done
