# Serviio docker
#
# VERSION               0.1
# Run with: docker run --rm --name serviio -d -p 23423:23423/tcp -p 8895:8895/tcp -p 1900:1900/udp riftbit/docker-serviio
# or        docker run --rm --name serviio -t -i -p 23423:23423/tcp -p 8895:8895/tcp -p 1900:1900/udp riftbit/docker-serviio

FROM openjdk:8-jre-alpine AS serviio
MAINTAINER Riftbit ErgoZ <ergozru@riftbit.com>

ARG SERVIIO_VERSION=1.9
ARG FFMPEG_VERSION=3.4

WORKDIR /tmp/ffmpeg

# Prepare APK CDNs
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/testing" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/main" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    apk update

# Install Dependencies
RUN apk add --update build-base curl nasm tar bzip2 fdk-aac \
  zlib-dev yasm-dev lame-dev libogg-dev x264-dev lame-dev musl musl-dev \
  libvpx-dev libvorbis-dev x265-dev freetype-dev fdk-aac-dev pkgconf pkgconf-dev \
  libass-dev libwebp-dev rtmpdump-dev libtheora-dev opus-dev xvidcore-dev xvidcore

# Build ffmpeg and serviio
RUN DIR=$(mktemp -d) && cd ${DIR} && \
  curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxvf - -C . && \
  cd ffmpeg-${FFMPEG_VERSION} && \
  ./configure \
  --enable-version3 --enable-gpl --enable-libfdk-aac --enable-nonfree --enable-small --enable-libmp3lame \
  --enable-libx264 --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis \
  --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc --enable-libxvid \
  --enable-avresample --enable-libfreetype  --enable-libopencore-amrnb --enable-libopencore-amrwb --disable-debug && \
  make && \
  make install && \
  make distclean && \
  cd ${DIR} && \
  curl -s http://download.serviio.org/releases/serviio-${SERVIIO_VERSION}-linux.tar.gz | tar zxvf - -C . && \
  mv serviio-${SERVIIO_VERSION} /opt/serviio && \
  chmod +x /opt/serviio/bin/serviio.sh && \
  rm -rf ${DIR} && \
  apk del build-base curl tar bzip2 x264 openssl nasm && rm -rf /var/cache/apk/*

WORKDIR /opt/serviio

VOLUME ["/opt/serviio/library", "/opt/serviio/plugins", "/opt/serviio/log"]

EXPOSE ["23423:23423/tcp", "8895:8895/tcp", "1900:1900/udp"]

CMD /opt/serviio/bin/serviio.sh

# ENTRYPOINT /opt/serviio/bin/serviio-console.sh
