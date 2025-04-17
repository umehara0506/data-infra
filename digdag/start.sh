#!/bin/bash

# 既存のDigdagサーバーを終了
pkill -f "digdag server"

# サーバーの起動
digdag server --config ./config/server.properties --bind 0.0.0.0 --port 65433 &
SERVER_PID=$!

# 10秒待機してサーバーの起動を確認
sleep 10

# プロジェクトのプッシュとスケジュール登録
digdag push ss --project workflows/ss/. -e 127.0.0.1:65433

# secretsの設定
digdag secrets --project ss --set gcp.credential=@./secrets/service_account.json -e 127.0.0.1:65433
digdag secrets --project ss --set gcp.credential_path=/work/secrets/service_account.json -e 127.0.0.1:65433


echo "DigdagサーバーがPID ${SERVER_PID}で起動しました"
echo "UI: http://localhost:65433"

# Ctrl+Cで終了するまで待機
wait ${SERVER_PID}

