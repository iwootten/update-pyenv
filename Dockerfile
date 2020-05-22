# Container image that runs your code
FROM alpine:3.10

RUN apk update \
 && apk add curl \
 && apk add bash \
 && apk add jq \
 && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]