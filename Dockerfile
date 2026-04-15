FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    kiwix-tools \
    ocrmypdf \
    imagemagick \
    python3 \
    python3-pip \
    && apt-get clean

# Install pdf2htmlEX from maintained fork
RUN wget https://github.com/pdf2htmlEX-plus/pdf2htmlEX-plus/releases/download/v0.1.0/pdf2htmlEX-plus-linux-x86_64.zip \
    && unzip pdf2htmlEX-plus-linux-x86_64.zip -d /usr/local/bin \
    && mv /usr/local/bin/pdf2htmlEX-plus /usr/local/bin/pdf2htmlEX \
    && chmod +x /usr/local/bin/pdf2htmlEX \
    && rm pdf2htmlEX-plus-linux-x86_64.zip

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
