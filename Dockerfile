FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    libfontforge-dev \
    libspiro-dev \
    libpango1.0-dev \
    libcairo2-dev \
    libjpeg-dev \
    libpng-dev \
    libxml2-dev \
    libglib2.0-dev \
    libpoppler-dev \
    libpoppler-cpp-dev \
    libpoppler-private-dev \
    libboost-all-dev \
    python3 \
    python3-pip \
    ocrmypdf \
    imagemagick \
    kiwix-tools \
    && apt-get clean

# Build pdf2htmlEX from source
RUN git clone https://github.com/pdf2htmlEX/pdf2htmlEX.git /tmp/pdf2htmlEX \
    && cd /tmp/pdf2htmlEX \
    && cmake . \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/pdf2htmlEX

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
