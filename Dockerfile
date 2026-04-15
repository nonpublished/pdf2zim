FROM ghcr.io/kiwix/kiwix-tools:latest

# Install extra tools you need
RUN apk add --no-cache \
    ocrmypdf \
    imagemagick \
    python3 \
    py3-pip

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
