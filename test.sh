#!/bin/bash

# 設置環境變數
SERVICE_ACCOUNT_KEY="path/to/your-service-account.json"
PACKAGE_NAME="com.your.app"
AAB_FILE="path/to/your/app-release.aab"

# 使用 OAuth 2.0 授權，獲取 token
ACCESS_TOKEN=$(curl -s --request POST \
  --header "Content-Type: application/json" \
  --data @"$SERVICE_ACCOUNT_KEY" \
  "https://oauth2.googleapis.com/token" | jq -r .access_token)

# 創建一個上傳請求
UPLOAD_URL=$(curl -s --request POST \
  --header "Authorization: Bearer $ACCESS_TOKEN" \
  --header "Content-Type: application/json" \
  "https://androidpublisher.googleapis.com/upload/androidpublisher/v3/applications/$PACKAGE_NAME/edits" | jq -r .uploadUrl)

# 上傳 AAB 檔案
curl -X POST \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -F "file=@$AAB_FILE" \
  "$UPLOAD_URL"
