#!/bin/bash

# 引数確認
if [[ $# -ne 2 ]]; then
  echo "require 2 args" 1>&2
  exit 1
fi

ID=$1
IP_ADDRESS=$2

# キーのパス
KEY_PATH="/tmp/${ID}"
# キー作成
ssh-keygen -f "${KEY_PATH}" -q -N "" > /dev/null
# publicキーのコピー（ユーザー名は guest 固定）
sshpass -p "guest" ssh-copy-id -f -i "${KEY_PATH}.pub" "guest@${IP_ADDRESS}" > /dev/null

# privateキーの内容を変数化
PRIVAYE_KEY=$(cat "${KEY_PATH}")
# キー削除
sudo rm "${KEY_PATH}" "${KEY_PATH}.pub"

# 戻り値
echo "${PRIVAYE_KEY}"
