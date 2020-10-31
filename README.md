# manage-api

## Dockerコンテナの作成
### コンテナイメージの作成
```sh
$ docker build -t manage-api .
```

### コンテナの作成
```sh
$ docker run -itd -v $(pwd):/src -p 4567:4567 --name manage-api manage-api
```

### コンテナの中に入る
```sh
$ docker exec -it manage-api sh
```

