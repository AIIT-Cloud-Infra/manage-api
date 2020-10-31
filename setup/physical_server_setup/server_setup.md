# Server Setup

- OSインストール手順
- ネットワーク設定
- ソフトウェアのインストール

## OSインストール手順

1. インストールメディア(CentOS7)が入ったUSBをサーバに挿入する
2. サーバの電源を入れて「F12」でBIOSを起動する
3. 「F11」のBoot Managerを選択する
4. One Time Boot > USB を選択する
5. 「Test this media & install CentOS 7」を選択する
6. 言語:日本語, 標準時:Asia/Tokyo, インストール先:パーティションの作成・全削除・再利用
7. 「インストールの開始」を選択する
8. rootユーザのパスワード設定する
9. 通常ユーザのパスワード設定する

## ユーザーをsudoersに加える

1. sudoersファイルに追記する
```sh
$ visudo
> <ユーザ名> ALL=(ALL) NOPASSWD: ALL
```

## ネットワーク設定

1. 初期状態を確認する
```sh
$ ip a
$ nmcli dev
```

2. 固定IPを設定する
```sh
$ nmtui #あるいは nmcli
> IPv4 CONFIGUARATION: Manual
> Addresses: 192.168.0.1X/24
> Gateway: 192.168.0.1/24
> DNS Servers: 8.8.8.8, 8.8.4.4
```

3. ホスト名を設定する
```sh
$ nmcli general hostname ra050x # xは連番, 01をmanagerに設定する
```

<!-- 4. 管理用ネットワークブリッジの作成
```sh
$ sudo brctl addbr br1
$ sudo ip addr add 10.0.0.x/24 dev br1 # xは連番, 01をmanagerに設定する
$ sudo ip link set br1 up
$ sudo brctl addif br1 eth1
$ sudo nmcli connection add type bridge ifname br1
``` -->

5. VM用ネットワークブリッジの作成
```sh
$ sudo yum install -y bridge-utils
$ sudo brctl addbr br0
$ sudo ip link set br0 up
$ sudo brctl addif br0 eth0
$ sudo nmcli connection add type bridge ifname br0
```

0. KVMにネットワークを追加
```sh
$ virsh list
$ virsh domiflist kvm_centos7
$ virsh attach-interface --persistent --type bridge --source br0 --model virtio kvm_centos7
$ virsh detach-interface --type bridge --domain kvm_centos7 --mac <mac> # 削除
```

0. VMのIP範囲を変更
```sh
$ virsh net-edit default # '192.168.122.xx' (10~89, 90~169, 170~249)
$ virsh net-destroy default
$ virsh net-start default
```