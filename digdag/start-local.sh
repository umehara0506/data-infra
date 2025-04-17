#!/bin/bash

# 既存のDigdagサーバーを終了
pkill -f "digdag server"

# サーバーの起動
digdag server --config ./config/server-local.properties --bind 0.0.0.0 --port 65434 &
SERVER_PID=$!

# 10秒待機してサーバーの起動を確認
sleep 10

# プロジェクトのプッシュとスケジュール登録
digdag push ss --project workflows/ss/. -e 127.0.0.1:65434

# secretsの設定
digdag secrets --project ss --set gcp.credential=@./secrets/service_account.json -e 127.0.0.1:65434
digdag secrets --project ss --set gcp.credential_path=/work/secrets/service_account.json -e 127.0.0.1:65434


echo "DigdagサーバーがPID ${SERVER_PID}で起動しました"
echo "UI: http://localhost:65434"

# Ctrl+Cで終了するまで待機
wait ${SERVER_PID}

