FROM alpine:3.8

MAINTAINER Nick Lopez <nlopez@gmail.com>

ENV RCLONE_VERSION=1.45
ENV ARCH=amd64

RUN apk --no-cache add ca-certificates fuse wget \
    && cd /tmp \
    && wget -q http://downloads.rclone.org/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-${ARCH}.zip \
    && unzip /tmp/rclone-v${RCLONE_VERSION}-linux-${ARCH}.zip \
    && mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin \
    && rm -r /tmp/rclone* \
    && addgroup rclone \
    && adduser -h /config -s /bin/ash -G rclone -D rclone

USER rclone

VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/rclone"]

CMD ["--version"]
