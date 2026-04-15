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

# Install pdf2htmlEX from Kiwix-maintained static build
RUN wget https://download.kiwix.org/bin/pdf2htmlEX/pdf2htmlEX-0.18.8-22.04-x86_64.zip \
    && unzip pdf2htmlEX-0.18.8-22.04-x86_64.zip -d /usr/local/bin \
    && chmod +x /usr/local/bin/pdf2htmlEX \
    && rm pdf2htmlEX-0.18.8-22.04-x86_64.zip

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
