# Serviio docker
#
# Run with: docker run --rm --name serviio -d -p 23423:23423/tcp -p 23424:23424/tcp -p 8895:8895/tcp -p 1900:1900/udp -v /etc/localtime:/etc/localtime:ro soerentsch/serviio
ARG ALPINE_VERSION=3.16

FROM alpine:${ALPINE_VERSION}

ARG BUILD_DATE
ARG BUILD_VCS_REF

ARG SERVIIO_VERSION=2.2.1
ARG FFMPEG_VERSION=5.0.1
ARG JASPER_VERSION=3.0.5
ARG JRE_PACKAGE=openjdk17-jre

LABEL \
	org.label-schema.build-date="${BUILD_DATE}" \
	org.label-schema.description="DLNA Serviio Container" \
	org.label-schema.name="DLNA Serviio Container" \
	org.label-schema.schema-version="1.0" \
	org.label-schema.url="https://hub.docker.com/r/soerentsch/serviio/" \
	org.label-schema.vcs-ref="${BUILD_VCS_REF}" \
	org.label-schema.vcs-url="https://github.dev/soerentsch/docker-serviio/" \
	org.label-schema.vendor="[soerentsch] Soeren <soerentsch@gmail.com>" \
	org.label-schema.version="${SERVIIO_VERSION}" \
	maintainer="[soerentsch] Soeren <soerentsch@gmail.com>"

ENV JAVA_HOME="/usr"

# Prepare APK CDNs
RUN set -ex \
	&& echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&& echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
	&& apk update && apk upgrade \
	&& apk add --no-cache --update \
		alsa-lib \ 
		aom-libs \ 
		fdk-aac \ 
		gnutls \ 
		lame \ 
		lcms2 \ 
		libass \ 
		libbz2 \ 
		libdav1d \ 
		libdrm \ 
		libjpeg-turbo \ 
		libpulse \ 
		librist \ 
		librtmp \ 
		libsrt \ 
		libstdc++ \ 
		libssh \ 
		libtheora \ 
		libva \ 
		libvdpau \ 
		libvorbis \ 
		libvpx \ 
		libwebp \ 
		libx11 \ 
		libxcb \ 
		musl \ 
		${JRE_PACKAGE} \ 
		openssl \ 
		opus \ 
		sdl2 \ 
		soxr \ 
		tar \ 
		v4l-utils-libs \ 
		vidstab \ 
		x264-libs \ 
		x265-libs \ 
		xvidcore \ 
		zlib \ 
	&& apk add --no-cache --update --virtual=.build-dependencies \
		alsa-lib-dev \ 
		aom-dev \ 
		bzip2-dev \ 
		cmake \ 
		coreutils \ 
		fdk-aac-dev \ 
		gcc \ 
		gnutls-dev \ 
		g++ \ 
		imlib2-dev \ 
		lame-dev \ 
		lcms2-dev \ 
		libass-dev \ 
		libdrm-dev \ 
		libgcc \ 
		libjpeg-turbo-dev \ 
		librist-dev \ 
		libsrt-dev \ 
		libssh-dev \ 
		libtheora-dev \ 
		libva-dev \ 
		libvdpau-dev \ 
		libvorbis-dev \ 
		libvpx-dev \ 
		libwebp-dev \ 
		libxfixes-dev \ 
		opus-dev \ 
		perl-dev \ 
		pulseaudio-dev \ 
		rtmpdump-dev \ 
		samurai \ 
		sdl2-dev \ 
		soxr-dev \ 
		v4l-utils-dev \ 
		x264-dev \ 
		x265-dev \ 
		xvidcore-dev \ 
		yasm \ 
		zlib-dev \ 
		dav1d-dev \ 
		vidstab-dev \ 
		vulkan-loader-dev \
### Create WORKDIR and get all ingredients		
	&& DIR=$(mktemp -d) && cd ${DIR} \
	&& wget https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz && tar xvf ffmpeg-${FFMPEG_VERSION}.tar.gz \
	&& wget https://github.com/jasper-software/jasper/releases/download/version-${JASPER_VERSION}/jasper-${JASPER_VERSION}.tar.gz && tar xvf jasper-${JASPER_VERSION}.tar.gz \
	&& wget https://raw.githubusercontent.com/soerentsch/dcraw/master/dcraw.c \
	&& wget https://download.serviio.org/releases/serviio-${SERVIIO_VERSION}-linux.tar.gz && tar xvf serviio-${SERVIIO_VERSION}-linux.tar.gz \
### Build ffmpeg	
	&& cd ${DIR} \
	&& cd ffmpeg-${FFMPEG_VERSION} \
	&& ./configure \
		--disable-doc \
		--disable-debug \
		--disable-shared \
		--enable-avfilter \
		--enable-gnutls \
		--enable-gpl \
		--enable-libass \
		--enable-libfdk-aac \
		--enable-libfreetype \
		--enable-libmp3lame \
		--enable-libopus \
		--enable-librtmp \
		--enable-libtheora \
		--enable-libv4l2 \
		--enable-libvorbis \
		--enable-libvpx \
		--enable-libwebp \
		--enable-libx264 \
		--enable-libx265 \
		--enable-libxcb \
		--enable-libxvid \
		--enable-nonfree \
		--enable-pic \
		--enable-pthreads \
		--enable-postproc \
		--enable-static \
		--enable-small \
		--enable-version3 \
		--enable-vaapi \
		--extra-libs="-lpthread -lm" \
		--prefix=/usr \
	&& make -j$(nproc) \
	&& make install \
	&& gcc -o tools/qt-faststart $CFLAGS tools/qt-faststart.c \
	&& install -D -m755 tools/qt-faststart /usr/bin/qt-faststart \
	&& make distclean \
### Build Jasper	
	&& cd ${DIR} \
	&& cd jasper-${JASPER_VERSION} \
	&& mkdir ./obj \
	&& cd ./obj \
	&& cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=/usr/lib \
	&& make -j$(nproc) \
	&& make install \
### Build dcraw	
	&& cd ${DIR} \
	&& gcc -o dcraw -O4 dcraw.c -lm -ljasper -ljpeg -llcms2 \
	&& cp dcraw /usr/bin/dcraw \
	&& chmod +x /usr/bin/dcraw \
### Install Serviio	
	&& cd ${DIR} \
	&& mkdir -p /opt/serviio \
	&& mkdir -p /media/serviio \
	&& mv ./serviio-${SERVIIO_VERSION}/* /opt/serviio \
	&& chmod +x /opt/serviio/bin/serviio.sh \
	&& mkdir -p /opt/serviio/log \
	&& touch /opt/serviio/log/serviio.log \
### Cleanup	
	&& rm -rf ${DIR} \
	&& apk del --purge .build-dependencies \
	&& rm -rf /var/cache/apk/*

VOLUME ["/opt/serviio/config", "/opt/serviio/library",  "/opt/serviio/log", "/opt/serviio/plugins", "/media/serviio"]

# DLNA
EXPOSE 1900/udp
# Serviio Content Delivery
EXPOSE 8895/tcp
# HTTP/1.1 /console /rest
EXPOSE 23423/tcp 
# HTTP/1.1 /cds /mediabrowser
EXPOSE 23424/tcp
# HTTPS/1.1 /console /rest
EXPOSE 23523/tcp
# HTTPS/1.1 /cds /mediabrowser
EXPOSE 23524/tcp

HEALTHCHECK --start-period=5m CMD wget --quiet --tries=1 -O /dev/null --server-response --timeout=5 http://127.0.0.1:23423/console/ || exit 1

CMD tail -f /opt/serviio/log/serviio.log & /opt/serviio/bin/serviio.sh
