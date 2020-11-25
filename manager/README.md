# README

## ポート開放
```sh
sudo firewall-cmd --zone=public --add-port=3306/tcp
```

## 本番起動
```sh
./bin/rails s -d
```