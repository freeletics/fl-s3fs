FROM alpine:3.6
LABEL maintainer="Freeletics GmbH <operations@freeletics.com>"

ARG S3FS_VERSION=v1.82

ENV MOUNT_POINT=/S3

WORKDIR /tmp/s3fs-fuse

RUN apk add --update --no-cache --virtual .runtime-deps \
        alpine-sdk \
        autoconf \
        automake \
        build-base \
        ca-certificates \
        curl-dev \
        fuse \
        fuse-dev \
        git \
        libressl-dev  \
        libxml2-dev  \  
    && git clone https://github.com/s3fs-fuse/s3fs-fuse.git . \
    && git checkout "tags/${S3FS_VERSION}" \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make \
    && make install 

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
