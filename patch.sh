#!/bin/bash
set -e
echo "[*] Áp dụng patch..."

# Ví dụ sửa lỗi execSync xuống dòng
sed -i 's/execSync('\''/execSync("sh -c '\''/g' src/system/sync/syncing.js
