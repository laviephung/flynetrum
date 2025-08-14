#!/bin/bash
set -e

echo "[*] Khởi động NetRum Node..."
cd /app

# Nếu cần migrate / setup
if [ ! -d "$HOME/.config" ]; then
    mkdir -p $HOME/.config
fi

# Giữ container sống
exec bash
