# docker-serviio

[![](http://serviio.org/images/serviio.png)](http://serviio.org/) 

[![](https://images.microbadger.com/badges/image/soerentsch/serviio.svg)](https://microbadger.com/images/soerentsch/serviio) [![Docker Pulls](https://img.shields.io/docker/pulls/soerentsch/serviio)](https://hub.docker.com/r/soerentsch/serviio/) [![Docker Stars](https://img.shields.io/docker/stars/soerentsch/serviio)](https://hub.docker.com/r/soerentsch/serviio/) [![GitHub last commit](https://img.shields.io/github/last-commit/soerentsch/docker-serviio/dockerhub.svg)](https://github.com/soerentsch/docker-serviio/dockerhub) 
  
Link on docker hub: [soerentsch/serviio](https://hub.docker.com/r/soerentsch/serviio/)

Link on github: [soerentsch/docker-serviio](https://github.com/soerentsch/docker-serviio)

Started as a fork of [riftbit/docker-serviio](https://github.com/riftbit/docker-serviio), just to provide the newest security and performance patches.

### Build Args

 - `SERVIIO_VERSION` = 2.2.1
 - `FFMPEG_VERSION` = 5.0.1
 - `JASPER_VERSION` = 3.0.3


### Exposed Ports

 - `1900:1900/udp` - DLNA
 - `8895:8895/tcp` - Serviio Content Delivery
 - `23423:23423/tcp` - HTTP/1.1 /console /rest
 - `23424:23424/tcp` - HTTP/1.1 /cds /mediabrowser

#### Optional SSL Ports (see the Serviio manual)
 - `23523:23523/tcp` - HTTPS/1.1 /console /rest
 - `23524:23524/tcp` - HTTPS/1.1 /cds /mediabrowser

### Recomended Volumes (no auto mounting now)
 - `/opt/serviio/config`
 - `/opt/serviio/library`
 - `/opt/serviio/plugins`
 - `/opt/serviio/log`
 - `/media/serviio` - put media content here and add in serviio gui this path


### Container Changelog (dd.mm.yy)
 - **23.05.2022** - Update to FFmpeg 5.0.1
 - **04.05.2022** - Upgrade OpenJDK from 8 to 17
 - **14.04.2022** - Added alpine edge repository for a newer OpenJDK-JRE version
 - **12.04.2022** - Update alpine to 3.15.4
 - **16.03.2022** - Update Jasper to 3.0.3
 - **16.02.2022** - Update Jasper to 3.0.2
 - **14.02.2022** - Update Jasper to 3.0.1
 - **09.02.2022** - Update Jasper to 3.0.0
 - **24.01.2022** - Update FFmpeg to 5.0
 - **18.12.2021** - Update dcraw
 - **17.12.2021** - Update alpine to 3.15, FFmpeg to 4.4.1, Jasper to 2.0.33
 - **16.12.2021** - Update Serviio version to 2.2.1 (fixed CVE-2021-44228 vulnerability caused by Log4j library)
 - **01.10.2021** - Update Serviio version to 2.2
 - **19.03.2021** - Update FFmpeg to 4.3.2, add healthcheck (PR #19), cleanup volumes (mount only if you need it)
 - **07.12.2020** - Update alpine to 3.12, fix dcraw.c build (add jasper build from source), removed config volume
 - **28.05.2020** - Update Serviio version to 2.1, alpine to 3.11, ffmpeg to 4.2, fix dcraw.c path
 - **27.05.2019** - Update Serviio version to 2.0 and alpine to latest on build date
 - **19.12.2018** - Update Serviio version to 1.10.1 and ffmpeg to 4.1 and alpine to latest on build date
 - **09.05.2018** - Update Serviio version from 1.9.1 to 1.9.2
 - **02.03.2018** - Update Serviio version from 1.9 to 1.9.1
 - **12.01.2018** - dcraw now supported. dockerfile cleanups. many fixes and updates
