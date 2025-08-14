FROM debian:12

# Cài các gói cần thiết + Node.js 20 + tini
RUN apt-get update && \
    apt-get install -y curl ca-certificates git bash jq bc speedtest-cli \
                       cron tini && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs build-essential && \
    rm -rf /var/lib/apt/lists/*

# Thư mục làm việc
WORKDIR /app

# Clone source NetRum
RUN git clone https://github.com/NetrumLabs/netrum-lite-node.git . \
    && npm install \
    && npm link

# Tạo thư mục data & logs
RUN mkdir -p /data /logs
ENV HOME=/data
VOLUME ["/data"]

# Copy script patch & entrypoint
COPY patch.sh /patch.sh
COPY entrypoint.sh /entrypoint.sh

# Cấp quyền chạy & patch code
RUN chmod +x /patch.sh /entrypoint.sh && /patch.sh

# tini để quản lý process
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/entrypoint.sh"]
