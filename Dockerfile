# Serviio docker
#
# VERSION               0.1
# Run with: docker run --rm --name serviio -d -p 23423:23423/tcp -p 8895:8895/tcp -p 1900:1900/udp riftbit/docker-serviio
# or        docker run --rm --name serviio -t -i -p 23423:23423/tcp -p 8895:8895/tcp -p 1900:1900/udp riftbit/docker-serviio

FROM openjdk:8-jre-alpine
MAINTAINER Riftbit ErgoZ <ergozru@riftbit.com>

# Prepare APK CDNs
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/main" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    apk update && apk upgrade && \
    apk add --update build-base curl nasm tar bzip2 fdk-aac \
        zlib-dev yasm-dev lame-dev libogg-dev x264-dev lame-dev musl musl-dev \
        libvpx-dev libvorbis-dev x265-dev freetype-dev fdk-aac-dev pkgconf pkgconf-dev libxcb \
        libass-dev libwebp-dev rtmpdump-dev libtheora-dev opus-dev xvidcore-dev xvidcore libxcb-dev


ARG FFMPEG_VERSION=3.4.1

# Build ffmpeg 
RUN DIR=$(mktemp -d) && cd ${DIR} && \
  curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxf - -C . && \
  cd ffmpeg-${FFMPEG_VERSION} && \
  ./configure --disable-doc \
  --enable-version3 --enable-gpl --enable-libfdk-aac --enable-nonfree --enable-libmp3lame \
  --enable-libx264 --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis \
  --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc --enable-libxvid \
  --enable-avresample --enable-libfreetype --enable-libxcb --disable-debug && \
  make && \
  make install && \
  make distclean && \
  apk del build-base nasm && rm -rf /var/cache/apk/* && \

ARG SERVIIO_VERSION=1.9

# Build Serviio
RUN cd ${DIR} && \
  curl -s http://download.serviio.org/releases/serviio-${SERVIIO_VERSION}-linux.tar.gz | tar zxvf - -C . && \
  mkdir -p /opt/serviio && \
  mkdir -p /media/serviio && \
  mv ./serviio-${SERVIIO_VERSION}/* /opt/serviio && \
  chmod +x /opt/serviio/bin/serviio.sh && \
  rm -rf ${DIR}
  
VOLUME ["/opt/serviio/library", "/opt/serviio/plugins", "/opt/serviio/log", "/media/serviio"]

EXPOSE 23423:23423/tcp
EXPOSE 8895:8895/tcp
EXPOSE 1900:1900/udp

CMD /opt/serviio/bin/serviio.sh
