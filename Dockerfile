FROM debian:12

# Cài Node.js 20 + các công cụ cần thiết
RUN apt-get update && \
    apt-get install -y curl ca-certificates git bash jq bc speedtest-cli cron tini && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs build-essential && \
    rm -rf /var/lib/apt/lists/*

# Tạo thư mục app
WORKDIR /app

# Clone source NetRum Lite Node
RUN git clone https://github.com/NetrumLabs/netrum-lite-node.git . \
    && npm install \
    && npm link

# Tạo thư mục dữ liệu ví & logs
RUN mkdir -p /data /logs
ENV HOME=/data
VOLUME ["/data"]

# Copy patch script nếu có
COPY patch.sh /patch.sh
RUN chmod +x /patch.sh && /patch.sh || true

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# tini để quản lý process
ENTRYPOINT ["/usr/bin/tini", "--"]

# Chạy script entrypoint
CMD ["/entrypoint.sh"]

