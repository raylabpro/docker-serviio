# docker-serviio

[![](http://serviio.org/images/serviio.png)](http://serviio.org/) 

[![](https://images.microbadger.com/badges/version/riftbit/serviio.svg)](https://microbadger.com/images/riftbit/serviio) [![](https://images.microbadger.com/badges/image/riftbit/serviio.svg)](https://microbadger.com/images/riftbit/serviio) [![Docker Pulls](https://img.shields.io/docker/pulls/riftbit/serviio.svg)](https://hub.docker.com/r/riftbit/serviio/) [![Docker Stars](https://img.shields.io/docker/stars/riftbit/serviio.svg)](https://hub.docker.com/r/riftbit/serviio/) [![GitHub last commit](https://img.shields.io/github/last-commit/riftbit/docker-serviio.svg)](https://github.com/riftbit/docker-serviio) [![Docker Build Status](https://img.shields.io/docker/build/riftbit/serviio.svg)](https://hub.docker.com/r/riftbit/serviio/)
  
Link on docker hub: [riftbit/serviio](https://hub.docker.com/r/riftbit/serviio/)

Link on github: [riftbit/docker-serviio](https://github.com/riftbit/docker-serviio)

### Build Args

 - **VERSION** = 1.9 - serviio version
 - **FFMPEG_VERSION** = 3.4.1


### Exposed Ports

 - **1900:1900/udp**
 - **8895:8895/tcp**
 - **23423:23423/tcp** - HTTP/1.1 /console /rest
 - **23523:23523/tcp** - HTTPS/1.1 /console /rest
 - **23424:23424/tcp** - HTTP/1.1 /cds /mediabrowser
 - **23524:23524/tcp** - HTTPS/1.1 /cds /mediabrowser

### Volumes
 - **/opt/serviio/config**
 - **/opt/serviio/library**
 - **/opt/serviio/plugins**
 - **/opt/serviio/log**
 - **/media/serviio** - put media content here and add in serviio gui this path


### Container Changelog (dd.mm.yy)
 - **12.01.18** - dcraw now supported. dockerfile cleanups. many fixes and updates
