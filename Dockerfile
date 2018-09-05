FROM node:8-alpine

LABEL maintainer="angristan"
LABEL source="https://github.com/angristan/docker-hastebin"

ARG HASTEBIN_VER=master

ENV UID=4242 GID=4242

RUN apk -U upgrade \
    && apk --no-cache add git su-exec \
    && git clone https://github.com/seejohnrun/haste-server.git /app \
    && cd /app \
    && git checkout ${HASTEBIN_VER} \
    && npm install

COPY rootfs /

RUN chmod +x /usr/local/bin/run.sh

VOLUME /app/data

EXPOSE 7777

CMD ["run.sh"]
