FROM alpine:3.21

WORKDIR /app

RUN apk add dumb-init

COPY get-versions.sh /
RUN chmod +x /get-versions.sh

ENTRYPOINT ["dumb-init", "/get-versions.sh"]
