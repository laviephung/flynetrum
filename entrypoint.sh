#!/bin/bash
set -e

echo "[*] Khởi động NetRum Node..."

# Đồng bộ dữ liệu (nếu cần)
if [ ! -f "$HOME/.netrum/config.json" ]; then
    echo "[*] Chưa có config, tạo mới..."
    netrum-init || true
fi

# Chạy tiến trình NetRum Node
netrum-sync &

# Giữ container sống
tail -f /dev/null
