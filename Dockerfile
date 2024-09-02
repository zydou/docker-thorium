FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm
ARG THORIUM_DEB_URL
# title
ENV TITLE=Thorium

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/chromium-logo.png && \
  echo "**** install CJK fonts ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends fonts-wqy-zenhei && \
  echo "**** install Thorium ****" && \
  curl -o /tmp/thorium.deb -sSLf $THORIUM_DEB_URL && \
  dpkg -i /tmp/thorium.deb || apt-get -y --fix-broken --no-install-recommends install && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
