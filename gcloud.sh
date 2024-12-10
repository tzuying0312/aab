#!/bin/bash

# 設置變數
SERVICE_ACCOUNT_JSON="path/to/service-account-key.json"  # 替換為服務帳戶金鑰路徑
PACKAGE_NAME="com.example.yourapp"                      # 替換為應用包名
AAB_FILE="path/to/app-release.aab"                      # 替換為 AAB 文件路徑

# 設置身份驗證
echo "Activating service account..."
gcloud auth activate-service-account --key-file="$SERVICE_ACCOUNT_JSON"

# 上傳 AAB 文件
echo "Uploading AAB file..."
UPLOAD_RESPONSE=$(gcloud beta android-publisher bundles upload \
    --package-name="$PACKAGE_NAME" \
    --bundle="$AAB_FILE")

if [ $? -eq 0 ]; then
    echo "AAB uploaded successfully:"
    echo "$UPLOAD_RESPONSE"
else
    echo "Failed to upload AAB file."
    exit 1
fi
