FROM registry.redhat.io/openshift4/ose-cli:v4.15

WORKDIR /app

RUN apk add dumb-init

COPY get-versions.sh /
RUN chmod +x /get-versions.sh

ENTRYPOINT ["dumb-init", "--"]

CMD ["/get-versions.sh"]
