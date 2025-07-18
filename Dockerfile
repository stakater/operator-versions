FROM registry.redhat.io/openshift4/ose-cli:v4.15

WORKDIR /app

RUN dnf -y update && dnf clean all
RUN dnf install -y jq && dnf clean all

COPY ./get-versions.sh /
RUN chmod +x /get-versions.sh

ENTRYPOINT ["/get-versions.sh"]

LABEL name="Stakater Operator Versions" \
      maintainer="Stakater <hello@stakater.com>" \
      vendor="Stakater" \
      release="1" \
      summary="Operator Versions"

CMD ["-h"]
