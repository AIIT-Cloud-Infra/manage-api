#!/bin/bash

# 引数確認
if [[ $# -ne 1 ]]; then
  echo "require 1 args" 1>&2
  exit 1
fi

ID=$1
IP_ADDRESS=$2

# キーのパス
KEY_PATH="/tmp/${ID}"
# キー作成
ssh-keygen -f "${KEY_PATH}" -q -N ""
# publicキーのコピー（ユーザー名は guest 固定）
echo "guest" | sshpass ssh-copy-id -f -i "${KEY_PATH}.pub" "guest@${IP_ADDRESS}"

# privateキーの内容を変数化
PRIVAYE_KEY=$(cat "${KEY_PAHT}")
# キー削除
rm "${KEY_PATH}" "${KEY_PATH}.pub"

# 戻り値
echo "${PRIVAYE_KEY}"
