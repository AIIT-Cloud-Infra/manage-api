# manage-api

## 開発環境のDockerコンテナ作成
```sh
$ docker-compose up -d
```

## DB初期化
```sh
$ docker exec -it manager-api sh
$ bundle install
$ rails db:create && rails db:migrate
```

## 管理APIの起動
```sh
$ docker exec -it manager-api sh
$ bundle install
$ rails s -b '0.0.0.0'
```

## エージェントAPIの起動
```sh
$ docker exec -it agent-api sh
$ bundle install
$ ruby app.rb
```
