FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  apt-get install -y \
         openjdk-8-jre-headless \
         python \
         supervisor \
         wget

ENV FILE https://www.collab.net/sites/default/files/downloads/CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz

RUN wget -q ${FILE} -O /tmp/csvn.tgz && \
    mkdir -p /opt/csvn && \
    tar -xzf /tmp/csvn.tgz -C /opt/csvn --strip=1 && \
    rm -rf /tmp/csvn.tgz

ENV RUN_AS_USER collabnet

RUN useradd collabnet && \
    chown -R collabnet.collabnet /opt/csvn && \
    cd /opt/csvn && \
    ./bin/csvn install && \
    mkdir -p ./data-initial && \
    cp -r ./data/* ./data-initial && \
    apt-get clean && \
    rm -rf \
           /tmp/* \
           /var/lib/apt/lists/* \
           /var/tmp/*

EXPOSE 3343 4434 18080

ADD files /

VOLUME /opt/csvn/data

WORKDIR /opt/csvn

ENTRYPOINT ["/config/bootstrap.sh"]
