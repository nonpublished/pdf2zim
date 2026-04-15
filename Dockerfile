FROM kiwix/kiwix-tools:latest

RUN apt-get update && apt-get install -y \
    ocrmypdf \
    imagemagick \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]


