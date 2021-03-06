FROM ubuntu
MAINTAINER jacksun <345887261@qq.com>

ARG FRP_VERSION=0.21.0

RUN apt update \
    && apt install -y wget

WORKDIR /tmp
RUN set -x \
    && wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar -zxf frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && mv frp_${FRP_VERSION}_linux_amd64 /var/frp \
    && mkdir -p /var/frp/conf \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY frps.ini /var/frp/conf/frps.ini

VOLUME /var/frp/conf

WORKDIR /var/frp
ENTRYPOINT ./frps -c ./conf/frps.ini