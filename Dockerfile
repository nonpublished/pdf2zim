FROM debian:stable-slim

# Install dependencies for kiwix-tools build + your pipeline tools
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    libzim-dev \
    libmagic-dev \
    libxapian-dev \
    libcurl4-openssl-dev \
    libmicrohttpd-dev \
    libpugixml-dev \
    libzstd-dev \
    ocrmypdf \
    imagemagick \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Build kiwix-tools from source (includes zimwriterfs)
RUN git clone https://github.com/kiwix/kiwix-tools.git /tmp/kiwix-tools && \
    cd /tmp/kiwix-tools && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/kiwix-tools

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]




