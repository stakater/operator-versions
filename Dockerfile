FROM alpine:3.21

WORKDIR /app

RUN apk add dumb-init

COPY disk-cleanup.sh /
RUN chmod +x /disk-cleanup.sh

ENTRYPOINT ["dumb-init", "/disk-cleanup.sh"]
