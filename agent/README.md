# README

## ポート開放
```sh
sudo firewall-cmd --zone=public --add-port=4567/tcp
```

## 本番起動
```sh
cd ~/manage-api/agent
APP_ENV=production bundle exec sidekiq -r ./app.rb -C ./sidekiq.yml
```