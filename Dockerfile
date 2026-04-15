FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    pdf2htmlex \
    kiwix-tools \
    ocrmypdf \
    imagemagick \
    python3 \
    python3-pip \
    && apt-get clean

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
