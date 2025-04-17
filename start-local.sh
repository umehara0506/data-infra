#!/bin/bash

# 既存のDigdagサーバーを終了
pkill -f "digdag server"

# 環境変数の設定
export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/digdag/config/secrets/service_account.json"
# digdag secrets --param GOOGLE_APPLICATION_CREDENTIALS=$(pwd)/digdag/config/secrets/service_account.json

# サーバー起動
# digdag server --config digdag/config/server.properties &
# digdag server --config ./digdag/config/server.properties --bind 0.0.0.0 --port 65432 &
# digdag server --param GOOGLE_APPLICATION_CREDENTIALS=$(pwd)/digdag/config/secrets/service_account.json --config ./digdag/config/server.properties --bind 0.0.0.0 --port 65432 &
# digdag server --param GOOGLE_APPLICATION_CREDENTIALS=$(pwd)/digdag/secrets/service_account.json --config ./digdag/config/server.properties --bind 0.0.0.0 --port 65432 &

# digdag server --set google.credentials=$(cat your-service-account.json | base64) --config ./digdag/config/server.properties --bind 0.0.0.0 --port 65432 &
digdag server --config ./digdag/config/server.properties --bind 0.0.0.0 --port 65432 &
SERVER_PID=$!

# 10秒待機してサーバーの起動を確認
sleep 10

# プロジェクトのプッシュとスケジュール登録
digdag push ss --project digdag/workflows/ss/.

# secretsの設定
digdag secrets --project ss --set gcp.credential=@./digdag/secrets/service_account.json
digdag secrets --project ss --set gcp.credential_path=/Users/umehara-katsuya/myfile/study/programming/data-infra/digdag/secrets/service_account.json


echo "DigdagサーバーがPID ${SERVER_PID}で起動しました"
echo "UI: http://localhost:65432"

# Ctrl+Cで終了するまで待機
wait ${SERVER_PID}