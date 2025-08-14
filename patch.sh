#!/bin/bash
echo "[*] Đang patch code NetRum..."
find /app/src -type f -name "*.js" -exec sed -i 's/sudo //g' {} +
find /app/src -type f -name "*.js" -exec sed -i 's/systemctl.*//g' {} +
echo "[*] Patch hoàn tất."
