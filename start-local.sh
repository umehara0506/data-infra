#!/bin/bash

# 環境変数の設定
export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/digdag/config/secrets/service_account.json"

# サーバー起動
digdag server --config digdag/config/server.properties &
SERVER_PID=$!

# 10秒待機してサーバーの起動を確認
sleep 10

# プロジェクトのプッシュとスケジュール登録
digdag push ss --project digdag/workflows/ss/.


echo "DigdagサーバーがPID ${SERVER_PID}で起動しました"
echo "UI: http://localhost:65432"

# Ctrl+Cで終了するまで待機
wait ${SERVER_PID}