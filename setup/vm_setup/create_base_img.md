# VMイメージ作成

- isoイメージのダウンロード
```sh
$ cd
$ wget http://ftp.nara.wide.ad.jp/pub/Linux/centos/7.8.2003/isos/x86_64/CentOS-7-x86_64-Minimal-2003.iso
```

- イメージ作成
```sh
$ virt-install \
    --name=kvm_centos7 \
    --vcpus=1 \
    --ram=1024 \
    --location=/tmp/CentOS-7-x86_64-Minimal-2003.iso \
    --disk path=/var/lib/libvirt/images/centos.qcow2,format=qcow2,size=8 \
    --network bridge=br0 \
    --arch=x86_64 \
    --os-type=linux \
    --os-variant=rhel7 \
    --nographics \
    --initrd-inject /tmp/centos7.ks.cfg \
    --extra-args "inst.ks=file:/centos7.ks.cfg console=tty0 console=ttyS0,115200n8"
```

