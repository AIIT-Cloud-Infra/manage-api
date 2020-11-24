# README

## cron設定
```sh
sudo crontab -e
=> */10 * * * * bash /home/hmori/manage-api/agent/crons/copy_machine_images.sh
```

## 本番起動
```sh
cd ~/manage-api/agent
APP_ENV=production ruby app.rb　&
```