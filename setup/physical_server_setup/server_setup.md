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
$ nmcli general hostname r5ex # xは連番, 01をmanagerに設定する
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
$ sudo brctl addif br0 em2
$ sudo nmcli connection add type bridge ifname br0
```

## rsyncの設定
1. /etc/xinetd.d/rsync ファイルの作成
```
# default: off
# description: The rsync server is a good addition to an ftp server, as it \
#       allows crc checksumming etc.
service rsync
{
        disable         = no   # <= 変更
        flags           = IPv6
        socket_type     = stream
        wait            = no
        user            = root
        server          = /usr/bin/rsync
        server_args     = --daemon
        log_on_failure  += USERID
}
```
2. 同期先ディレクトリの作成
```sh
$ mkdir /home/hmori/base_imgs
```

3. /etc/rsyncd.conf ファイルの作成
```
[base_image]
path = /home/hmori/base_imgs
hosts allow = 192.168.0.12 192.168.0.13 192.168.0.14
hosts deny = *
list = true
uid = root
gid = root
read only = true
```

4. 再起動
```sh
$ systemctl restart xinetd && systemctl enable xinetd
```

