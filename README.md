# docker-serviio

[![](http://serviio.org/images/serviio.png)](http://serviio.org/) 


[![](https://images.microbadger.com/badges/version/riftbit/serviio.svg)](https://microbadger.com/images/riftbit/serviio) 
[![](https://images.microbadger.com/badges/image/riftbit/serviio.svg)](https://microbadger.com/images/riftbit/serviio) 
[![](https://img.shields.io/docker/pulls/riftbit/serviio.svg)](https://hub.docker.com/r/riftbit/serviio/) 
[![](https://img.shields.io/docker/stars/riftbit/serviio.svg)](https://hub.docker.com/r/riftbit/serviio/) 


> :fire: dcraw not supported at this moment.
  
Link on docker hub: [riftbit/serviio](https://hub.docker.com/r/riftbit/serviio/)

Link on github: [riftbit/docker-serviio](https://github.com/riftbit/docker-serviio)

### Build Args

```
ARG SERVIIO_VERSION=1.9 FFMPEG_VERSION=3.4.1
```

### Exposed Ports

```
23423:23423/tcp
8895:8895/tcp
1900:1900/udp
```

### Volumes
 - /opt/serviio/library
 - /opt/serviio/plugins
 - /opt/serviio/log
 - /media/serviio - put media content here and add in serviio gui this path
